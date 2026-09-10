CREATE TABLE hubs (
  id_hub UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE hub_members (
  id_hub UUID NOT NULL REFERENCES hubs(id_hub) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  joined_at TIMESTAMPTZ NOT NULL DEFAULT now(),

  PRIMARY KEY (id_hub, user_id)
);

CREATE INDEX idx_hub_members_user ON hub_members(user_id);

CREATE TABLE routine_blocks (
  id_routine UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  day day_of_week NOT NULL,
  title VARCHAR(50) NOT NULL,
  color VARCHAR(7) NOT NULL DEFAULT '#4F46E5',
  time_started TIME NOT NULL,
  time_ended TIME NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_routine_blocks_user_day ON routine_blocks(user_id, day);

CREATE TABLE events (
  id_event UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  id_hub UUID NOT NULL REFERENCES hubs(id_hub) ON DELETE CASCADE,
  user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL, 
  title VARCHAR(50) NOT NULL,
  date_started DATE NOT NULL,
  date_ended DATE,
  time_started TIME,
  time_ended TIME,
  activity TEXT,
  reminder BOOL NOT NULL DEFAULT true,
  shared BOOL NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_events_date_started ON events(date_started);

CREATE TABLE notes (
  id_note UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  id_hub UUID NOT NULL REFERENCES hubs(id_hub) ON DELETE CASCADE,
  user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  title VARCHAR(50) NOT NULL,
  type note_types NOT NULL DEFAULT 'Texto'::note_types,
  content TEXT,
  file_url TEXT,
  is_done BOOL,
  id_event UUID REFERENCES events(id_event) ON DELETE SET NULL,
  routine_id UUID REFERENCES routine_blocks(id_routine) ON DELETE SET NULL,
  shared BOOL NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE activity_log (
  id_activity UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  id_hub UUID NOT NULL REFERENCES hubs(id_hub) ON DELETE CASCADE,
  user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  entity_type activity_entity NOT NULL,
  action action_type NOT NULL,
  entity_title VARCHAR(50),
  id_event UUID REFERENCES events(id_event) ON DELETE SET NULL,
  id_routine UUID REFERENCES routine_blocks(id_routine) ON DELETE SET NULL,
  id_note UUID REFERENCES notes(id_note) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  
  CHECK (num_nonnulls(id_event, id_routine, id_note) = 1)
);

CREATE INDEX idx_log_created ON activity_log(created_at);