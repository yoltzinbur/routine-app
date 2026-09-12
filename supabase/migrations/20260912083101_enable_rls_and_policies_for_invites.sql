ALTER TABLE hub_invites ENABLE ROW LEVEL SECURITY;

CREATE POLICY rls_insert_invites_creator ON hub_invites
  FOR INSERT
  TO authenticated
  WITH CHECK (
    (
      SELECT created_by FROM hubs 
      WHERE id_hub = hub_invites.id_hub
    ) = auth.uid()
    AND
    created_by = auth.uid()
  );

CREATE POLICY rls_select_invites_member ON hub_invites
  FOR SELECT
  TO authenticated
  USING (
    is_hub_member(id_hub)
  );

CREATE POLICY rls_delete_invites_creator ON hub_invites
  FOR DELETE
  TO authenticated
  USING (
    created_by = auth.uid()
  );

CREATE TRIGGER trg_before_insert_invites 
  BEFORE INSERT ON hub_invites
  FOR EACH ROW
  EXECUTE FUNCTION set_created_by();