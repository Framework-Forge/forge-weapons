local ThrownWeapons = {}

local entitycagada
local throwingWeapon = nil



function GetDirectionFromRotation(rotation)
    local dm = (math.pi / 180)
    return vector3(-math.sin(dm * rotation.z) * math.abs(math.cos(dm * rotation.x)),
        math.cos(dm * rotation.z) * math.abs(math.cos(dm * rotation.x)), math.sin(dm * rotation.x))
end

function PerformPhysics(entity)
    local power = 25
    FreezeEntityPosition(entity, false)
    local ped = PlayerPedId()
    local rot = GetGameplayCamRot(2)
    local dir = GetDirectionFromRotation(rot)
    SetEntityHeading(entity, rot.z + 90.0)
    SetEntityVelocity(entity, dir.x * power, dir.y * power, power * dir.z)
end

function GetWeaponString(weaponHash)
    for i = 1, #Config.Weapons do
        if weaponHash == GetHashKey(Config.Weapons[i]) then return Config.Weapons[i] end
    end
end

function ThrowCurrentWeapon()
    if throwingWeapon then return end
    local ped = PlayerPedId()
    local equipped, weaponHash = GetCurrentPedWeapon(ped, 1)
    local weapon = GetWeaponString(weaponHash)
    if not equipped or not weapon then return end
    throwingWeapon = true
    CreateThread(function()
        PlayAnim(ped, "melee@thrown@streamed_core", "plyr_takedown_front", -8.0, 8.0, -1, 49)
        Wait(600)
        ClearPedTasks(ped)
    end)
    Wait(550)
    local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 1.0)
    local prop = GetWeaponObjectFromPed(ped, true)
    local model = GetEntityModel(prop)
    RemoveWeaponFromPed(ped, weaponHash)
    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    DeleteEntity(prop)
    prop = CreateProp(model, coords.x, coords.y, coords.z, true, false, true)
    SetEntityCoords(prop, coords.x, coords.y, coords.z)
    SetEntityHeading(prop, GetEntityHeading(ped) + 90.0)
    PerformPhysics(prop)
    TriggerServerEvent("pierre_weapons:throwWeapon", { weapon = weapon, net_id = ObjToNet(prop) })
    throwingWeapon = nil
end

function OnPlayerDeath()
    if not Config.DeathDropsWeapon then return end
    local ped = PlayerPedId()
    local equipped, weaponHash = GetCurrentPedWeapon(ped, 1)
    local weapon = GetWeaponString(weaponHash)
    if not equipped or not weapon then return end
    local prop = GetWeaponObjectFromPed(ped, true)
    local model = GetEntityModel(prop)
    local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 1.0)
    RemoveWeaponFromPed(ped, weaponHash)
    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    DeleteEntity(prop)
    prop = CreateProp(model, coords.x, coords.y, coords.z, true, false, true)
    local off, rot = vector3(0.05, 0.0, -0.085), vector3(90.0, 90.0, 0.0)
    AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 28422), off.x, off.y, off.z, rot.x, rot.y, rot.z, false, false,
        false, true, 2, true)
    DetachEntity(prop)
    TriggerServerEvent("pierre_weapons:throwWeapon", { weapon = weapon, net_id = ObjToNet(prop) })
end

RegisterCommand("throwGun", function()
    local ped = PlayerPedId()
    local equipped, weaponHash = GetCurrentPedWeapon(ped, 1)
    local weapon = GetWeaponString(weaponHash)
    if not equipped or not weapon then return end
    Citizen.Wait(1000)
    ThrowCurrentWeapon()
end)

RegisterKeyMapping('throwGun', 'Throw Weapon', 'keyboard', Config.ThrowKeybind)


RegisterNetEvent("pierre_weapons:setWeaponData", function(weaponID, data)
    ThrownWeapons[weaponID] = data
end)

