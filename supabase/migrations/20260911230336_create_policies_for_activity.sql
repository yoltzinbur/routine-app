CREATE POLICY rls_select_log_member ON activity_log
  FOR SELECT
  TO authenticated
  USING (
    is_hub_member(id_hub)
  );