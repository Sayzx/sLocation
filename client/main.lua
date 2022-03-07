ESX = nil

------------------------------------
-- sLocation ( Help by L4 )         
-- Crédit By Say                    
------------------------------------
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    VERSION = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
local price = 150  
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    print(

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        "^0[^4Author^0]^7 :^0 ^0Say^7\n" ..
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        "^0[^2Script^0]^7 :^0 ^5sLocation | Voiture^7\n" ..
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ("^0[^3Version^0]^7 :^0 ^0%s^7\n"):format(VERSION) ..                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        "^0======================================================================^7"
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    )

CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.Init['ESX'], function(obj) ESX = obj end)
		Wait(0)
	end

    ESX.PlayerData = ESX.GetPlayerData()
end)

local locmenu = false 
local slocationmenu = RageUI.CreateMenu(Config.Text["NameMenu1"], Config.Text["NameMenu1"]) -- Création du Menu
local slocationsubmenu = RageUI.CreateSubMenu(slocationmenu, Config.Text["NameSubMenu1"], Config.Text["NameSubMenu1"])
slocationmenu.closed = function() 
    locmenu = false
end


CreateThread(function()
	local hash = GetHashKey("s_f_y_airhostess_01") -- Model du ped
	while not HasModelLoaded(hash) do -- Vérifie si le modèle du ped est valide
	  RequestModel(hash)
	  Wait(40)
	end
	local coords = vector3(Config.Pos.Ped) -- Pos Ped
	local ped = CreatePed(4, hash, coords, false, false) -- Spawn du ped
	local heading = 165.0 -- Orientation
	SetEntityInvincible(ped, true) -- Met le ped invicible
	SetEntityHeading(ped, heading) -- Met l'orientation du ped
	SetEntityAsMissionEntity(ped, true, true) --
	SetPedHearingRange(ped, 0.0) -- 
	SetPedSeeingRange(ped, 0.0) -- 
	SetPedAlertness(ped, 0.0) -- 
	SetPedFleeAttributes(ped, 0, 0) --
	SetBlockingOfNonTemporaryEvents(ped, true) --
	SetPedCombatAttributes(ped, 46, true)  -- 
	SetPedFleeAttributes(ped, 0, 0) --
    SetBlockingOfNonTemporaryEvents(ped, true) -- le ped ne peux plus bouger
    FreezeEntityPosition(ped, true) -- le ped n'est plus affrayé par les armes
    SetEntityInvincible(ped, true) -- le ped est invincible
    SetEntityAnimCurrentTime(ped, sit, true, 10)

end)

CreateThread(function()
    local interval = 1
    while true do

        Citizen.Wait(interval)

        local pos = GetEntityCoords(PlayerPedId())
        local dest = vector3(165.02, -1007.42, 29.42)
        local distance = GetDistanceBetweenCoords(pos, dest, true)

        if distance > 20 then
            interval = 850
        else 
            interval = 1
           
            if distance < 2 then
                 DrawMarker(36, 165.03, -1007.45, 29.42, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 150, 10, 255, 170, 0, 1, 2, 0, nil, nil, 0)
            if distance < 0.5 then
                    ESX.ShowHelpNotification("~b~Appuyez sur ~y~ ~INPUT_CONTEXT~  ~b~pour intéragir") -- a commenter si vous avez activé la ligne au dessus
            end
                if IsControlJustPressed(1,51) then
                    OpenLocationMenu() -- ouvrir le menu principal
                end
            if distance > 3 then
                RageUI.CloseAll()
            end
            end
        end
    end
end)



Citizen.CreateThread(function()

    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0) 
    end

    ESX.PlayerData = ESX.GetPlayerData()

    while true do
        local myCoords = GetEntityCoords(PlayerPedId(), true) -- Récupère la position du joueur

        if not locmenu then
            if #(myCoords-Config.Pos.Location) < 2.0 then
                AddText(Config.Text['Mess'])
                if IsControlJustPressed(0, 38) then 
                    OpenLocationMenu()
                end 
            end
        end
        Wait(1)
    end
end)    

function CreateLocVehicles(locvehicles)
    ESX.Game.SpawnVehicle(locvehicles, Config.Pos.VehicleSpawn.spawn, Config.Pos.VehicleSpawn.heading, function(vehicle) -- Faire Spawn le véhicle avec coords et heading ( Rotation ) config dans le Shared/main.lua
        SetVehicleNumberPlateText(vehicle, "sLocation")
        SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1) -- Mettre le Joueur dans le véhicle
        
        
    end)
end

RegisterCommand("open", function()
    OpenLocationMenu()
end)


function OpenLocationMenu() -- Function pour Ouvrir le Menu de Location
    if locmenu then
        locmenu = false
        RageUI.Visible(slocationmenu, false) 
    else 
        locmenu = true -- Tant que menu est ouvert
        local locvehicles = nil
        local LabelList
        
        RageUI.Visible(slocationmenu, true) -- Afficher le Menu
        Citizen.CreateThread(function() -- Tant que menu est ouvert executer la boucle
            while locmenu do 
                Wait(1)
                RageUI.IsVisible(slocationmenu, function() -- Formulation du Menu
                    RageUI.Separator("~r~↓ ~b~sLocation ~r~↓")
                    for k,v in pairs(ConfigVehicles.label) do -- Boucle pour afficher les modèles dans le config
                        RageUI.Button(v, "~b~>> ~y~Location Voiture", {RightLabel = "→→"}, true, {
                            onSelected = function()
                                locvehicles = ConfigVehicles.model[k]
                            end
                        }, slocationsubmenu)
                    end
                end)

                RageUI.IsVisible(slocationsubmenu, function()
                    RageUI.Separator("~r~↓ ~b~Confirmation de la location.. ~r~↓")
                    RageUI.Button("~b~>> ~g~Valider", nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            ESX.TriggerServerCallback("sloc:server:buy", function(result) 
                                if result then 
                                    CreateLocVehicles(locvehicles)
                                end
                            end, "jugular") 
                            RageUI.CloseAll()
                        end                
                        
                    }) 
                    RageUI.Button("~b~>> ~r~Retour", false, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                            ESX.TriggerServerCallback("sloc:server:refus", function(result)
                            end, "a")
                        end
                    })
                end)
                
            end
        end)
    end
end


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        local interval = 1
        local pos = GetEntityCoords(PlayerPedId())
        local dest = vector3(165.02, -1007.42, 29.42)
        local distance = GetDistanceBetweenCoords(pos, dest, true)

        if distance > 2 then 
            RageUI.CloseAll()
        else 
            interval = 1
        end
    end
end)








---- Blips


Citizen.CreateThread(function()

    local blip = AddBlipForCoord(165.43, -1006.93, 29.42) -- Coordonnés du Blips
    SetBlipSprite (blip, 56) -- Model du blip
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.65) -- Taille du blip
    SetBlipColour (blip, 2) -- Couleur du blip
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('sLocation') -- Nom du blip
    EndTextCommandSetBlipName(blip)
end)

