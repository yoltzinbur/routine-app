DROP POLICY rls_update_events_member ON events;
CREATE POLICY rls_update_events_member ON events
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
      SELECT e.id_hub FROM events e 
      WHERE e.id_event = events.id_event
    )
    AND user_id IS NOT DISTINCT FROM (
      SELECT e.user_id FROM events e
      WHERE e.id_event = events.id_event
    )
    AND (
      user_id = auth.uid()
      OR shared IS NOT DISTINCT FROM (
        SELECT e.shared FROM events e 
        WHERE e.id_event = events.id_event
      )
    )
  );