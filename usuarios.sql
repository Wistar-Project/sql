use wistar;

-- GRANT SELECT ON traducciones TO "wistar-traducciones";

/* USUARIOS Y PERMISOS 
- Api de autenticación: christian.aguirre
- Api de almacenes: francisco.cazeneuve
- Api de tránsito: wistar-transito
- Api de traducciones: wistar-traducciones
- Backoffice: fabrizio.cobucci
*/

/* api de autenticación */
GRANT SELECT, INSERT, UPDATE, DELETE ON users TO "christian.aguirre";
GRANT SELECT ON personas_roles TO "christian.aguirre";
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

/* Api de almacenes */
GRANT SELECT, INSERT, UPDATE, DELETE ON users TO "francisco.cazeneuve";
GRANT SELECT, INSERT, UPDATE, DELETE ON oauth_clients TO "francisco.cazeneuve";
GRANT SELECT, INSERT, UPDATE, DELETE ON password_resets TO "francisco.cazeneuve";
GRANT SELECT, INSERT, UPDATE, DELETE ON failed_jobs TO "francisco.cazeneuve";
GRANT SELECT, INSERT, UPDATE, DELETE ON personal_access_tokens TO "francisco.cazeneuve";
GRANT SELECT, INSERT, UPDATE, DELETE ON migrations TO "francisco.cazeneuve";
GRANT SELECT, INSERT, UPDATE, DELETE ON oauth_access_tokens TO "francisco.cazeneuve";
GRANT SELECT, INSERT, UPDATE, DELETE ON oauth_auth_codes TO "francisco.cazeneuve";
GRANT SELECT, INSERT, UPDATE, DELETE ON oauth_personal_access_clients TO "francisco.cazeneuve";
GRANT SELECT, INSERT, UPDATE, DELETE ON oauth_refresh_tokens TO "francisco.cazeneuve";
GRANT INSERT ON administradores TO "francisco.cazeneuve";
GRANT INSERT ON funcionarios TO "francisco.cazeneuve";
GRANT INSERT ON personas TO "francisco.cazeneuve";
GRANT SELECT, INSERT ON alojamientos TO "francisco.cazeneuve";
GRANT SELECT, INSERT ON sedes TO "francisco.cazeneuve";
GRANT INSERT ON conductores TO "francisco.cazeneuve";
GRANT SELECT ON personas_roles TO "francisco.cazeneuve";
GRANT SELECT, INSERT ON paquetes TO "francisco.cazeneuve";
GRANT SELECT, INSERT ON lotes TO "francisco.cazeneuve";
GRANT SELECT, INSERT ON lote_formado_por TO "francisco.cazeneuve";
GRANT SELECT, INSERT ON paquete_asignado_a_pickup TO "francisco.cazeneuve";
GRANT SELECT, INSERT ON lote_asignado_a_camion TO "francisco.cazeneuve";

/* Api de tránsito */
GRANT SELECT, INSERT, UPDATE, DELETE ON users TO "wistar-transito";
GRANT SELECT, INSERT, UPDATE, DELETE ON oauth_clients TO "wistar-transito";
GRANT SELECT, INSERT, UPDATE, DELETE ON password_resets TO "wistar-transito";
GRANT SELECT, INSERT, UPDATE, DELETE ON failed_jobs TO "wistar-transito";
GRANT SELECT, INSERT, UPDATE, DELETE ON personal_access_tokens TO "wistar-transito";
GRANT SELECT, INSERT, UPDATE, DELETE ON migrations TO "wistar-transito";
GRANT SELECT, INSERT, UPDATE, DELETE ON oauth_access_tokens TO "wistar-transito";
GRANT SELECT, INSERT, UPDATE, DELETE ON oauth_auth_codes TO "wistar-transito";
GRANT SELECT, INSERT, UPDATE, DELETE ON oauth_personal_access_clients TO "wistar-transito";
GRANT SELECT, INSERT, UPDATE, DELETE ON oauth_refresh_tokens TO "wistar-transito";
GRANT SELECT, INSERT ON alojamientos TO "wistar-transito";
GRANT SELECT, INSERT ON sedes TO "wistar-transito";
GRANT SELECT, INSERT ON personas TO "wistar-transito";
GRANT SELECT ON personas_roles TO "wistar-transito";
GRANT INSERT ON administradores TO "wistar-transito";
GRANT INSERT ON conductores TO "wistar-transito";
GRANT SELECT, INSERT ON paquetes TO "wistar-transito";
GRANT SELECT, INSERT ON lotes TO "wistar-transito";
GRANT INSERT ON vehiculos TO "wistar-transito";
GRANT INSERT ON lote_formado_por TO "wistar-transito";
GRANT INSERT ON gerentes TO "wistar-transito";
GRANT INSERT ON camiones TO "wistar-transito";
GRANT INSERT ON pickups TO "wistar-transito";
GRANT SELECT, INSERT, UPDATE, DELETE ON paquete_asignado_a_pickup TO "wistar-transito";
GRANT SELECT, INSERT, UPDATE, DELETE ON lote_asignado_a_camion TO "wistar-transito";
GRANT SELECT, INSERT ON lote_formado_por TO "wistar-transito";
GRANT SELECT, INSERT, DELETE ON conductor_maneja TO "wistar-transito";
GRANT SELECT ON vehiculos_tipos TO "wistar-transito";
GRANT INSERT ON funcionarios TO "wistar-transito";


/* Api de traducciones */
GRANT SELECT ON traducciones TO "wistar-traducciones";