AddEventHandler('gameEventTriggered', function(event, args)
    if event ~= "CEventNetworkEntityDamage" or GetEntityType(args[1]) ~= 1 or NetworkGetPlayerIndexFromPed(args[1]) ~= PlayerId() then return end
    if not IsEntityDead(PlayerPedId()) then return end
    if Config.DropWeaponWhenHitHand == true then
        local victim = args[1]
        local hit, bone = GetPedLastDamageBone(victim)
        if hit then
            -- print(bone)
            local currentTime = GetGameTimer()
            if currentTime - lastHitTime > cooldownTime then
                lastHitTime = currentTime

                if bone == 18905 or bone == 57005 or bone == 28252 or bone == 14201 or bone == 24816 or bone == 51826 then
                    if IsPedArmed(victim, 14) then
                        local weapon = GetSelectedPedWeapon(victim)
                        local pedPosition = GetEntityCoords(victim)

                        -- CREATES WEAPON ON THE GROUND
                        SetPedToRagdoll(victim, 1000, 1000, 0, 0, 0, 0)
                        weaponThrewAwayHash = weapon
                        local pickupHash = GetPickupHashFromWeapon(weapon)

                        -- local pickup = CreatePickupRotate(pickupHash, pedPosition.x, pedPosition.y, pedPosition.z, 0, 0, 0, 8, 1, 1, true, weapon)
                        SetCurrentPedWeapon(victim, `WEAPON_UNARMED`, true)
                        --

                        if Config.Debug == true then
                            print("{DROP WEAPON WHEN HIT} test prints GetSelectedPedWeapon" .. weapon)
                            print("{DROP WEAPON WHEN HIT} pickup hash" .. pickupHash)
                        end


                        -- FRAMEWORK CHECK
                        --local weaponName = Config.Weapons[tostring(weapon)]
                        if Config.Framework == "qb" or Config.Framework == "oldqb" then
                            local victimID = GetPlayerServerId(NetworkGetEntityOwner(victim))

                            --local weaponName = Config.Weapons[tostring(weapon)]
                            --TriggerServerEvent('0r-weaponReality:weaponRemoveFromInventory', weaponName, victimID)
                            OnPlayerDeath()
                        elseif Config.Framework == "esx" or Config.Framework == "oldesx" then
                            local victimID = GetPlayerServerId(NetworkGetEntityOwner(victim))
                            --local weaponName = Config.Weapons[tostring(weapon)]
                            --TriggerServerEvent('0r-weaponReality:weaponRemoveFromInventory', weaponName, victimID)
                            OnPlayerDeath()
                        end
                        --TriggerServerEvent('0r-weaponReality:_L("weaponThrown")', pickupHash, pedPosition, weaponName, weaponThrewAwayHash)
                        OnPlayerDeath()
                        -- table.insert(savedWeaponPositions, { weapon = pickupHash, x = pedPosition.x, y = pedPosition.y, z = pedPosition.z, pickup = pickup, realWeapon = weaponName})
                        return
                    end
                end
            end
        end
    else
        return
    end
    OnPlayerDeath()
end)

--[[] ]
RegisterCommand("animwp", function(source, parametro)
    if parametro[1] == 1 then
        Config.WeaponAnimation = "always"
    elseif parametro[1] == 0 then
        Config.WeaponAnimation = "key"
    end
    print(parametro[1])
end)
--[[]]


local lanternaLigada = false
RegisterKeyMapping('lanterna', 'Lanterna', 'keyboard', Config.limparprops)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if IsControlJustPressed(0, 38) then -- 38 é o código para a tecla "E" no jogo
            ToggleLanterna()
        end
    end
end)

function ToggleLanterna()
    lanternaLigada = not lanternaLigada
    local ped = PlayerPedId()

    if IsPedArmed(ped, 6) then -- 6 representa uma pistola
        if lanternaLigada then
            SetFlashLightEnabled(ped, true)
            SetFlashLightKeepOnWhileMoving(true)
            SetFlashLightFadeDistance(300.0)

        else
            SetFlashLightEnabled(ped, false)
            SetFlashLightKeepOnWhileMoving(false)
        end
    end
end

