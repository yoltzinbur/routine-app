CREATE FUNCTION set_user_id()
  RETURNS TRIGGER
  LANGUAGE plpgsql
  AS $$
  BEGIN
    NEW.user_id = auth.uid();
    RETURN NEW;
  END;
  $$;

CREATE FUNCTION set_created_by()
  RETURNS TRIGGER
  LANGUAGE plpgsql
  AS $$
  BEGIN
    NEW.created_by = auth.uid();
    RETURN NEW;
  END;
  $$;

CREATE TRIGGER trg_before_insert_hubs
  BEFORE INSERT ON hubs
  FOR EACH ROW
  EXECUTE FUNCTION set_created_by();

CREATE TRIGGER trg_before_insert_hub_member
  BEFORE INSERT ON hub_members
  FOR EACH ROW
  EXECUTE FUNCTION set_user_id();

CREATE TRIGGER trg_before_insert_routine
  BEFORE INSERT ON routine_blocks
  FOR EACH ROW
  EXECUTE FUNCTION set_user_id();

CREATE TRIGGER trg_before_insert_events
  BEFORE INSERT ON events
  FOR EACH ROW
  EXECUTE FUNCTION set_user_id();

CREATE TRIGGER trg_before_insert_notes
  BEFORE INSERT ON notes
  FOR EACH ROW
  EXECUTE FUNCTION set_user_id();