local ESX = exports['es_extended']:getSharedObject()

-- Cargar vehículos de la base de datos
ESX.RegisterServerCallback('simple-vshop:getVehicles', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM vehicle_categories', {}, function(categories)
        MySQL.Async.fetchAll('SELECT * FROM vehicles', {}, function(vehicles)
            cb(vehicles, categories)
        end)
    end)
end)

-- Lógica de compra (CALLBACK)
ESX.RegisterServerCallback('simple-vshop:buyVehicle', function(source, cb, vehicleProps, price)
    local xPlayer = ESX.GetPlayerFromId(source)

    -- Cambiar 'money' por 'bank' si prefieres que cobren del banco
    if xPlayer.getAccount('money').money >= price then
        xPlayer.removeAccountMoney('money', price)
        
        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
            ['@owner']   = xPlayer.identifier,
            ['@plate']   = vehicleProps.plate,
            ['@vehicle'] = json.encode(vehicleProps)
        }, function(rowsChanged)
            cb(true) -- Confirmar compra exitosa
        end)
    else
        cb(false) -- No hay dinero
    end
end)