CREATE FUNCTION join_hub_with_code(hub_code VARCHAR)
  RETURNS UUID
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path = public
  AS $$
  DECLARE
    v_id_hub UUID;
    v_expires_at TIMESTAMPTZ;
  BEGIN
    SELECT id_hub, expires_at 
    INTO v_id_hub, v_expires_at
    FROM hub_invites
    WHERE code = hub_code; 

    IF NOT FOUND THEN
      RAISE EXCEPTION 'Código inválido: %', hub_code;
    END IF;
    
    IF v_expires_at < now() THEN
      RAISE EXCEPTION 'Código expirado: %', hub_code;
    END IF;

    PERFORM 1
    FROM hub_members
    WHERE user_id = auth.uid()
      AND id_hub = v_id_hub;

    IF FOUND THEN
      RAISE EXCEPTION 'Ya eres miembro.';
    END IF;

    INSERT INTO hub_members (
      id_hub, user_id
    ) VALUES (
      v_id_hub, auth.uid()
    );

    RETURN v_id_hub;
  END;
  $$;

REVOKE EXECUTE ON FUNCTION join_hub_with_code(VARCHAR) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION join_hub_with_code(VARCHAR) TO authenticated;