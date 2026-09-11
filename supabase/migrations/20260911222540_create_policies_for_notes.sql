CREATE POLICY rls_select_notes_member ON notes
  FOR SELECT
  TO authenticated
  USING (
    is_hub_member(id_hub)
    AND (
      shared = TRUE
      OR user_id = auth.uid()
    )
  );

CREATE POLICY rls_update_notes_member ON notes
  FOR UPDATE
  TO authenticated
  USING (
    is_hub_member(id_hub)
    AND (
      user_id = auth.uid()
      OR shared = TRUE
      OR user_id IS NULL
    )
  )
  WITH CHECK (
    id_hub = (
      SELECT n.id_hub FROM notes n
      WHERE n.id_note = notes.id_note
    ) 
    AND user_id IS NOT DISTINCT FROM (
      SELECT n.user_id FROM notes n
      WHERE n.id_note = notes.id_note
    )
    AND (
      user_id = auth.uid()
      OR shared IS NOT DISTINCT FROM (
        SELECT n.shared FROM notes n
        WHERE n.id_note = notes.id_note
      )
    )
  );

CREATE POLICY rls_delete_notes_member ON notes
  FOR DELETE
  TO authenticated
  USING (
    is_hub_member(id_hub)
    AND (
      user_id = auth.uid()
      OR shared = TRUE
      OR user_id IS NULL
    )
  );

CREATE POLICY rls_insert_notes_creator ON notes
  FOR INSERT
  TO authenticated
  WITH CHECK (
    user_id = auth.uid()
    AND
    is_hub_member(id_hub)
  );