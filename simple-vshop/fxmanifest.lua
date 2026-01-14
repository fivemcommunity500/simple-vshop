fx_version 'cerulean'
game 'gta5'

author 'Adri1216|FiveMCommunity'
description 'Concesionario Neón con Test Drive'

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/style.css',
    'html/script.js'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua'
}

shared_script 'config.lua'