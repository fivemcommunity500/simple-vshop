Config = {}

-- Configuración visual del marcador de entrada
Config.MarkerPos = vector3(-33.77, -1102.02, 26.42) 
Config.DrawDistance = 20.0
Config.MarkerColor = { r = 0, g = 255, b = 255 } 

-- Punto de exhibición (Dentro del concesionario)
Config.ShopInside = {
    coords = vector3(-47.57, -1097.22, 26.42), 
    heading = 300.0                           
}

-- Punto de entrega tras compra (Fuera del concesionario)
Config.ShopOutside = {
    coords = vector3(-28.63, -1085.69, 26.42), 
    heading = 320.0
}

-- Configuración de la Prueba (Test Drive)
Config.TestDrive = {
    spawn = vector3(-1326.78, -2886.18, 13.94), 
    heading = 320.0,                           
    time = 120                                  
}