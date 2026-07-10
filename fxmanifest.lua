fx_version 'cerulean'
lua54 'yes'
game 'gta5'

name         'forge-weapons'
version      '1.1.1'
description  'A multi-framework weapon throwing script.'
author       'PierreMoraes'

shared_scripts {
    '@ox_lib/init.lua',
    '@qb-core/shared/locale.lua',
    'config.lua',
    'core/shared.lua',
    "locales/locale.lua",
    "locales/translations/*.lua",
    --'modules/**/shared.lua',
}

server_scripts {
    'bridge/**/server.lua',
    'modules/**/server.lua',
}

client_scripts {
    'core/client.lua',
    'bridge/**/client.lua',
    'modules/**/client.lua',
    'modules/**/client_pistol.lua',
    'modules/**/client_rifle.lua',
}
