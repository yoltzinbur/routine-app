ALTER TABLE activity_log DROP CONSTRAINT activity_log_check;
ALTER TABLE activity_log ADD CONSTRAINT activity_log_check 
  CHECK (num_nonnulls(id_event, id_routine, id_note) <= 1);