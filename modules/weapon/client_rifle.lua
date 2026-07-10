local curWeapon = nil
local ox_inventory = exports.ox_inventory
local ped = cache.ped
local playerLoaded = false
local Weapons = {

    -- Corpo a corpo
    [`WEAPON_BAT`]                      = {object = `w_me_bat`, item = 'WEAPON_BAT', rot = vector3(0,92.5,0)}, 
    [`WEAPON_BATTLEAXE`]                = {object = `w_me_battleaxe`, item = 'WEAPON_BATTLEAXE', rot = vector3(0,92.5,0)}, 
    [`WEAPON_CROWBAR`]                  = {object = `w_me_crowbar`, item = 'WEAPON_CROWBAR', rot = vector3(0,92.5,0)}, 
    [`WEAPON_FIREEXTINGUISHER`]         = {object = `w_am_fire_exting`, item = 'WEAPON_FIREEXTINGUISHER', rot = vector3(0,92.5,0)}, 
    [`WEAPON_GOLFCLUB`]                 = {object = `w_me_gclub`, item = 'WEAPON_GOLFCLUB', rot = vector3(0,92.5,0)}, 
    [`WEAPON_HATCHET`]                  = {object = `w_me_hatchet`, item = 'WEAPON_HATCHET', rot = vector3(0,92.5,0)}, 
    [`WEAPON_HAZARDCAN`]                = {object = `w_ch_jerrycan`, item = 'WEAPON_HAZARDCAN', rot = vector3(0,92.5,0)}, 
    [`WEAPON_FERTILIZERCAN`]            = {object = `w_am_jerrycan_sf`, item = 'WEAPON_FERTILIZERCAN', rot = vector3(0,92.5,0)}, 
    [`WEAPON_MACHETE`]                  = {object = `w_me_machette_lr`, item = 'WEAPON_MACHETE', rot = vector3(0,92.5,0)}, 
    [`WEAPON_NIGHTSTICK`]               = {object = `w_me_nightstick`, item = 'WEAPON_NIGHTSTICK', rot = vector3(0,92.5,0)}, 
    [`WEAPON_PETROLCAN`]                = {object = `w_am_jerrycan`, item = 'WEAPON_PETROLCAN', rot = vector3(0,92.5,0)}, 
    [`WEAPON_POOLCUE`]                  = {object = `w_me_poolcue`, item = 'WEAPON_POOLCUE', rot = vector3(0,92.5,0)}, 
    [`WEAPON_STONE_HATCHET`]            = {object = `w_me_stonehatchet`, item = 'WEAPON_STONE_HATCHET', rot = vector3(0,92.5,0)}, 
    [`WEAPON_WRENCH`]                   = {object = `w_me_wrench`, item = 'WEAPON_WRENCH', rot = vector3(0,92.5,0)}, 
    [`WEAPON_CANDYCANE`]                = {object = `w_me_candy_xm3`, item = 'WEAPON_CANDYCANE', rot = vector3(0,92.5,0)}, 

    -- Submachine Guns
    [`weapon_microsmg`]                 = { object = `w_sb_microsmg`, item = 'weapon_microsmg', rot = vector3(85.0,180.0,0)},
    [`weapon_smg`]                      = { object = `w_sb_smg`, item = 'weapon_smg', rot = vector3(85.0,180.0,0)},
    [`weapon_smg_mk2`]                  = { object = `w_sb_smgmk2`, item = 'weapon_smg_mk2', rot = vector3(85.0,180.0,0)},
    [`weapon_assaultsmg`]               = { object = `w_sb_assaultsmg`, item = 'weapon_assaultsmg', rot = vector3(85.0,180.0,0)},
    [`weapon_combatpdw`]                = { object = `w_sb_pdw`, item = 'weapon_combatpdw', rot = vector3(85.0,180.0,0)},
    [`weapon_machinepistol`]            = { object = `w_sb_machinepistol`, item = 'weapon_machinepistol', rot = vector3(85.0,180.0,0)},
    [`weapon_minismg`]                  = { object = `w_sb_minismg`, item = 'weapon_minismg', rot = vector3(85.0,180.0,0)},
    [`weapon_raycarbine`]               = { object = `w_sb_raycarbine`, item = 'weapon_raycarbine', rot = vector3(85.0,180.0,0)},
    [`weapon_tecpistol`]                = { object = `w_sb_tecpistol`, item = 'weapon_tecpistol', rot = vector3(85.0,180.0,0)},
    
    --Shotguns
    [`weapon_pumpshotgun`]              = { object = `w_sg_pumpshotgun`, item = 'weapon_pumpshotgun', rot = vector3(85.0,180.0,0)},
    [`weapon_pumpshotgun_mk2`]          = { object = `w_sg_pumpshotgunmk2`, item = 'weapon_pumpshotgun_mk2', rot = vector3(85.0,180.0,0)},
    [`weapon_sawnoffshotgun`]           = { object = `w_sg_sawnoff`, item = 'weapon_sawnoffshotgun', rot = vector3(85.0,180.0,0)},
    [`weapon_assaultshotgun`]           = { object = `w_sg_assaultshotgun`, item = 'weapon_assaultshotgun', rot = vector3(85.0,180.0,0)},
    [`weapon_bullpupshotgun`]           = { object = `w_sg_bullpupshotgun`, item = 'weapon_bullpupshotgun', rot = vector3(85.0,180.0,0)},
    [`weapon_musket`]                   = { object = `w_ar_musket`, item = 'weapon_musket', rot = vector3(85.0,180.0,0)},
    [`weapon_heavyshotgun`]             = { object = `w_sg_heavyshotgun`, item = 'weapon_heavyshotgun', rot = vector3(85.0,180.0,0)},
    [`weapon_dbshotgun`]                = { object = `w_sg_dbshotgun`, item = 'weapon_dbshotgun', rot = vector3(85.0,180.0,0)},
    [`weapon_autoshotgun`]              = { object = `w_sg_autoshotgun`, item = 'weapon_autoshotgun', rot = vector3(85.0,180.0,0)},
    [`weapon_combatshotgun`]            = { object = `w_sg_combatshotgun`, item = 'weapon_combatshotgun', rot = vector3(85.0,180.0,0)},

    --Assault Rifles
    [`weapon_carbinerifle`]             = { object = `w_ar_carbinerifle`, item = 'eapon_carbinerifle', rot = vector3(85.0,180.0,0)},
    [`weapon_carbinerifle_mk2`]         = { object = `w_ar_carbineriflemk2`, item = 'eapon_carbinerifle_mk2', rot = vector3(85.0,180.0,0)},
    [`weapon_assaultrifle`]             = { object = `w_ar_assaultrifle`, item = 'weapon_assaultrifle', rot = vector3(85.0,180.0,0)},       
    [`weapon_assaultrifle_mk2`]         = { object = `w_ar_assaultriflemk2`, item = 'eapon_assaultrifle_mk2', rot = vector3(85.0,180.0,0)},      
    [`weapon_advancedrifle`]            = { object = `w_ar_advancedrifle`, item = 'eapon_advancedrifle', rot = vector3(85.0,180.0,0)},                 
    [`weapon_specialcarbine`]           = { object = `w_ar_specialcarbine`, item = 'eapon_specialcarbine', rot = vector3(85.0,180.0,0)},              
    [`weapon_specialcarbine_mk2`]       = { object = `w_ar_specialcarbinemk2`, item = 'eapon_specialcarbine_mk2', rot = vector3(85.0,180.0,0)},
    [`weapon_bullpuprifle`]             = { object = `w_ar_bullpuprifle`, item = 'eapon_bullpuprifle', rot = vector3(85.0,180.0,0)},             
    [`weapon_bullpuprifle_mk2`]         = { object = `w_ar_bullpupriflemk2`, item = 'eapon_bullpuprifle_mk2', rot = vector3(85.0,180.0,0)},         
    [`weapon_compactrifle`]             = { object = `w_ar_compactrifle`, item = 'eapon_compactrifle', rot = vector3(85.0,180.0,0)},               
    [`weapon_militaryrifle`]            = { object = `w_ar_militaryrifle`, item = 'eapon_militaryrifle', rot = vector3(85.0,180.0,0)},              
    [`weapon_heavyrifle`]               = { object = `w_ar_heavyrifle`, item = 'eapon_heavyrifle', rot = vector3(85.0,180.0,0)},             
    [`weapon_tacticalrifle`]            = { object = `w_ar_tacticalrifle`, item = 'eapon_tacticalrifle', rot = vector3(85.0,180.0,0)},                

    --Light Machine Guns
    [`weapon_mg`]                       = { object = `w_mg_mg`, item = 'weapon_mg', rot = vector3(85.0,180.0,0)},
    [`weapon_combatmg`]                 = { object = `w_mg_combatmg`, item = 'weapon_combatmg', rot = vector3(85.0,180.0,0)},
    [`weapon_combatmg_mk2`]             = { object = `w_mg_combatmgmk2`, item = 'weapon_combatmg_mk2', rot = vector3(85.0,180.0,0)},
    [`weapon_gusenberg`]                = { object = `w_sb_gusenberg`, item = 'weapon_gusenberg', rot = vector3(85.0,180.0,0)},

    --Sniper Rifles
    [`weapon_sniperrifle`]              = { object = `w_sr_sniperrifle`, item = 'weapon_sniperrifle', rot = vector3(85.0,180.0,0)},
    [`weapon_heavysniper`]              = { object = `w_sr_heavysniper`, item = 'weapon_heavysniper', rot = vector3(85.0,180.0,0)},
    [`weapon_heavysniper_mk2`]          = { object = `w_sr_heavysnipermk2`, item = 'weapon_heavysniper_mk2', rot = vector3(85.0,180.0,0)},
    [`weapon_marksmanrifle`]            = { object = `w_sr_marksmanrifle`, item = 'weapon_marksmanrifle', rot = vector3(85.0,180.0,0)},
    [`weapon_marksmanrifle_mk2`]        = { object = `w_sr_marksmanriflemk2`, item = 'weapon_marksmanrifle_mk2', rot = vector3(85.0,180.0,0)},
    [`weapon_precisionrifle`]           = { object = `w_sr_precisionrifle`, item = 'weapon_precisionrifle', rot = vector3(85.0,180.0,0)},

    --Heavy Weapons
    [`weapon_rpg`]                      = { object = `w_lr_rpg`, item = 'weapon_rpg', rot = vector3(85.0,180.0,0)},
    [`weapon_grenadelauncher`]          = { object = `w_lr_grenadelauncher`, item = 'weapon_grenadelauncher', rot = vector3(85.0,180.0,0)},
    [`weapon_grenadelauncher_smoke`]    = { object = `w_lr_grenadelauncher`, item = 'weapon_grenadelauncher_smoke', rot = vector3(85.0,180.0,0)},
    [`weapon_minigun`]                  = { object = `w_mg_minigun`, item = 'weapon_minigun', rot = vector3(85.0,180.0,0)},
    [`weapon_firework`]                 = { object = `w_lr_firework`, item = 'weapon_firework', rot = vector3(85.0,180.0,0)},
    [`weapon_railgun`]                  = { object = `w_lr_railgun`, item = 'weapon_railgun', rot = vector3(85.0,180.0,0)},
    [`weapon_hominglauncher`]           = { object = `w_lr_homing`, item = 'weapon_hominglauncher', rot = vector3(85.0,180.0,0)},
    [`weapon_compactlauncher`]          = { object = `w_lr_compactlauncher`, item = 'weapon_compactlauncher', rot = vector3(85.0,180.0,0)},
    [`weapon_rayminigun`]               = { object = `w_lr_rayminigun`, item = 'weapon_rayminigun', rot = vector3(85.0,180.0,0)},
    [`weapon_emplauncher`]              = { object = `w_lr_emplauncher`, item = 'weapon_emplauncher', rot = vector3(85.0,180.0,0)},
    [`weapon_railgunxm3`]               = { object = `w_lr_railgunxm3`, item = 'weapon_railgunxm3', rot = vector3(85.0,180.0,0)},  
}

