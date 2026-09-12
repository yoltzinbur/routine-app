CREATE TABLE hub_invites (
  id_invite UUID NOT NULL PRIMARY KEY DEFAULT gen_random_uuid(),
  id_hub UUID NOT NULL REFERENCES hubs(id_hub) ON DELETE CASCADE,
  code VARCHAR(8) NOT NULL UNIQUE DEFAULT encode(extensions.gen_random_bytes(4), 'hex'),
  created_by UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  expires_at TIMESTAMPTZ NOT NULL DEFAULT (now() + INTERVAL '7 days') 
);