-- Agregar las RLS

ALTER TABLE hubs ENABLE ROW LEVEL SECURITY;
ALTER TABLE hub_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE routine_blocks ENABLE ROW LEVEL SECURITY;
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
ALTER TABLE notes ENABLE ROW LEVEL SECURITY;
ALTER TABLE activity_log ENABLE ROW LEVEL SECURITY;

-- Solucionar un detallito con el Hubs

ALTER TABLE hubs ADD COLUMN created_by UUID REFERENCES auth.users(id) ON DELETE SET NULL;

-- Función para revisar si estamos en el mismo Hub

CREATE FUNCTION is_hub_member(check_hub_id uuid)
RETURNS boolean
LANGUAGE sql 
SECURITY DEFINER -- Se ejecuta con los permisos de quien la crea (yo: admin :D)
SET search_path = public -- Práctica de seguridad para que no se pasen de listos queriendo irse a otros lados que no
AS $$
  SELECT EXISTS (
    SELECT 1 FROM hub_members WHERE id_hub = check_hub_id AND user_id = auth.uid() 
  );
$$;

-- Crear las Policies de Hubs

CREATE POLICY rls_select_hubs_member ON hubs
  FOR SELECT
  TO authenticated
  USING (is_hub_member(id_hub)); -- USING y WITH CHECK siempre llevan paréntesis

CREATE POLICY rls_insert_hubs_auth ON hubs
  FOR INSERT
  TO authenticated
  WITH CHECK (created_by = auth.uid()); -- Una Policy de Insert nunca lleva USING, puro WITH CHECK; establece qué puedes dejar como resultado 

CREATE POLICY rls_update_hubs_member ON hubs
  FOR UPDATE
  TO authenticated
  USING (is_hub_member(id_hub));

CREATE POLICY rls_delete_hubs_creator_or_someone ON hubs
  FOR DELETE
  TO authenticated
  USING (
    created_by = auth.uid()
    OR 
    (
      created_by IS NULL 
      AND
      is_hub_member(id_hub) 
    ) 
  );

-- Crear las Policies de hub_members

CREATE POLICY rls_select_members_member ON hub_members
  FOR SELECT
  TO authenticated
  USING (is_hub_member(id_hub));

CREATE POLICY rls_insert_members_auth ON hub_members
  FOR INSERT
  TO authenticated
  WITH CHECK (user_id = auth.uid());

CREATE POLICY rls_delete_members_members ON hub_members
  FOR DELETE
  TO authenticated
  USING (user_id = auth.uid());