local slots = {
    [1] = {
        pos = vec3(0.24, -0.17, -0.12), -- costas lado direito
        entity = nil,
        hash = nil,
        wep = nil
    },
    [2] = {
        pos = vec3(0.24, -0.17, 0.09), -- costas lado esquerdo
        entity = nil,
        hash = nil,
        wep = nil
    },
    [3] = {
        pos = vec3(0.14, -0.21, 0.0), -- Centro de costas, em cima de outra arma
        entity = nil,
        hash = nil,
        wep = nil
    },
    [4] = {
        pos = vec3(0.14, 0.20, 0.0), -- Peito (frente) em cima de outra arma frontal
        hash = nil,
        wep = nil
    },
}


AddEventHandler('onResourceStop', function(resourceName) -- exclui armas nas costas quando o script é interrompido
    if (GetCurrentResourceName() == resourceName) then
        for i = 1, #slots do
            local slot = slots[i]
            if slot.entity ~= nil then
                SetEntityAsMissionEntity(slot.entity, false, false)
                NetworkRequestControlOfEntity(slot.entity)
                DeleteEntity(slot.entity)
            end
        end
    end
end)

local function clearSlot(i)
    DeleteEntity(slots[i].entity)
    slots[i].entity = nil
    slots[i].hash = nil
    slots[i].wep = nil
