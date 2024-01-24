Config = {
    Pos = {
        Location = vector3(165.43, -1006.93, 29.42), -- Position du Ped
        Ped = vector3(165.43, -1006.93, 28.42),
        VehicleSpawn = {
            spawn = vector3(173.91, -1011.01, 29.26), -- Postion du Spawn Vehicles
            heading = 199.0
        }
    }
    Price = 1000, -- Prix de la location
}

ConfigVehicles = {
    model = {
        "blista",
        "faggio",
    },
    label = {
        "Louer Une ~b~Blista",
        "Louer Un ~b~Faggio",
    },
}

Config.Init = {
    ["ESX"] = 'esx:getSharedObject',
}

Config.Text = {
    ['NameMenu1'] = "sLocation",
    ['NameSubMenu1'] = "Confirmation",
    ['Mess'] = "Appuyez sur [~b~E~s~] pour accéder à la ~b~Location",
}

Config.Text = {
    ['NameMenu1'] = "sLocation",
    ['NameSubMenu1'] = "Confirmation",
    ['Mess'] = "Appuyez sur [~b~E~s~] pour accéder à la ~b~Location",
}
