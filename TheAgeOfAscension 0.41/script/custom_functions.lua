-- Función para optimizar el rendimiento del juego desactivando ciertas características gráficas
function optimizarRendimiento()
    local settings = CGameSettings()
    
    -- Desactivar efectos de partículas y de luz volumétrica
    settings:SetParticleQuality(0) -- 0 indica desactivado
    settings:SetVolumetricLightQuality(0) -- 0 indica desactivado
    
    -- Reducir la calidad de las sombras
    settings:SetShadowQuality(0) -- 0 indica baja calidad de sombras
    
    -- Desactivar reflejos
    settings:SetReflections(false)
    
    -- Reducir la calidad de texturas
    settings:SetTextureQuality(0) -- 0 indica baja calidad de texturas
end

-- Función para optimizar el rendimiento del juego desactivando ciertas características gráficas
function optimizarRendimiento()
    -- Desactivar efectos de partículas
    particle_effect = CParticleEffect()
    particle_effect:SetActive(false)

    -- Reducir la calidad de las sombras
    shadows_quality = CShadowQuality()
    shadows_quality:SetQuality(0)  -- 0 indica baja calidad de sombras

    -- Desactivar reflejos
    reflections = CReflections()
    reflections:SetActive(false)

    -- Reducir la calidad de texturas
    texture_quality = CTextureQuality()
    texture_quality:SetQuality(0)  -- 0 indica baja calidad de texturas

    -- Desactivar efectos de luz volumétrica
    volumetric_light = CVolumetricLight()
    volumetric_light:SetActive(false)
end

-- Ajustar el tamaño del búfer de entrada para evitar errores de segmentación relacionados con la entrada del jugador
-- Este script debe ser ejecutado como un mod en Victoria 2

-- Función para ajustar el tamaño del búfer de entrada
function AjustarTamanoBufferEntrada()
    local settings = CGameSettings()
    local bufferSize = 1024 -- Tamaño mínimo del búfer para una jugabilidad adecuada
    settings:SetInputBuffer(bufferSize)
end

-- Script para reducir el consumo de RAM de Victoria 2

-- Configuración para reducir la calidad de las texturas
gfxSettings = {
    textureQuality = 1, -- Baja calidad de texturas
}

-- Configuración para reducir la cantidad de objetos en pantalla
gameSettings = {
    maxNumberOfObjects = 500, -- Reducir el número máximo de objetos en pantalla
}

-- Función para aplicar las configuraciones
function applySettings()
    -- Aplicar configuraciones de gráficos
    for key, value in pairs(gfxSettings) do
        gfx.setOption(key, value)
    end
    
    -- Aplicar configuraciones de juego
    for key, value in pairs(gameSettings) do
        game.setOption(key, value)
    end
end

-- Aplicar las configuraciones al cargar el juego
applySettings()

local posix = require("posix")
local lfs = require("lfs")

-- Configuración de umbral de uso de CPU (en porcentaje)
local CPU_THRESHOLD = 80

function main()
    while true do
        -- Obtener el uso de la CPU
        local cpuUsage = getCPUUsage()

        print("Uso de CPU:", cpuUsage .. "%")

        -- Si el uso de la CPU supera el umbral, buscar y cerrar procesos
        if cpuUsage > CPU_THRESHOLD then
            print("El uso de CPU supera el umbral. Buscando procesos para cerrar...")

            for processName in lfs.dir("/proc") do
                if tonumber(processName) then
                    local pid = tonumber(processName)
                    local cmdline = readCmdline(pid)

                    -- Cerrar procesos no esenciales
                    if not string.find(cmdline, "v2game.exe") and not string.find(cmdline, "v2game_x64.exe") then
                        print("Cerrando proceso:", cmdline)
                        posix.kill(pid, posix.SIGKILL)
                    end
                end
            end
        end

        -- Esperar antes de volver a verificar el uso de la CPU
        posix.sleep(10)
    end
end

-- Función para obtener el uso de la CPU
function getCPUUsage()
    local file = io.open("/proc/stat", "r")
    local line = file:read()
    file:close()

    local cpuStats = {}
    for value in line:gmatch("%d+") do
        table.insert(cpuStats, tonumber(value))
    end

    local totalCPUTime = 0
    for i = 1, #cpuStats do
        totalCPUTime = totalCPUTime + cpuStats[i]
    end

    local idleTime = cpuStats[4]
    local nonIdleTime = totalCPUTime - idleTime

    return math.floor(nonIdleTime / totalCPUTime * 100)
end

-- Función para leer la línea de comando de un proceso dado su PID
function readCmdline(pid)
    local file = io.open("/proc/" .. pid .. "/cmdline", "r")
    local cmdline = file:read("*all")
    file:close()

    return cmdline
end

main()

function optimizarRendimiento()
    local settings = CGameSettings()
    
    -- Desactivar efectos de partículas y de luz volumétrica
    settings:SetParticleQuality(0) -- 0 indica desactivado
    settings:SetVolumetricLightQuality(0) -- 0 indica desactivado
    
    -- Reducir la calidad de las sombras
    settings:SetShadowQuality(0) -- 0 indica baja calidad de sombras
    
    -- Desactivar reflejos
    settings:SetReflections(false)
    
    -- Reducir la calidad de texturas
    settings:SetTextureQuality(0) -- 0 indica baja calidad de texturas
end





