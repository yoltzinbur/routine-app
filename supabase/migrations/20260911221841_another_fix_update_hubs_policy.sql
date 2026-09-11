DROP POLICY rls_update_hubs_member ON hubs;
CREATE POLICY rls_update_hubs_member ON hubs
  FOR UPDATE
  TO authenticated
  USING (
    is_hub_member(id_hub)
    OR
    created_by = auth.uid()
  ) WITH CHECK (
    created_by IS NOT DISTINCT FROM (
      SELECT h.created_by FROM hubs h
      WHERE h.id_hub = hubs.id_hub
    )
  );