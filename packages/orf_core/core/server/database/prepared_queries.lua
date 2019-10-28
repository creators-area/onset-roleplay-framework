database = database or {}

database.GET_COUNT_ACCOUNT_FOR_STEAMID = 'SELECT COUNT(steamid) as count FROM `accounts` WHERE steamid = ?'
database.GET_ACCOUNT_BANS_FOR_STEAMID = 'SELECT reason, ban_time, expire_time, ( ban_time + expire_time ) as expire_ban FROM `bans` WHERE banned = ? AND ( expire_time IS NULL OR ( expire_time IS NOT NULL AND ( ban_time + expire_time ) >= unix_timestamp() ) )'
database.GET_ACCOUNT_ROLES_AND_PERMISSIONS = 'SELECT T3.name AS `role_name`, T5.name AS `permission_name` FROM `accounts` AS T1 INNER JOIN `accounts_has_roles` AS T2 ON T2.accounts_steamid = T1.steamid AND T1.steamid = \'?\' INNER JOIN `roles` AS T3 ON T2.roles_id = T3.id INNER JOIN `roles_has_permissions` AS T4 ON T4.roles_id = T3.id INNER JOIN `permissions` AS T5 ON T4.permissions_id = T5.id'
