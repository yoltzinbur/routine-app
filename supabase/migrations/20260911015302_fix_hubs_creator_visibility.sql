DROP POLICY rls_select_hubs_member ON hubs;
CREATE POLICY rls_select_hubs_member ON hubs
  FOR SELECT
  TO authenticated
  USING (
    is_hub_member(id_hub)
    OR
    created_by = auth.uid()
  );

DROP POLICY rls_update_hubs_member ON hubs;
CREATE POLICY rls_update_hubs_member ON hubs
  FOR UPDATE
  TO authenticated
  USING (
    is_hub_member(id_hub)
    OR
    created_by = auth.uid()
  )