local keyPressed = false
local weaponAdded = false




Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then

            if Config.WeaponAnimation then
                if IsControlPressed(0, 21) then -- Tecla SHIFT
                    if IsControlPressed(0, 32) or IsControlPressed(0, 30) or IsControlPressed(0, 34) then
                        if not keyPressed then
                        --if IsPedRunning(ped) then
                            GiveWeaponToPed(ped, GetHashKey("weapon_petrolcan"), 0, false, true)
                            RemoveWeaponFromPed(ped, GetHashKey("weapon_petrolcan"))
                            keyPressed = true
                        end
                        SetPedWeaponMovementClipset(ped, "move_ped_wpn_jerrycan_generic", 0.50)
                    end
                else
                    ResetPedWeaponMovementClipset(ped, 0.0)
                    keyPressed = false
                end
            else
                if IsPedRunning(ped) then
                    GiveWeaponToPed(ped, GetHashKey("weapon_petrolcan"), 0, false, true)
                    RemoveWeaponFromPed(ped, GetHashKey("weapon_petrolcan"))
                end

                if IsPedArmed(ped, 4) then
                    SetPedWeaponMovementClipset(ped, "move_ped_wpn_jerrycan_generic", 0.50)
                else
                    ResetPedWeaponMovementClipset(ped, 0.0)
                end
            end
        end
    end
end)





local CreatedZones = {} -- Tabela para rastrear zonas criadas

CreateThread(function()
    while true do
        local wait = 1000
        local ped = PlayerPedId()
        if not IsPlayerDead(ped) and not IsPedInAnyVehicle(ped, true) then
            for k, v in pairs(ThrownWeapons) do
                if NetworkDoesNetworkIdExist(v.net_id) then
                    local entitycagada = NetToObj(v.net_id)
                    local coords = GetEntityCoords(entitycagada)
                    local dist = #(GetEntityCoords(ped) - coords)
                    if Config.Target then
                        if dist < 5.0 and not CreatedZones[k] then
                            -- Adiciona a interação uma única vez
                            cocoteimoso(k, coords)
                            CreatedZones[k] = true -- Marca como criado
                        end
                    else
                        if dist < 5.0 then
                            wait = 0
                            if dist < 1.25 and not ShowInteractText(_L("pickup_weapon")) and IsControlJustPressed(1, Config.TakeKeybind) then
                                ClearPedTasksImmediately(ped)
                                FreezeEntityPosition(ped, true)
                                PlayAnim(ped, "pickup_object", "pickup_low", -8.0, 8.0, -1, 49, 1.0)
                                Wait(800)
                                TriggerServerEvent("pierre_weapons:pickupWeapon", k)
                                Wait(800)
                                ClearPedTasks(ped)
                                FreezeEntityPosition(ped, false)
                            end
                        end
                    end
                end
            end
        end
        Wait(wait)
    end
end)

function cocoteimoso(k, coords)
    if Config.TargetSystem == "qb-target" then
        local zoneName = "weapon_pickup_" .. k

        exports["qb-target"]:AddCircleZone(zoneName, coords, 1.25, {
            name = zoneName,
            debugPoly = false,
            useZ = true
        }, {
            options = {
                {
                    icon = "fas fa-hand-paper",
                    label = "Pegar Arma",
                    action = function()
                        local ped = PlayerPedId()
                        ClearPedTasksImmediately(ped)
                        FreezeEntityPosition(ped, true)
                        PlayAnim(ped, "pickup_object", "pickup_low", -8.0, 8.0, -1, 49, 1.0)
                        Citizen.Wait(800)
                        
                        -- Dispara o evento para pegar a arma
                        TriggerServerEvent("pierre_weapons:pickupWeapon", k)
                        
                        -- Remove o target após pegar a arma
                        exports["qb-target"]:RemoveZone(zoneName)
                        CreatedZones[k] = nil -- Remove da tabela de zonas criadas

                        Citizen.Wait(800)
                        ClearPedTasks(ped)
                        FreezeEntityPosition(ped, false)
                    end
                }
            },
            distance = 2.5
        })
    end
end




