# pierre_weapons
 
###  Sistema de armas para manipular!

### Funções que o script faz.

- Lançar arma.                                                         - Configurávem para Target ou TextUi
- Pegar arma.                                                          - Configurávem para Target ou TextUi
- Posicionar pistola e revolver na cintura.                            - Configurável quais podem aparecer.
- Posicionar submetralhadora, rifle, lightmachine, sniper nas costas   - Configurável quais podem aparecer.
- Idioma                                                               - Idioma a ser definido
- Animação de correr com armas na mão                                  - Modo de correr com a arma na mão
- Soltar arma no chão ao morrer                                        - Quando morre independente da forma se estiver empunhando arma vao dropar no chão
- Soltar arma ao recer tiro                                            - Soltar a arma caso leve tiro na mão "será desarmado"
- Controle personalizável                                              - Botões personalizáveis ao soltar armas e pegar
- Modo de interação                                                    - Escolher modo de interação ao interagir com as armas dropada usando Qb-target ou TextUi
- Controle de dano das armas por classificação                         - Define a configuração individualmente de cada classe armas
- Controle da lanterna                                                 - Liga e mantém a lanterna ligada mesmo não estando empunhada

## Dependências

- Qb-target
- Ox_target
- Qb-core
- Qbox-core
- Ox_lib


## Configuração

```lua
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
```


![image](https://github.com/user-attachments/assets/5504d031-15b2-4e17-b897-a3ee633a3d2f)


![image](https://github.com/user-attachments/assets/11d5a504-3074-48d1-ae5b-a247c985d680)


[Assista ao vídeo](https://www.youtube.com/watch?v=VTTCEAAXg4o)




## Creditos


[PickleModifications](https://github.com/PickleModifications)



[Felps](https://github.com/FelpsDeveloper3001/FelpsDeveloper3001)
