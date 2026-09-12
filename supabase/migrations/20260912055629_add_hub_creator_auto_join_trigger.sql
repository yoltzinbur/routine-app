CREATE FUNCTION self_join_hub()
  RETURNS TRIGGER
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path = public
  AS $$
  BEGIN
    INSERT INTO hub_members(id_hub, user_id)
    VALUES (NEW.id_hub, NEW.created_by);

    RETURN NEW;
  END;
  $$;

CREATE TRIGGER trg_after_insert_hubs
  AFTER INSERT ON hubs
  FOR EACH ROW
  EXECUTE FUNCTION self_join_hub();