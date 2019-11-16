KBans = KBans || {}

KBans.Config = KBans.Load.include('config/kbans_config.lua')

local cfg_website_length = KBans.Config.website:len()
if (string.sub(KBans.Config.website, cfg_website_length, cfg_website_length) == "/") then
    KBans.Config.website = string.sub(KBans.Config.website, 0, cfg_website_length - 1)
end

KBans.Headers = {
    Authorization = 'Bearer ' ..  KBans.Config.secret
}

KBans.Get = function(url, success, error, headers)
    if (headers == nil) then
        headers = {}
    end
    table.Merge(headers, KBans.Headers)

    http.Fetch(url, success, error, headers)
end

KBans.Post = function(url, data, success, error, headers)
    if (headers == nil) then
        headers = {}
    end
    table.Merge(headers, KBans.Headers)

    http.Post(url, data, success, error, headers)
end

--hook.Add('CheckPassword', 'KBans.CheckPassword', KBans.CheckPassword)
--hook.Add('ULibPlayerBanned', 'KBans.Banned', KBans.UlibBanned)
--hook.Add('ULibPlayerUnBanned', 'KBans.UnBanned', KBans.UlibUnBanned)