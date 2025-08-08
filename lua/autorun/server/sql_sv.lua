
-- Для присоединия к удаленному серверу
--[[
require('mysqloo')
db = mysqloo.connect('localhost', 'root', '1111', 'kuyash', 3306)
db:connect()

local q = db:query('CREATE TABLE test2 (a integer)')
q:start()
]]


-- Локальный сервер дб
util.AddNetworkString('ply.MoneyData')

local function SaveMoneyData(ply, money)
    local intMoney = tonumber(money)
    print(intMoney)
    sql.Query('INSERT OR REPLACE INTO kuyash_money (steam_id, money) VALUES(' .. ply:SteamID64() .. ', ' .. intMoney .. ')')
end

local function GetMoneyData(ply)
    return sql.QueryValue('SELECT money FROM kuyash_money WHERE steam_id = ' .. ply:SteamID64())
end

hook.Add('PlayerSay', 'db.SaveMoneyData', function(ply, str)
    if string.lower(string.sub(str, 1, 6)) == '!money' then
        local money = tonumber(string.sub(str, 7))
        if money == nil then return end
        SaveMoneyData(ply, money)
        return false        
    end

end)

hook.Add('PlayerSay', 'db.GetMoneyData', function(ply, str)
    if string.lower(str) == '!getmoney' then
        local plyMoney = GetMoneyData(ply)
        if plyMoney ~= nil then
            net.Start('ply.MoneyData')
                net.WriteInt(plyMoney, 32)
            net.Send(ply)
        else
            net.Start('ply.MoneyData')
                net.WriteInt(-1, 3)
            net.Send(ply)
        end
        return false
    end
end)
