database = database or {}

database.GET_COUNT_ACCOUNT_FOR_STEAMID = 'SELECT COUNT(steamid) as count FROM `accounts` WHERE steamid = ?'
database.GET_ACCOUNT_BANS_FOR_STEAMID = 'SELECT reason, ban_time, expire_time, ( ban_time + expire_time ) as expire_ban FROM `bans` WHERE banned = ? AND ( expire_time IS NULL OR ( expire_time IS NOT NULL AND ( ban_time + expire_time ) >= unix_timestamp() ) )'