CREATE OR REPLACE FUNCTION log_activity()
  RETURNS TRIGGER
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path = public
  AS $$
  DECLARE
    v_row RECORD;

    v_action action_type;
    v_entity_type activity_entity;

    v_id_event UUID;
    v_id_routine UUID;
    v_id_note UUID;

    v_title VARCHAR(50);
    v_hub RECORD;
  BEGIN
    IF (TG_OP = 'DELETE') THEN
      v_row := OLD;
    ELSE 
      v_row := NEW;
    END IF;

    CASE TG_OP  
      WHEN 'INSERT' THEN v_action := 'creado'::action_type;
      WHEN 'UPDATE' THEN v_action := 'editado'::action_type;
      WHEN 'DELETE' THEN v_action := 'eliminado'::action_type;
    END CASE;

    IF TG_TABLE_NAME IN ('events', 'notes') THEN 
      IF (
        TG_OP IN ('INSERT', 'DELETE') 
        AND v_row.shared IS NOT TRUE
      ) OR (
        TG_OP = 'UPDATE' 
        AND OLD.shared IS NOT TRUE 
        AND NEW.shared IS NOT TRUE
      ) 
      THEN RETURN NULL;
      END IF;
    END IF;

    CASE TG_TABLE_NAME
      WHEN 'events' THEN 
        v_entity_type := 'evento'::activity_entity;
        IF TG_OP != 'DELETE' THEN
          v_id_event := v_row.id_event;
        END IF;
      
      WHEN 'routine_blocks' THEN 
        v_entity_type := 'rutina'::activity_entity;
        IF TG_OP != 'DELETE' THEN
          v_id_routine := v_row.id_routine;
        END IF;
      
      WHEN 'notes' THEN 
        v_entity_type := 'nota'::activity_entity;
        IF TG_OP != 'DELETE' THEN
          v_id_note := v_row.id_note;
        END IF;
    END CASE;

    v_title := v_row.title;

    IF TG_TABLE_NAME IN ('events', 'notes') THEN
      IF TG_OP = 'UPDATE' AND OLD.shared IS TRUE AND NEW.shared IS NOT TRUE 
        THEN v_title := OLD.title;
      END IF;

      INSERT INTO activity_log (
        id_hub, 
        user_id, 
        entity_type, 
        action, 
        entity_title,
        id_event,
        id_routine,
        id_note
      ) VALUES (
        v_row.id_hub,
        auth.uid(),
        v_entity_type,
        v_action,
        v_title,
        v_id_event,
        v_id_routine,
        v_id_note
      );
    ELSE
      FOR v_hub IN SELECT id_hub FROM hub_members WHERE user_id = auth.uid() LOOP
        INSERT INTO activity_log (
          id_hub, 
          user_id, 
          entity_type, 
          action, 
          entity_title,
          id_event,
          id_routine,
          id_note
        ) VALUES (
          v_hub.id_hub,
          auth.uid(),
          v_entity_type,
          v_action,
          v_title,
          v_id_event,
          v_id_routine,
          v_id_note
        );
      END LOOP;
    END IF;

    RETURN v_row;
  END;
  $$;