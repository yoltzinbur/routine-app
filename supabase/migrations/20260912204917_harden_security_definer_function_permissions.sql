REVOKE EXECUTE ON FUNCTION join_hub_with_code(varchar) FROM anon;
REVOKE EXECUTE ON FUNCTION is_hub_member(uuid) FROM anon;
REVOKE EXECUTE ON FUNCTION log_activity() FROM anon;
REVOKE EXECUTE ON FUNCTION self_join_hub() FROM anon;
REVOKE EXECUTE ON FUNCTION shares_hub_with(uuid) FROM anon;

REVOKE EXECUTE ON FUNCTION is_hub_member(uuid) FROM PUBLIC;
REVOKE EXECUTE ON FUNCTION log_activity() FROM PUBLIC;
REVOKE EXECUTE ON FUNCTION self_join_hub() FROM PUBLIC;
REVOKE EXECUTE ON FUNCTION shares_hub_with(uuid) FROM PUBLIC;

REVOKE EXECUTE ON FUNCTION log_activity() FROM authenticated;
REVOKE EXECUTE ON FUNCTION self_join_hub() FROM authenticated;

GRANT EXECUTE ON FUNCTION join_hub_with_code(varchar) TO authenticated;
GRANT EXECUTE ON FUNCTION is_hub_member(uuid) TO authenticated;
GRANT EXECUTE ON FUNCTION shares_hub_with(uuid) TO authenticated;

ALTER FUNCTION set_user_id() SET search_path = public;
ALTER FUNCTION set_created_by() SET search_path = public;
ALTER FUNCTION set_updated_at() SET search_path = public;