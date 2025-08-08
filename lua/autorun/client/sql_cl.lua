
net.Receive('ply.MoneyData', function()
    local plyMoney = net.ReadInt(32)
    if plyMoney ~= nil then
        LocalPlayer():ChatPrint('Your wallet have: ' .. plyMoney .. '$')
    end
end)