end

local function removeFromSlot(hash)
    if Weapons[hash] == nil then return end
    local whatItem = Weapons[hash].item
    local count = ox_inventory:Search(2, whatItem)
    for i = 1, #slots do
        if slots[i].hash == hash then
            if type(count) ~= "number" or count <= 0 or not IsPistol(slots[i].hash) then
                clearSlot(i)
            end
        end
    end
end

local function removeWeapon(hash)
    if Weapons[hash] then
        removeFromSlot(hash)
    end
end

local function removeFromInv(hash)
    removeFromSlot(hash)
end

local function checkForSlot(hash)
    for i = 1, #slots do
        if slots[i].hash == hash then return false end
    end
    for i = 1, #slots do
        local slot = slots[i]
        if not slot.entity then
            return i
        end
    end
    return false
end
-- Função para obter a classe da arma
function GetWeaponClass(weaponHash)
    local weaponClass = GetWeapontypeGroup(weaponHash)
    return weaponClass
end
local function putOnBack(hash)
    if GetWeaponClass(hash) ~= 416676503 then
        local whatSlot = checkForSlot(hash)
        if whatSlot then
            curWeapon = nil
            local object = Weapons[hash].object
            local item = Weapons[hash].item
            lib.requestModel(object, 500)
            local coords = GetEntityCoords(ped)
            local prop = CreateObject(object, coords.x, coords.y, coords.z,  true,  true, true)
            slots[whatSlot].entity = prop
            slots[whatSlot].hash = hash
            slots[whatSlot].wep = item            
            AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 24816), slots[whatSlot].pos.x, slots[whatSlot].pos.y, slots[whatSlot].pos.z, Weapons[hash].rot.x, Weapons[hash].rot.y, Weapons[hash].rot.z, true, true, false, true, 2, true)
        end
    end
