CREATE EXTENSION IF NOT EXISTS btree_gist;

CREATE TYPE timerange AS RANGE (subtype = time);

ALTER TABLE routine_blocks ADD CONSTRAINT no_overlapping_blocks
  EXCLUDE USING gist (
    user_id WITH =,
    day WITH =,
    timerange(time_started, time_ended) WITH &&
  );