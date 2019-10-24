local accounts = {}

function GetAccount(steamid)
    return accounts[steamid]
end

function GetAccountVar(target, var_name)
    return accounts[IsValidPlayer(target) and GetPlayerSteamId(target) or target][var_name]
end

AddFunctionExport('GetAccountVar', GetAccountVar)

-- TODO: Challenge -> Generate get function in loop

function GetSteamName(target)
    return GetAccountVar(target, 'steam_name')
end

function GetGameVersion(target)
    return GetAccountVar(target, 'game_version')
end

function GetLocale(target)
    return GetAccountVar(target, 'locale')
end

function GetCountLogin(target)
    return GetAccountVar(target, 'count_login')
end

function GetCountKick(target)
    return GetAccountVar(target, 'count_kick')
end

function GetCountBan(target)
    return GetAccountVar(target, 'count_ban')
end

function GetLastIp(target)
    return GetAccountVar(target, 'last_ip')
end

function GetCreatedAt(target)
    return GetAccountVar(target, 'created_at')
end
