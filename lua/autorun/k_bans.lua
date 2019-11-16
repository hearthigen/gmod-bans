KBans = KBans || {}

print('loading kbans...')

KBans.Root = 'kbans'

KBans.Load = {
    sv = SERVER and include or function() end,
    cl = SERVER and AddCSLuaFile or include,
    sh = function( file ) KBans.sv( file ) KBans.cl( file ) end,
    inc = function( file )
        KBans.Load[ file:GetFileFromFilename():sub( 1, 2 ) ](KBans.Root .. '/' .. file )
    end,
    include = function (file)
        return include(KBans.Root .. '/' .. file)
    end,
    dir = function( dir )
        for _, file in ipairs( file.Find( KBans.Root .. '/' .. dir .. "/*.lua", "LUA"  ) ) do
            KBans.Load.inc( file )
        end
    end
}

KBans.Load.dir('')

hook.Add( "CheckPassword", "KBans.CheckPassword", function(steam64, ip_address, sv_password, cl_password, player_name)
    print('outside')

    timer.Simple(10, function()
        print('test 10 secs')
        return false, 'test 10 sec'
    end)

--[[
    local post = {
        steam64 = steam64
    }

    http.Post('http://127.0.0.1:9443/index.php?type=check_player', post, function(response)
        local json = util.JSONToTable(response)

        if (type(json) == 'table' && json.success == true) then
            if (json.data.banned == true && ULib.bans[steam64] == nil) then
                --ULib.ban
                --ULib.bans[steam64] == nil
            else
            end
        end
    end)

    if (ULib.bans[steam64] != nil) then
        ULib.unban(util.SteamIDFrom64(steam64))

        return false, 'You were recently unbanned, but the server hasn\'t synced yet. Please reconnect.'
    end
--]]
end)

hook.Add('ULibPlayerBanned', 'KBans.Banned', function (steamid2, ban_data)
    local post =  ban_data
    post['steamid2'] = steamid2
    post['time'] = tostring(ban_data['time'])
    post['unban'] = tostring(ban_data['unban'])

    print('---ULibPlayerBanned---')
    PrintTable(post)
    print('---end---')
    print('\n')

    http.Post('http://127.0.0.1:9443/index.php?type=ban', post, function(response)
        print(response)
    end)
end)

hook.Add('ULibPlayerUnBanned', 'KBans.Unbanned', function (steamid2, admin)
    if (admin != nil && admin:IsPlayer())  then
        admin64 = util.SteamIDTo64(admin:SteamID())
        admin_name = admin:GetName()
        print(util.SteamIDTo64(admin:SteamID()))
    else
        admin64 = null
        admin_name = 'Console'
    end

    local post = {
        player64 = util.SteamIDTo64(steamid2),
        admin64 = admin64,
        admin_name = admin_name
    }

    print('---ULibPlayerUnBanned---')
    PrintTable(post)
    print('---end---')
    print('\n')

    http.Post('http://127.0.0.1:9443/index.php?type=unban', post, function(response)
        print(response)
    end)
end)

print('loaded kbans...\n')