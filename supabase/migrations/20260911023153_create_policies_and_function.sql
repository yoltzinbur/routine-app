CREATE FUNCTION shares_hub_with(target_user uuid)
  RETURNS BOOLEAN
  LANGUAGE sql
  SECURITY DEFINER
  SET search_path = public
  AS $$
    SELECT EXISTS (
      SELECT 1
      FROM hub_members a
      JOIN hub_members b
      ON a.id_hub = b.id_hub
      WHERE a.user_id = auth.uid() AND b.user_id = target_user
    );
  $$;

CREATE POLICY rls_select_routine_member ON routine_blocks
  FOR SELECT
  TO authenticated
  USING (
    user_id = auth.uid()
    OR
    shares_hub_with(user_id)
  );

CREATE POLICY rls_insert_routine_creator ON routine_blocks
  FOR INSERT
  TO authenticated
  WITH CHECK (
    user_id = auth.uid()
  );

CREATE POLICY rls_update_routine_creator ON routine_blocks
  FOR UPDATE
  TO authenticated
  USING (
    user_id = auth.uid()
  )
  WITH CHECK (
    user_id = (
      SELECT r.user_id FROM routine_blocks r 
      WHERE r.id_routine = routine_blocks.id_routine
    )
  );

CREATE POLICY rls_delete_routine_creator ON routine_blocks
  FOR DELETE
  TO authenticated
  USING (
    user_id = auth.uid()
  );