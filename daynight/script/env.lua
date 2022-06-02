function ManageEnvLerping()

    -- Find the index of the current phase of day.
    local phaseIndex = FindTableItemByValue(DayPhasesTable, 'name', GetDayPhase())

    -- Index of the next phase of day.
    local nextPhaseIndex = GetTableNextIndex(DayPhasesTable, phaseIndex)

    local env1 = DayPhasesTable[phaseIndex].env -- Base env.
    local env2 = DayPhasesTable[nextPhaseIndex].env -- Lerp target env.

    -- DebugWatch('env1', DayPhasesTable[phaseIndex].name)
    -- DebugWatch('env2', DayPhasesTable[nextPhaseIndex].name)


    local fraction = (GetTime() / 6 * TimeRate) % 1

    LerpENVs(DeepCopy(env1), DeepCopy(env2), fraction)

    -- SunDir = Vec(0, -1, 0)

    -- local dir2 = -2 * math.cos(math.pi * ((Hours)/12))


    SunDir[1] = -1 * math.cos((math.pi * ((Hours)/12)) + math.pi*0.5)
    SunDir[2] = -2 * math.cos(math.pi * ((Hours)/12))


    DebugWatch('SunDir', SunDir)

    SetEnvironmentProperty('sunDir', SunDir[1], SunDir[2], SunDir[3])


    if InputPressed('l') then PrintEnv() end

end


-- Get current environment properties and format it as a lua table, printed to the console.
function PrintEnv()

    for name, header in pairs(MenuItems) do

        print(name .. ' = {')

        for index, prop in pairs(header) do

            print('    ' .. index .. ' = {')

            local args = {GetEnvironmentProperty(index)}

            for i, val in ipairs(args) do

                if type(val) == 'string' then
                    val = '"' .. val .. '"'
                end

                print('        ' .. tostring(val) .. ',')

            end

            print('    },')

        end

        print('},')

    end

end

function LerpENVs(env_template1, env_template2, fraction)

    -- DebugWatch('fraction', fraction)

    for key, header in pairs(env_template1) do -- header = env categories.
        for name, env in pairs(header) do -- env = specific env table

            local p2env = env_template2[key][name]

            for i = 1, 4 do

                if type(env[i]) == 'number' then

                    env[i] = lerp(env[i], p2env[i], fraction)

                    if env[i] ~= 0 and env[i] ~= 1 then
                        -- DebugWatch(name, env[i])
                    end

                end

                if fraction > 0.5 then

                    if type(env[i]) == 'boolean' then
                        env[i] = p2env[i]
                    elseif type(env[i]) == 'string' then
                        env[i] = p2env[i]
                    end

                end

            end

            SetEnvironmentProperty(name, env[1], env[2], env[3], env[4])

        end
    end

    local hours = Hours % 24

    -- SetEnvironmentProperty('sunDir', unpack(SunDir))
    -- SetEnvironmentProperty('sunDir', 0, math.sin(math.pi * GetTime()), 0)
    -- SetEnvironmentProperty('skyboxrot', GetTime())

end