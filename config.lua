Config = {}

Config.TargetSystem = "qb-target"               -- Só tem esse, nao gostou FDS!

Config.Target = true                            -- true ativa a opção do Target, false ativa TextUI

Config.Debug = false                            -- Modo de debugação

Config.Language = "pt-br"                       -- Idioma

Config.limparprops = "propdrop"                 -- remove as armas atacadas caso bug

Config.attachs = 'propstuck'                    -- ataca os objetos 

Config.WeaponAnimation = true                   -- sempre, correndo

Config.DropWeaponWhenHitHand = true             -- Se você quiser soltar a arma quando acertar a mão, poderá alterá -la para True.Se você não quiser soltar a arma, pode alterá -la para falsa.

Config.DeathDropsWeapon = true                  -- Deixa cair sua arma atual após a morte.

Config.ThrowKeybind = "l"                       -- Jogar arma fora  Jogue keybind

Config.TakeKeybind = 182                        -- Pegar arma

Config.MeeleWeapons = 1.8                       -- Dano da Classe Arma branca

Config.weaponPiltos = 1.7                       -- Dano da Classe Pistolas

Config.SubmachineGuns = 2.9                     -- Dano da Classe Submetralhadoras

Config.Shotguns = 5.9                           -- Dano da Classe Escopetas

Config.AssaultRifles = 3.4                      -- Dano da Classe Rifle de assaulto

Config.LightMachineGuns = 3.6                   -- Dano da Classe Machine guns

Config.SniperRifles = 8.7                       -- Dano da Classe Snipers

Config.HeavyWeapons = 8.7                       -- Dano da Classe RPG, granadas,lança granada etc...

Config.ChangeWeaponlightshot = "e"              -- ligar lanterna e persistir

Config.Weapons = { -- Qualquer arma nesta lista é jogável.
    "WEAPON_DAGGER",
    "WEAPON_BAT",
    "WEAPON_BOTTLE",
    "WEAPON_CROWBAR",
    "WEAPON_FLASHLIGHT",
    "WEAPON_GOLFCLUB",
    "WEAPON_HAMMER",
    "WEAPON_HATCHET",
    "WEAPON_KNUCKLE",
    "WEAPON_KNIFE",
    "WEAPON_MACHETE",
    "WEAPON_SWITCHBLADE",
    "WEAPON_NIGHTSTICK",
    "WEAPON_WRENCH",
    "WEAPON_BATTLEAXE",
    "WEAPON_POOLCUE",
    "WEAPON_STONE_HATCHET",
    "WEAPON_PISTOL",
    "WEAPON_PISTOL_MK2",
    "WEAPON_COMBATPISTOL",
    "WEAPON_APPISTOL",
    "WEAPON_STUNGUN",
    "WEAPON_PISTOL50",
    "WEAPON_SNSPISTOL",
    "WEAPON_SNSPISTOL_MK2",
    "WEAPON_HEAVYPISTOL",
    "WEAPON_VINTAGEPISTOL",
    "WEAPON_FLAREGUN",
    "WEAPON_MARKSMANPISTOL",
    "WEAPON_REVOLVER",
    "WEAPON_REVOLVER_MK2",
    "WEAPON_DOUBLEACTION",
    "WEAPON_RAYPISTOL",
    "WEAPON_CERAMICPISTOL",
    "WEAPON_NAVYREVOLVER",
    "WEAPON_MICROSMG",
    "WEAPON_SMG",
    "WEAPON_SMG_MK2",
    "WEAPON_ASSAULTSMG",
    "WEAPON_COMBATPDW",
    "WEAPON_MACHINEPISTOL",
    "WEAPON_MINISMG",
    "WEAPON_RAYCARBINE",
    "WEAPON_PUMPSHOTGUN",
    "WEAPON_PUMPSHOTGUN_MK2",
    "WEAPON_SAWNOFFSHOTGUN",
    "WEAPON_ASSAULTSHOTGUN",
    "WEAPON_BULLPUPSHOTGUN",
    "WEAPON_MUSKET",
    "WEAPON_HEAVYSHOTGUN",
    "WEAPON_DBSHOTGUN",
    "WEAPON_AUTOSHOTGUN",
    "WEAPON_ASSAULTRIFLE",
    "WEAPON_ASSAULTRIFLE_MK2",
    "WEAPON_CARBINERIFLE",
    "WEAPON_CARBINERIFLE_MK2",
    "WEAPON_ADVANCEDRIFLE",
    "WEAPON_SPECIALCARBINE",
    "WEAPON_SPECIALCARBINE_MK2",
    "WEAPON_BULLPUPRIFLE",
    "WEAPON_BULLPUPRIFLE_MK2",
    "WEAPON_COMPACTRIFLE",
    "WEAPON_MG",
    "WEAPON_COMBATMG",
    "WEAPON_COMBATMG_MK2",
    "WEAPON_GUSENBERG",
    "WEAPON_SNIPERRIFLE",
    "WEAPON_HEAVYSNIPER",
    "WEAPON_HEAVYSNIPER_MK2",
    "WEAPON_MARKSMANRIFLE",
    "WEAPON_MARKSMANRIFLE_MK2",
    "WEAPON_RPG",
    "WEAPON_GRENADELAUNCHER",
    "WEAPON_GRENADELAUNCHER_SMOKE",
    "WEAPON_MINIGUN",
    "WEAPON_FIREWORK",
    "WEAPON_RAILGUN",
    "WEAPON_HOMINGLAUNCHER",
    "WEAPON_COMPACTLAUNCHER",
    "WEAPON_RAYMINIGUN",
}
Config.AimWeapons = {
    "weapon_pistol",
    "weapon_pistol_mk2",
    "weapon_combatpistol",
    "weapon_appistol",
    "weapon_stungun",
    "weapon_pistol50",
    "weapon_snspistol",
    "weapon_snspistol_mk2",
    "weapon_heavypistol",
    "weapon_vintagepistol",
    "weapon_flaregun",
    "weapon_marksmanpistol",
    "weapon_revolver",
    "weapon_revolver_mk2",
    "weapon_doubleaction",
    "weapon_raypistol",
    "weapon_ceramicpistol",
    "weapon_navyrevolver",
    "weapon_gadgetpistol",
    "weapon_stungun_mp",
    "weapon_pistolxm3",
}
Config.DrawingWeapons = {
    "weapon_pistol",
    "weapon_pistol_mk2",
    "weapon_combatpistol",
    "weapon_appistol",
    "weapon_stungun",
    "weapon_pistol50",
    "weapon_snspistol",
    "weapon_snspistol_mk2",
    "weapon_heavypistol",
    "weapon_vintagepistol",
    "weapon_flaregun",
    "weapon_marksmanpistol",
    "weapon_revolver",
    "weapon_revolver_mk2",
    "weapon_doubleaction",
    "weapon_raypistol",
    "weapon_ceramicpistol",
    "weapon_navyrevolver",
    "weapon_gadgetpistol",
    "weapon_stungun_mp",
    "weapon_pistolxm3",
}