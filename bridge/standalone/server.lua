if GetResourceState('es_extended') == 'started' then return end
if GetResourceState('qb-core') == 'started' then return end

print("Você não está usando uma estrutura suportada, será necessário fazer edições nos arquivos da ponte.")