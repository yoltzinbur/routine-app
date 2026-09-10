CREATE TYPE day_of_week AS ENUM ('Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado');
CREATE TYPE note_types AS ENUM ('Texto', 'URL', 'To-Do', 'Ubicación', 'Archivo');
CREATE TYPE activity_entity AS ENUM ('evento', 'rutina', 'nota');
CREATE TYPE action_type AS ENUM ('creado', 'editado', 'eliminado');
