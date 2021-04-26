-- Places for events to happen in
CREATE TABLE spaces (
  space_id SERIAL PRIMARY KEY,
  parent_id integer REFERENCES spaces,
  name text NOT NULL,
  description text,
  size integer
);

-- Things that events may need, possibly attached to specific spaces
CREATE TABLE features (
  feature_id SERIAL PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE space_features (
  space_id integer NOT NULL REFERENCES spaces,
  feature_id integer NOT NULL REFERENCES features
);

-- Collections of events, also allowing track-level access control
CREATE TABLE tracks (
  track_id SERIAL PRIMARY KEY,
  name text NOT NULL,
  read_protected bool,
  write_protected bool
);

CREATE TABLE tags (
  tag_id SERIAL PRIMARY KEY,
  name text NOT NULL,
  parent_id integer REFERENCES tags,
  track_id integer REFERENCES tracks
);

CREATE TABLE types (
  type_id SERIAL PRIMARY KEY,
  name text NOT NULL,
  parent_id integer REFERENCES types
);

-- By default, one of idea/working/ready/dropped
CREATE TABLE event_status (
  status text PRIMARY KEY
);

CREATE TABLE event_status_transitions (
  status text NOT NULL REFERENCES event_status,
  next text NOT NULL REFERENCES event_status
);

CREATE TABLE events (
  event_id SERIAL PRIMARY KEY,
  name text NOT NULL,
  description text,
  public_after timestamptz,
  parent_id integer REFERENCES events,
  space_id integer REFERENCES spaces,
  status text NOT NULL REFERENCES event_status,
  track_id integer REFERENCES tracks,
  type_id integer REFERENCES types,
  min_size integer,
  max_size integer,
  start_time timestamptz,
  duration integer
);

CREATE TABLE event_requirements (
  event_id integer NOT NULL REFERENCES events,
  feature_id integer NOT NULL REFERENCES features
);

CREATE TABLE event_tags (
  event_id integer NOT NULL REFERENCES events,
  tag_id integer NOT NULL REFERENCES tags
);

CREATE TABLE participant_roles (
  role_id SERIAL PRIMARY KEY,
  name text NOT NULL
);

-- By default, one of idea/working/confirmed/declined
CREATE TABLE participant_status (
  status text PRIMARY KEY
);

CREATE TABLE participants (
  event_id integer NOT NULL REFERENCES events,
  participant_id integer NOT NULL REFERENCES kansa.people,
  public bool DEFAULT true,
  role_id integer REFERENCES participant_roles,
  status text NOT NULL REFERENCES participant_status
);

-- A single axis might not be enough here
CREATE TABLE participant_preferences (
  event_id integer NOT NULL REFERENCES events,
  participant_id integer NOT NULL REFERENCES kansa.people,
  preference integer,
  comment text
);

-- Body is a template
CREATE TABLE messages (
  message_id SERIAL PRIMARY KEY,
  subject text NOT NULL,
  body text NOT NULL,
  recipient_filter jsonb
);

CREATE TABLE sent_messages (
  message_id integer NOT NULL REFERENCES messages,
  participant_id integer NOT NULL REFERENCES kansa.people,
  time timestamptz
);

CREATE TABLE permissions (
  user_id integer NOT NULL REFERENCES kansa.people,
  track_id integer REFERENCES tracks,
  admin bool,
  read bool,
  write bool,
  send_messages bool,
  set_state bool
);

CREATE TABLE event_log (
  log_id SERIAL PRIMARY KEY,
  event_id integer NOT NULL REFERENCES events,
  user_id integer NOT NULL REFERENCES kansa.people,
  comment text,
  next jsonb,
  prev jsonb,
  time timestamptz NOT NULL DEFAULT now()
);


-- These last INSERT statements will be separate from the above,
-- to allow for easier customisation
INSERT INTO event_status (status) VALUES
('idea'),
('working'),
('ready');
('dropped');

INSERT INTO event_status_transitions (status, next) VALUES
('idea', 'working'), ('idea', 'dropped'),
('working', 'ready'), ('working', 'dropped'),
('ready', 'working'), ('ready', 'dropped'),
('dropped', 'working');

INSERT INTO participant_status (status) VALUES
('idea'),
('working'),
('confirmed'),
('declined');