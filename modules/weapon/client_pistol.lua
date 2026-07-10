local curWeapon = nil
local ox_inventory = exports.ox_inventory
local ped = cache.ped
local playerLoaded = false

local Weapons = {
    -- PISTOLAS            --vector3(vira o handguard sentido que aponta para o cu,gira sentido horario como se estivesse apoiado na mesa,gira como se deitasse a arma na mesa)
    [`weapon_pistol`]                   = { object = `w_pi_pistol`, item = 'weapon_pistol', rot = vector3(277.5,0,0)},
    [`weapon_pistol_mk2`]               = { object = `w_pi_pistol`, item = 'weapon_pistol_mk2', rot = vector3(277.5,0,0)},
    [`weapon_combatpistol`]             = { object = `w_pi_combatpistol`, item = 'weapon_combatpistol', rot = vector3(277.5,0,0)},
    [`weapon_appistol`]                 = { object = `w_pi_appistol`, item = 'weapon_appistol', rot = vector3(277.5,0,0)},
    [`weapon_stungun`]                  = { object = `w_pi_stungun`, item = 'weapon_stungun', rot = vector3(277.5,0,0)},
    [`weapon_pistol50`]                 = { object = `w_pi_pistol50`, item = 'weapon_pistol50', rot = vector3(277.5,0,0)},
    [`weapon_snspistol`]                = { object = `w_pi_sns_pistol`, item = 'weapon_snspistol', rot = vector3(277.5,0,0)},
    [`weapon_snspistol_mk2`]            = { object = `w_pi_sns_pistol`, item = 'weapon_snspistol_mk2', rot = vector3(277.5,0,0)},
    [`weapon_heavypistol`]              = { object = `w_pi_heavypistol`, item = 'weapon_heavypistol', rot = vector3(277.5,0,0)},
    [`weapon_vintagepistol`]            = { object = `w_pi_vintage_pistol`, item = 'weapon_vintagepistol', rot = vector3(277.5,0,0)},
    [`weapon_flaregun`]                 = { object = `w_pi_flaregun`, item = 'weapon_flaregun', rot = vector3(277.5,0,0)},
    [`weapon_marksmanpistol`]           = { object = `w_pi_marksmanpistol`, item = 'weapon_marksmanpistol', rot = vector3(277.5,0,0)},
    [`weapon_revolver`]                 = { object = `w_pi_revolver`, item = 'weapon_revolver', rot = vector3(277.5,0,0)},
    [`weapon_revolver_mk2`]             = { object = `w_pi_revolver`, item = 'weapon_revolver_mk2', rot = vector3(277.5,0,0)},
    [`weapon_doubleaction`]             = { object = `w_pi_doubleaction`, item = 'weapon_doubleaction', rot = vector3(277.5,0,0)},
    [`weapon_raypistol`]                = { object = `w_pi_raypistol`, item = 'weapon_raypistol', rot = vector3(277.5,0,0)},
    [`weapon_ceramicpistol`]            = { object = `w_pi_ceramicpistol`, item = 'weapon_ceramicpistol', rot = vector3(277.5,0,0)},
    [`weapon_navyrevolver`]             = { object = `w_pi_navyrevolver`, item = 'weapon_navyrevolver', rot = vector3(277.5,0,0)},
    [`weapon_gadgetpistol`]             = { object = `w_pi_gadgetpistol`, item = 'weapon_gadgetpistol', rot = vector3(277.5,0,0)},
    [`weapon_stungun_mp`]               = { object = `w_pi_stungun`, item = 'weapon_stungun_mp', rot = vector3(277.5,0,0)},
    [`weapon_pistolxm3`]                = { object = `w_pi_pistolxm3`, item = 'weapon_pistolxm3', rot = vector3(277.5,0,0)},
}

local slots = {
    [1] = {
        --pos = vec3(Sobe e desce, para frente e para traz, movimenta para direita e esquerda do corpo)
        pos = vec3(0, -0.0, 0.20), -- direito
        entity = nil,
        hash = nil,
        wep = nil
    },
    [2] = {
        pos = vec3(0, -0.0, -0.20), -- esquerdo
        entity = nil,
        hash = nil,
        wep = nil
    },
}

AddEventHandler('onResourceStop', function(resourceName) -- deletes weapons on back when script is stopped
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
    if slots[i].entity then
        DetachEntity(slots[i].entity)
        DeleteEntity(slots[i].entity)
        --print("Slot " .. i .. " cleared.")
    end
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
            clearSlot(i) -- Sempre chama clearSlot se a arma estiver no slot
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
    if GetWeaponClass(hash) == 416676503 then            
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
            AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 11816), slots[whatSlot].pos.x, slots[whatSlot].pos.y, slots[whatSlot].pos.z, Weapons[hash].rot.x, Weapons[hash].rot.y, Weapons[hash].rot.z, true, true, false, true, 2, true)
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
            if Weapons[hash] and IsPistol(hash) then -- Verifica se a arma é uma pistola
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
                -- Verifica se a arma é uma pistola antes de contar
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

RegisterCommand(Config.attachs, function()
    clearingProps = true
    SetTimeout(500, function()
        clearingProps = false
    end)

    local objects = GetGamePool('CObject')    

    for k, v in pairs(objects) do
        if IsEntityAttachedToEntity(v, ped) and v ~= GetCurrentPedWeaponEntityIndex(ped) then
            SetEntityAsMissionEntity(v, false, false)
            NetworkRequestControlOfEntity(v)
            DeleteEntity(v)
        end
    end
end)

RegisterCommand(Config.limparprops, function()
    clearingProps = true
    SetTimeout(500, function()
        clearingProps = false
    end)

    local objects = GetGamePool('CObject')

    for k, v in pairs(objects) do
        if IsEntityAttachedToEntity(v, ped) and v ~= GetCurrentPedWeaponEntityIndex(ped) then
            DetachEntity(v)
        end
    end
end)