--[[ Citizen.CreateThread(function()
    for k, v in pairs(ThrownWeapons) do
        local weaponNetId = v.net_id

        if NetworkDoesNetworkIdExist(weaponNetId) then
            local entity = NetToObj(weaponNetId)
            local coords = GetEntityCoords(entity)

            print("Weapon ID:", k, "Coords:", coords)


            if Config.TargetSystem == "qb-target" then
                exports["qb-target"]:AddCircleZone("weapon_pickup_" .. k, coords, 1.25, {
                    name = "weapon_pickup_" .. k,
                    debugPoly = false,
                    useZ = true
                }, {
                    options = {
                        {
                            icon = "fas fa-hand-paper",
                            label = "Pegar Arma",
                            action = function()
                                local ped = PlayerPedId()
                                if not IsPlayerDead(ped) and not IsPedInAnyVehicle(ped, true) then
                                    ClearPedTasksImmediately(ped)
                                    FreezeEntityPosition(ped, true)
                                    PlayAnim(ped, "pickup_object", "pickup_low", -8.0, 8.0, -1, 49, 1.0)
                                    Citizen.Wait(800)
                                    TriggerServerEvent("pierre_weapons:pickupWeapon", k)
                                    Citizen.Wait(800)
                                    ClearPedTasks(ped)
                                    FreezeEntityPosition(ped, false)
                                end
                            end
                        }
                    },
                    distance = 2.5
                })
            end
        end
    end
end) ]]


local MeeleWeapons = {
    ["WEAPON_NIGHTSTICK"] = Config.MeeleWeapons,
    ["WEAPON_GOLFCLUB"] = Config.MeeleWeapons,
    ["WEAPON_FLASHLIGHT"] = Config.MeeleWeapons,
    ["WEAPON_DAGGER"] = Config.MeeleWeapons,
    ["WEAPON_BAT"] = Config.MeeleWeapons,
    ["WEAPON_BOTTLE"] = Config.MeeleWeapons,
    ["WEAPON_CROWBAR"] = Config.MeeleWeapons,
    ["WEAPON_HAMMER"] = Config.MeeleWeapons,
    ["WEAPON_HATCHET"] = Config.MeeleWeapons,
    ["WEAPON_KNUCKLE"] = Config.MeeleWeapons,
    ["WEAPON_KNIFE"] = Config.MeeleWeapons,
    ["WEAPON_MACHETE"] = Config.MeeleWeapons,
    ["WEAPON_SWITCHBLADE"] = Config.MeeleWeapons,
    ["WEAPON_WRENCH"] = Config.MeeleWeapons,
    ["WEAPON_BATTLEAXE"] = Config.MeeleWeapons,
    ["WEAPON_POOLCUE"] = Config.MeeleWeapons,
    ["WEAPON_STONE_HATCHET"] = Config.MeeleWeapons,
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)

		for weapon, modifier in pairs(MeeleWeapons) do
			if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(weapon) then
				SetPlayerMeleeWeaponDamageModifier(PlayerId(), v)
			end
		end
    end
