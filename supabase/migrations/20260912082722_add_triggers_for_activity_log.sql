CREATE FUNCTION log_activity()
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
        v_id_event := v_row.id_event;
      
      WHEN 'routine_blocks' THEN 
        v_entity_type := 'rutina'::activity_entity;
        v_id_routine := v_row.id_routine;
      
      WHEN 'notes' THEN 
        v_entity_type := 'nota'::activity_entity;
        v_id_note := v_row.id_note;
    END CASE;

    v_title := v_row.title;

    IF TG_TABLE_NAME IN ('events', 'notes')
        AND TG_OP = 'UPDATE'
        AND OLD.shared IS TRUE
        AND NEW.shared IS NOT TRUE 
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

    RETURN v_row;
  END;
  $$;


CREATE TRIGGER trg_after_i_u_d_events
  AFTER INSERT OR UPDATE OR DELETE ON events
  FOR EACH ROW
  EXECUTE FUNCTION log_activity();

CREATE TRIGGER trg_after_i_u_d_routine
  AFTER INSERT OR UPDATE OR DELETE ON routine_blocks
  FOR EACH ROW
  EXECUTE FUNCTION log_activity();

CREATE TRIGGER trg_after_i_u_d_notes
  AFTER INSERT OR UPDATE OR DELETE ON notes
  FOR EACH ROW
  EXECUTE FUNCTION log_activity();