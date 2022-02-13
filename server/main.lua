ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
VERSION = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    print(

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        "^0[^4Author^0]^7 :^0 ^0Say^7\n" ..
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        "^0[^2Script^0]^7 :^0 ^5sLocation | Voiture^7\n" ..
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ("^0[^3Version^0]^7 :^0 ^0%s^7\n"):format(VERSION) ..                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        "^0======================================================================^7"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    )

--- Achat Véhicles

ESX.RegisterServerCallback("sloc:server:buy", function(source, callback, vehicle)
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 150
    if xPlayer.getMoney() >= price then 
        xPlayer.removeMoney(price)
        TriggerClientEvent('esx:showNotification', source, "~b~Vous avez payé une location.~s~\nMontant: ~g~" ..price.. "$")
        callback(true)
    else
        TriggerClientEvent('esx:showNotification', source, "~b~Vous avez refuser de payé une location.~s~\nMontant: ~g~" ..price.. "$")
        callback(false)
    end
end)

-- Notification Refus


ESX.RegisterServerCallback("sloc:server:refus", function(source, callback, vehicle)
    TriggerClientEvent('esx:showAdvancedNotification', source, '~r~s~b~Location', 'A Bientot', 'Merci de votre visite', 'CHAR_MP_STRIPCLUB_PR', 3)
end)


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               