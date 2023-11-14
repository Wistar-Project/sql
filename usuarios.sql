use wistar;

-- GRANT SELECT ON traducciones TO "wistar-traducciones";

/* USUARIOS Y PERMISOS 
- Api de autenticación: cristian.aguirre
- Api de almacenes: francisco.cazeneuve
- Api de tránsito: wistar-transito
- Api de traducciones: wistar-traducciones
- Backoffice: fabrizio.cobucci
*/

/* api de autenticación */
GRANT SELECT, INSERT ON users TO "christian.aguirre";
GRANT SELECT, INSERT ON personas TO "christian.aguirre";
GRANT INSERT ON gerentes TO "christian.aguirre";
GRANT INSERT ON conductores TO "christian.aguirre";
GRANT INSERT ON funcionarios TO "christian.aguirre";
GRANT INSERT ON administradores TO "christian.aguirre";
GRANT SELECT, INSERT, UPDATE, DELETE ON oauth_clients TO "christian.aguirre";
GRANT SELECT, INSERT, UPDATE, DELETE ON password_resets TO "christian.aguirre";
GRANT SELECT, INSERT, UPDATE, DELETE ON failed_jobs TO "christian.aguirre";
GRANT SELECT, INSERT, UPDATE, DELETE ON personal_access_tokens TO "christian.aguirre";
GRANT SELECT, INSERT, UPDATE, DELETE ON migrations TO "christian.aguirre";
GRANT SELECT, INSERT, UPDATE, DELETE ON oauth_access_tokens TO "christian.aguirre";
GRANT SELECT, INSERT, UPDATE, DELETE ON oauth_auth_codes TO "christian.aguirre";
GRANT SELECT, INSERT, UPDATE, DELETE ON oauth_personal_access_clients TO "christian.aguirre";
GRANT SELECT, INSERT, UPDATE, DELETE ON oauth_refresh_tokens TO "christian.aguirre";


/* fabrizio.cobucci */

/* wistar-traducciones */
GRANT SELECT ON traducciones TO "wistar-traducciones";