end)
-- ARMAS DE FOGO
Citizen.CreateThread(function()
    while true do
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 2.0)
    SetWeaponDamageModifier(GetHashKey("weapon_pistol"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_pistol_mk2"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_combatpistol"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_appistol"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_stungun"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_pistol50"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_snspistol"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_snspistol_mk2"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_heavypistol"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_vintagepistol"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_flaregun"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_marksmanpistol"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_revolver"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_revolver_mk2"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_doubleaction"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_raypistol"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_ceramicpistol"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_navyrevolver"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_gadgetpistol"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_stungun_mp"), Config.weaponPiltos)
    SetWeaponDamageModifier(GetHashKey("weapon_pistolxm3"), Config.weaponPiltos)

    --Submachine Guns

    SetWeaponDamageModifier(GetHashKey("weapon_microsmg"), Config.SubmachineGuns)
    SetWeaponDamageModifier(GetHashKey("weapon_smg"), Config.SubmachineGuns)
    SetWeaponDamageModifier(GetHashKey("weapon_smg_mk2"), Config.SubmachineGuns)
    SetWeaponDamageModifier(GetHashKey("weapon_assaultsmg"), Config.SubmachineGuns)
    SetWeaponDamageModifier(GetHashKey("weapon_combatpdw"), Config.SubmachineGuns)
    SetWeaponDamageModifier(GetHashKey("weapon_machinepistol"), Config.SubmachineGuns)
    SetWeaponDamageModifier(GetHashKey("weapon_minismg"), Config.SubmachineGuns)
    SetWeaponDamageModifier(GetHashKey("weapon_raycarbine"), Config.SubmachineGuns)
    SetWeaponDamageModifier(GetHashKey("weapon_tecpistol"), Config.SubmachineGuns)

    --Shotguns

    SetWeaponDamageModifier(GetHashKey("weapon_pumpshotgun"), Config.Shotguns)
    SetWeaponDamageModifier(GetHashKey("weapon_pumpshotgun_mk2"), Config.Shotguns)
    SetWeaponDamageModifier(GetHashKey("weapon_sawnoffshotgun"), Config.Shotguns)
    SetWeaponDamageModifier(GetHashKey("weapon_assaultshotgun"), Config.Shotguns)
    SetWeaponDamageModifier(GetHashKey("weapon_bullpupshotgun"), Config.Shotguns)
    SetWeaponDamageModifier(GetHashKey("weapon_musket"), Config.Shotguns)
    SetWeaponDamageModifier(GetHashKey("weapon_heavyshotgun"), Config.Shotguns)
    SetWeaponDamageModifier(GetHashKey("weapon_dbshotgun"), Config.Shotguns)
    SetWeaponDamageModifier(GetHashKey("weapon_autoshotgun"), Config.Shotguns)
    SetWeaponDamageModifier(GetHashKey("weapon_combatshotgun"), Config.Shotguns)

    --Assault Rifles

    SetWeaponDamageModifier(GetHashKey("weapon_assaultrifle"), Config.AssaultRifles)
    SetWeaponDamageModifier(GetHashKey("weapon_assaultrifle_mk2"), Config.AssaultRifles)
    SetWeaponDamageModifier(GetHashKey("weapon_carbinerifle"), Config.AssaultRifles)
    SetWeaponDamageModifier(GetHashKey("weapon_carbinerifle_mk2"), Config.AssaultRifles)
    SetWeaponDamageModifier(GetHashKey("weapon_advancedrifle"), Config.AssaultRifles)
    SetWeaponDamageModifier(GetHashKey("weapon_specialcarbine"), Config.AssaultRifles)
    SetWeaponDamageModifier(GetHashKey("weapon_specialcarbine_mk2"), Config.AssaultRifles)
    SetWeaponDamageModifier(GetHashKey("weapon_bullpuprifle"), Config.AssaultRifles)
    SetWeaponDamageModifier(GetHashKey("weapon_bullpuprifle_mk2"), Config.AssaultRifles)
    SetWeaponDamageModifier(GetHashKey("weapon_compactrifle"), Config.AssaultRifles)
    SetWeaponDamageModifier(GetHashKey("weapon_militaryrifle"), Config.AssaultRifles)
    SetWeaponDamageModifier(GetHashKey("weapon_heavyrifle"), Config.AssaultRifles)
    SetWeaponDamageModifier(GetHashKey("weapon_tacticalrifle"), Config.AssaultRifles)

    --Light Machine Guns

    SetWeaponDamageModifier(GetHashKey("weapon_mg"), Config.LightMachineGuns)
    SetWeaponDamageModifier(GetHashKey("weapon_combatmg"), Config.LightMachineGuns)
    SetWeaponDamageModifier(GetHashKey("weapon_combatmg_mk2"), Config.LightMachineGuns)
    SetWeaponDamageModifier(GetHashKey("weapon_gusenberg"), Config.LightMachineGuns)

    --Sniper Rifles

    SetWeaponDamageModifier(GetHashKey("weapon_sniperrifle"), Config.SniperRifles)
    SetWeaponDamageModifier(GetHashKey("weapon_heavysniper"), Config.SniperRifles)
    SetWeaponDamageModifier(GetHashKey("weapon_heavysniper_mk2"), Config.SniperRifles)
    SetWeaponDamageModifier(GetHashKey("weapon_marksmanrifle"), Config.SniperRifles)
    SetWeaponDamageModifier(GetHashKey("weapon_marksmanrifle_mk2"), Config.SniperRifles)
    SetWeaponDamageModifier(GetHashKey("weapon_precisionrifle"), Config.SniperRifles)

    --Heavy Weapons

    SetWeaponDamageModifier(GetHashKey("weapon_rpg"), Config.HeavyWeapons)
    SetWeaponDamageModifier(GetHashKey("weapon_grenadelauncher"), Config.HeavyWeapons)
    SetWeaponDamageModifier(GetHashKey("weapon_minigun"), Config.LightMachineGuns)
    
	Wait(0)
    end
end)