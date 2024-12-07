local framework = Config.Framework
local ESX = nil

if framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
elseif framework == 'frw' then
    ESX = exports['Framework']:getSharedObject()
else
    print("Votre Framework est spécial ou trop ancian, get le code pour changer l'export")
end

RegisterCommand('kick', function(source, args)
    local adminSrc = source
    if adminSrc > 0 then
        local xPlayer = ESX.GetPlayerFromId(adminSrc)

        if xPlayer.getGroup() ~= "user" then
            local playerId = tonumber(args[1])
            local reason = table.concat(args, " ", 2)

            if not playerId then
                TriggerClientEvent('esx:showNotification', adminSrc, "ID joueur invalide!")
                return
            end

            if reason == "" or reason == nil then
                TriggerClientEvent('esx:showNotification', adminSrc, "Vous devez entrer un motif!")
                return
            end

            if GetPlayerName(playerId) then
                local playerName = GetPlayerName(playerId)
                DropPlayer(playerId, "Vous avez été kick du serveur : " .. Config.Name .. " avec comme raison : " .. reason)
                TriggerClientEvent('esx:showNotification', adminSrc, "Le joueur " .. playerName .. " a été expulsé pour : " .. reason)
            else
                TriggerClientEvent('esx:showNotification', adminSrc, "Le joueur avec l'ID " .. playerId .. " est introuvable!")
            end
        else
            TriggerClientEvent('esx:showNotification', adminSrc, "Vous n'avez pas la permission d'utiliser cette commande!")
        end
    end
end, false)
