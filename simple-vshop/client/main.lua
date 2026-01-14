local ESX = exports['es_extended']:getSharedObject()
local isTesting, isInShop = false, false
local lastCoords, showroomVehicle, cam = nil, nil, nil
local cameraAngle = 0.0

-- Cargar interior de Simeon al iniciar
Citizen.CreateThread(function()
    RequestIpl('shr_int')
    local interiorID = GetInteriorAtCoords(-47.5, -1097.2, 25.4)
    if IsValidInterior(interiorID) then
        LoadInterior(interiorID)
        EnableInteriorProp(interiorID, 'csr_beforeMission')
        RefreshInterior(interiorID)
    end
end)

-- Bucle de Marcador
Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local dist = #(coords - Config.MarkerPos)

        if dist < 15.0 and not isInShop and not isTesting then
            sleep = 0
            DrawMarker(27, Config.MarkerPos.x, Config.MarkerPos.y, Config.MarkerPos.z - 0.95, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 155, false, false, 2, true)
            
            if dist < 1.5 then
                ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para entrar al ~b~Concesionario")
                if IsControlJustReleased(0, 38) then OpenShop() end
            end
        end
        Wait(sleep)
    end
end)

function OpenShop()
    ESX.TriggerServerCallback('simple-vshop:getVehicles', function(vehicles, categories)
        isInShop = true
        SetNuiFocus(true, true)
        
        local playerPed = PlayerPedId()
        DoScreenFadeOut(500)
        Wait(600)
        
        SetEntityCoords(playerPed, Config.ShopInside.coords.x, Config.ShopInside.coords.y, Config.ShopInside.coords.z)
        FreezeEntityPosition(playerPed, true)
        SetEntityVisible(playerPed, false)
        
        StartShowroomCamera()
        SendNUIMessage({ action = "open", vehicles = vehicles, categories = categories })
        DoScreenFadeIn(500)
    end)
end

RegisterNUICallback('selectVehicle', function(data)
    local model = GetHashKey(data.model)
    if DoesEntityExist(showroomVehicle) then DeleteEntity(showroomVehicle) end

    RequestModel(model)
    while not HasModelLoaded(model) do Wait(10) end

    ESX.Game.SpawnLocalVehicle(data.model, Config.ShopInside.coords, Config.ShopInside.heading, function(vehicle)
        showroomVehicle = vehicle
        SetEntityHeading(vehicle, Config.ShopInside.heading)
        FreezeEntityPosition(vehicle, true)
        SetVehicleDirtyLevel(vehicle, 0.0)
    end)
end)

-- PRUEBA (Test Drive)
RegisterNUICallback('testDrive', function(data)
    local model = data.model
    CloseShop(true)
    
    isTesting = true
    DoScreenFadeOut(500)
    Wait(600)

    SetEntityCoords(PlayerPedId(), Config.TestDrive.spawn.x, Config.TestDrive.spawn.y, Config.TestDrive.spawn.z)
    Wait(500)

    ESX.Game.SpawnVehicle(model, Config.TestDrive.spawn, Config.TestDrive.heading, function(vehicle)
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        SetVehicleFuelLevel(vehicle, 100.0)
        Entity(vehicle).state.fuel = 100.0
        DoScreenFadeIn(500)

        local timer = Config.TestDrive.time
        Citizen.CreateThread(function()
            while timer > 0 and isTesting do
                Wait(1000)
                timer = timer - 1
                ESX.ShowHelpNotification("PRUEBA: ~b~" .. timer .. "s")
                if not IsPedInAnyVehicle(PlayerPedId(), false) then timer = 0 end
            end
            
            isTesting = false
            DoScreenFadeOut(500)
            Wait(600)
            if DoesEntityExist(vehicle) then DeleteEntity(vehicle) end
            SetEntityCoords(PlayerPedId(), Config.MarkerPos.x, Config.MarkerPos.y, Config.MarkerPos.z)
            FreezeEntityPosition(PlayerPedId(), false)
            SetEntityVisible(PlayerPedId(), true)
            DoScreenFadeIn(500)
        end)
    end)
end)

-- COMPRA (Aparecer en la salida dentro del coche)
RegisterNUICallback('buyVehicle', function(data)
    if DoesEntityExist(showroomVehicle) then
        local vehicleProps = ESX.Game.GetVehicleProperties(showroomVehicle)
        vehicleProps.plate = string.upper(ESX.GetRandomString(8)) 
        
        
        ESX.TriggerServerCallback('simple-vshop:buyVehicle', function(bought)
            if bought then
                local model = data.model
                CloseShop(true)
                
                DoScreenFadeOut(500)
                Wait(600)

                -- Aparecer en el punto de salida con el coche
                ESX.Game.SpawnVehicle(model, Config.ShopOutside.coords, Config.ShopOutside.heading, function(vehicle)
                    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                    ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
                    SetVehicleFuelLevel(vehicle, 100.0)
                    
                    DoScreenFadeIn(500)
                    ESX.ShowNotification("~g~¡Disfruta de tu nuevo vehículo!")
                end)
            else
                ESX.ShowNotification("~r~No tienes suficiente dinero")
            end
        end, vehicleProps, data.price)
    end
end)

function CloseShop(isStartingTest)
    isInShop = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "close" })
    
    RenderScriptCams(false, true, 800, true, true)
    if DoesCamExist(cam) then DestroyCam(cam, false) cam = nil end
    if DoesEntityExist(showroomVehicle) then DeleteEntity(showroomVehicle) showroomVehicle = nil end
    
    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, true)
    FreezeEntityPosition(playerPed, false)

    if not isStartingTest then
        SetEntityCoords(playerPed, Config.MarkerPos.x, Config.MarkerPos.y, Config.MarkerPos.z)
    end
end

RegisterNUICallback('close', function() CloseShop(false) end)

function StartShowroomCamera()
    if not DoesCamExist(cam) then cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true) end
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 800, true, true)

    Citizen.CreateThread(function()
        while isInShop do
            Wait(0)
            cameraAngle = cameraAngle + 0.004
            local offsetX = Config.ShopInside.coords.x + (math.cos(cameraAngle) * 6.5)
            local offsetY = Config.ShopInside.coords.y + (math.sin(cameraAngle) * 6.5)
            SetCamCoord(cam, offsetX, offsetY, Config.ShopInside.coords.z + 2.0)
            PointCamAtCoord(cam, Config.ShopInside.coords.x, Config.ShopInside.coords.y, Config.ShopInside.coords.z + 0.5)
        end
    end)
end