end

AddEventHandler('ox_inventory:currentWeapon', function(data)
    if not LocalPlayer.state.isLoggedIn then return end

    if data then
        if Weapons[data.hash] then
            putOnBack(curWeapon)
            curWeapon = data.hash
            removeWeapon(data.hash)
        end
    else
        if curWeapon then
            putOnBack(curWeapon)
        end
    end
end)

function IsPistol(weaponHash)
    -- Obtém o grupo da arma
    local weaponGroup = GetWeapontypeGroup(weaponHash)
    -- Verifica se pertence ao grupo de pistolas
    return weaponGroup == 416676503
end
AddEventHandler('ox_inventory:updateInventory', function(changes)
    if not LocalPlayer.state.isLoggedIn then return end

    playerLoaded = true
    for k, v in pairs(changes) do
        if type(v) == 'table' then
            local hash = joaat(v.name)
            if Weapons[hash] and not IsPistol(hash) then
                if curWeapon ~= hash then
                    putOnBack(hash)
                else
                    removeFromInv(hash)
                end
            end
        end
        if type(v) == 'boolean' then
            for i = 1, #slots do
                local count = ox_inventory:Search(2, slots[i].wep)
                if not count or count <= 0 or not IsPistol(slots[i].hash) then
                    removeFromInv(slots[i].hash)
                end
            end
        end
    end
end)

lib.onCache('vehicle', function(value)
    if value then
        for i = 1, #slots do
            clearSlot(i)
        end
    else
        if GetResourceState('ox_inventory') ~= 'started' or not playerLoaded then return end
        for k, v in pairs(Weapons) do
            local count = ox_inventory:Search(2, v.item)
            if count and count >= 1 then
                putOnBack(k)
            end
        end
    end
end)

lib.onCache('ped', function(value)
    ped = value
end)

CreateThread(function() 
    while not LocalPlayer.state.isLoggedIn do Wait(1000) end

    Wait(3000)

    local PlayerData = QBCore.Functions.GetPlayerData()

    for k, v in pairs(PlayerData.items) do
        local hash = joaat(v.name)

        if Weapons[hash] then
            putOnBack(hash)
        end
    end

    while true do
        Wait(250)
        if LocalPlayer.state.isLoggedIn then
            for k, v in pairs(slots) do
                if v.wep then
                    local entexists = DoesEntityExist(v.entity)
                    local entattached = entexists and IsEntityAttachedToEntity(v.entity, ped)
                    local entmodel = entexists and entattached and GetEntityModel(v.entity)

                    if v.entity == 0 or not entexists or not entattached or Weapons[v.hash].object ~= entmodel then
                        if entexists and not entattached then
                            SetEntityAsMissionEntity(v.entity, false, false)
                            NetworkRequestControlOfEntity(v.entity)
                            DeleteEntity(v.entity)
                        end

                        lib.requestModel(Weapons[v.hash].object, 500)
                        local coords = GetEntityCoords(ped)
                        local prop = CreateObject(Weapons[v.hash].object, coords.x, coords.y, coords.z,  true,  true, true)
                        slots[k].entity = prop
                        slots[k].hash = v.hash
                        AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 24816), slots[k].pos.x, slots[k].pos.y, slots[k].pos.z, Weapons[v.hash].rot.x, Weapons[v.hash].rot.y, Weapons[v.hash].rot.z, true, true, false, true, 2, true)

                    end
                end
            end
        end
    end
end)