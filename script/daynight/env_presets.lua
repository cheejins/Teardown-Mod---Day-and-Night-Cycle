ENV_PRESETS = {}

function ManageEnvLerping()


    -- Find the index of the current phase of day.
    local phaseIndex = FindTableItemByValue(DayPhasesTable, 'name', GetDayPhase())

    -- Index of the next phase of day.
    local nextPhaseIndex = GetTableNextIndex(DayPhasesTable, phaseIndex)

    local env1 = DayPhasesTable[phaseIndex].env -- Base env.
    local env2 = DayPhasesTable[nextPhaseIndex].env -- Lerp target env.

    DebugWatch('env1', DayPhasesTable[phaseIndex].name)
    DebugWatch('env2', DayPhasesTable[nextPhaseIndex].name)


    -- osc = oscillate(24 / 4)
    local osc = (GetTime() / 6 * TimeRate) % 1

    LerpENVs(DeepCopy(env1), DeepCopy(env2), osc)

    if InputPressed('l') then printEnv() end

end

function LerpENVs(env_preset1, env_preset2, fraction)

    DebugWatch('fraction', fraction)

    for key, header in pairs(env_preset1) do -- header = env categories.
        for name, env in pairs(header) do -- env = specific env table

            local p2env = env_preset2[key][name]

            for i = 1, 4 do

                if type(env[i]) == 'number' then

                    env[i] = lerp(env[i], p2env[i], fraction)

                    if env[i] ~= 0 and env[i] ~= 1 then
                        DebugWatch(name, env[i])
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

            -- if type(env[1]) == 'boolean' then
            --     DebugWatch(name, env[1])
            -- elseif type(env[1]) == 'string' then
            --     DebugWatch(name, env[1])
            -- end

            SetEnvironmentProperty(name, env[1], env[2], env[3], env[4])

        end
    end

    SetEnvironmentProperty('sunDir', 0, GetTime(), 0)
    SetEnvironmentProperty('skyboxrot', GetTime())

end

ENV_PRESETS.sunrise = {

    Skybox = {
        skybox = {"cloudy.dds"},
        skyboxbrightness = {0.60000002384186},
        skyboxtint = {1, 0.40000000596046, 0.20000000298023},
        skyboxrot = {0}
    },
    Sun = {
        sunDir = {0, 0, 0},
        sunBrightness = {0},
        sunFogScale = {1},
        sunSpread = {0},
        sunLength = {32},
        sunColorTint = {1, 1, 1},
        sunGlare = {1}
    },
    Fog = {
        fogParams = {30, 160, 0.94999998807907, 6},
        fogColor = {1, 0.20000000298023, 0.10000000149012},
        fogscale = {1}
    },
    Lighting = {
        nightlight = {true},
        ambient = {1},
        constant = {0.003000000026077, 0.003000000026077, 0.003000000026077},
        brightness = {1},
        exposure = {1, 5},
        ambientexponent = {1.2999999523163}
    },
    Rain = {puddleamount = {0}, rain = {0}, wetness = {0}, puddlesize = {0.5}},
    Misc = {
        slippery = {0},
        wind = {0, 0, 0},
        ambience = {"outdoor/field.ogg", 1},
        waterhurt = {0}
    },
    Snow = {snowonground = {}, snowamount = {0, 0}, snowdir = {0, -1, 0, 0}}
}

ENV_PRESETS.sunny = {
    Skybox = {
        skybox = {"cloudy.dds"},
        skyboxbrightness = {0.69999998807907},
        skyboxtint = {1, 1, 1},
        skyboxrot = {0}
    },
    Sun = {
        sunDir = {0, 0, 0},
        sunBrightness = {4},
        sunFogScale = {0.15000000596046},
        sunSpread = {0},
        sunLength = {32},
        sunColorTint = {1, 0.80000001192093, 0.60000002384186},
        sunGlare = {1}
    },
    Fog = {
        fogParams = {50, 200, 0.89999997615814, 8},
        fogColor = {0.89999997615814, 0.89999997615814, 0.89999997615814},
        fogscale = {1}
    },
    Lighting = {
        nightlight = {false},
        ambient = {1},
        constant = {0.003000000026077, 0.003000000026077, 0.003000000026077},
        brightness = {1},
        exposure = {1, 5},
        ambientexponent = {1.2999999523163}
    },
    Rain = {puddleamount = {0}, rain = {0}, wetness = {0}, puddlesize = {0.5}},
    Misc = {
        slippery = {0},
        wind = {0, 0, 0},
        ambience = {"outdoor/field.ogg", 1},
        waterhurt = {0}
    },
    Snow = {snowonground = {}, snowamount = {0, 0}, snowdir = {0, -1, 0, 0}}
}

ENV_PRESETS.sunset = {

    Skybox = {
        skybox = {"cloudy.dds"},
        skyboxbrightness = {1},
        skyboxtint = {1, 0.5, 0.20000000298023},
        skyboxrot = {0}
    },
    Sun = {
        sunDir = {0, 0, 0},
        sunBrightness = {1},
        sunFogScale = {1},
        sunSpread = {0},
        sunLength = {32},
        sunColorTint = {0.20000000298023, 0.30000001192093, 1},
        sunGlare = {0.80000001192093}
    },
    Fog = {
        fogParams = {80, 200, 1, 6},
        fogColor = {0.30000001192093, 0.20000000298023, 0.079999998211861},
        fogscale = {1}
    },
    Lighting = {
        nightlight = {false},
        ambient = {1},
        constant = {0.003000000026077, 0.003000000026077, 0.003000000026077},
        brightness = {1},
        exposure = {1, 5},
        ambientexponent = {1.2999999523163}
    },
    Rain = {puddleamount = {0}, rain = {0}, wetness = {0}, puddlesize = {0.5}},
    Misc = {
        slippery = {0},
        wind = {0, 0, 0},
        ambience = {"outdoor/field.ogg", 1},
        waterhurt = {0}
    },
    Snow = {snowonground = {}, snowamount = {0, 0}, snowdir = {0, -1, 0, 0}}
}

ENV_PRESETS.night = {

    Skybox = {
        skybox = {"cloudy.dds"},
        skyboxbrightness = {0.050000000745058},
        skyboxtint = {1, 1, 1},
        skyboxrot = {0}
    },
    Sun = {
        sunDir = {0, 0, 0},
        sunBrightness = {0},
        sunFogScale = {1},
        sunSpread = {0},
        sunLength = {32},
        sunColorTint = {1, 1, 1},
        sunGlare = {1}
    },
    Fog = {
        fogParams = {20, 120, 0.89999997615814, 2},
        fogColor = {0.019999999552965, 0.019999999552965, 0.024000000208616},
        fogscale = {1}
    },
    Lighting = {
        nightlight = {true},
        ambient = {1},
        constant = {0.003000000026077, 0.003000000026077, 0.003000000026077},
        brightness = {1},
        exposure = {1, 5},
        ambientexponent = {1.2999999523163}
    },
    Rain = {puddleamount = {0}, rain = {0}, wetness = {0}, puddlesize = {0.5}},
    Misc = {
        slippery = {0},
        wind = {0, 0, 0},
        ambience = {"outdoor/night.ogg", 0},
        waterhurt = {0}
    },
    Snow = {snowonground = {}, snowamount = {0, 0}, snowdir = {0, 0, 1, 0}}
}

ENV_PRESETS.rainynight = {
    Skybox = {
        skybox = {"cloudy.dds"},
        skyboxbrightness = {0.019999999552965},
        skyboxtint = {1, 1, 1},
        skyboxrot = {0}
    },
    Sun = {
        sunDir = {0, 0, 0},
        sunBrightness = {0},
        sunFogScale = {1},
        sunSpread = {0},
        sunLength = {32},
        sunColorTint = {1, 1, 1},
        sunGlare = {1}
    },
    Fog = {
        fogParams = {10, 90, 0.89999997615814, 2},
        fogColor = {0.019999999552965, 0.019999999552965, 0.024000000208616},
        fogscale = {1}
    },
    Lighting = {
        nightlight = {true},
        ambient = {1},
        constant = {0.003000000026077, 0.003000000026077, 0.003000000026077},
        brightness = {1},
        exposure = {1, 5},
        ambientexponent = {1.2999999523163}
    },
    Rain = {
        puddleamount = {0.69999998807907},
        rain = {0.89999997615814},
        wetness = {0.69999998807907},
        puddlesize = {0.69999998807907}
    },
    Misc = {
        slippery = {0.30000001192093},
        wind = {0, 0, 0},
        ambience = {"outdoor/rain_heavy.ogg", 1},
        waterhurt = {0}
    },
    Snow = {
        snowonground = {},
        snowamount = {0, 0.20000000298023},
        snowdir = {0, -1, 0, 0}
    }
}

MenuItems = {
    Lighting = {
        constant = {
            name = "Constant Light",
            desc = "Base light, always contributes no matter\nlighting conditions.",
            args = 3
        },
        ambient = {
            name = "Ambient Light",
            desc = "Determines how much the skybox will\nlight up the scene."
        },
        ambientexponent = {
            name = "Ambient Exponent",
            desc = "Determines ambient light falloff when occluded.\nHigher value = darker indoors."
        },
        exposure = {
            name = "Exposure Limits",
            desc = "Limits for automatic exposure, min max",
            args = 2
        },
        brightness = {
            name = "Brightness",
            desc = "Desired scene brightness that controls\nautomatic exposure. Set higher for brighter scene."
        },
        nightlight = {
            name = "Night Lights",
            desc = "If set to false, all lights tagged night will be removed.",
            bool = true
        }
    },
    Skybox = {
        skybox = {
            name = "Skybox",
            desc = "The dds file used as skybox.\nSearch path is data/env.",
            string = true,
            dd = {
                "cannon_2k.dds", "cloudy.dds", "cold_dramatic_clouds.dds",
                "cold_sunny_evening.dds", "cold_sunset.dds",
                "cold_wispy_sky.dds", "cool_clear_sunrise.dds", "cool_day.dds",
                "day.dds", "industrial_sunset_2k.dds", "jk2.dds", "moonlit.dds",
                "night.dds", "night_clear.dds", "overcast_day.dds",
                "sunflowers_2k.dds", "sunset.dds",
                "sunset_in_the_chalk_quarry_2k.dds", "tornado.dds"
            }
        },
        skyboxtint = {
            name = "Skybox Tint",
            desc = "The skybox color tint",
            args = 3,
            color = true
        },
        skyboxbrightness = {
            name = "Skybox Brightness",
            desc = "The skybox brightness scale"
        },
        skyboxrot = {
            name = "Skybox Rotation",
            desc = "The skybox rotation around the y axis.\nUse this to determine angle of sun shadows."
        }
    },
    Fog = {
        fogColor = {
            name = "Fog Color",
            desc = "Color used for distance fog",
            args = 3,
            color = true
        },
        fogParams = {
            name = "Fog Parameters",
            desc = "Four fog parameters: fog start, fog end, fog amount,\nfog exponent (higher gives steeper falloff along y axis)",
            args = 4
        },
        fogscale = {
            name = "Fog Scale",
            desc = "Scale fog value on all light sources with this amount"
        }
    },
    Sun = {
        sunBrightness = {
            name = "Sun Brightness",
            desc = "Light contribution by sun (gives directional shadows)"
        },
        sunColorTint = {
            name = "Sun Tint",
            desc = "Color tint of sunlight.\nMultiplied with brightest spot in skybox",
            args = 3,
            color = true
        },
        sunDir = {
            name = "Sun Direction",
            desc = "Direction of sunlight. A value of zero\nwill point from brightest spot in skybox",
            args = 3
        },
        sunSpread = {
            name = "Sun Spread",
            desc = "Divergence of sunlight as a fraction. A value\nof 0.05 will blur shadows 5 cm per meter"
        },
        sunLength = {
            name = "Sun Length",
            desc = "Maximum length of sunlight shadows.\nAS low as possible for best performance"
        },
        sunFogScale = {
            name = "Sun Fog Scale",
            desc = "Volumetic fog caused by sunlight"
        },
        sunGlare = {name = "Sun Glare", desc = "Sun glare scaling"}
    },
    Rain = {
        wetness = {name = "Wetness", desc = "Base wetness"},
        puddleamount = {
            name = "Puddle Amount",
            desc = "Puddle coverage. Fraction between zero and one"
        },
        puddlesize = {name = "Puddle Size", desc = "Puddle size"},
        rain = {name = "Rain Amount", desc = "Amount of rain"}
    },
    Snow = {
        snowdir = {
            name = "Snow Direction",
            desc = "Snow direction, x, y, z, and spread"
        },
        snowamount = {name = "Snow Amount", desc = "Snow particle amount (0-1)"},
        snowonground = {
            name = "Snow on Ground",
            desc = "Generate snow on ground",
            bool = true
        }
    },
    Misc = {
        ambience = {
            name = "Ambience",
            desc = "Environment sound path",
            string = true,
            dd = {
                "indoor/cave.ogg", "indoor/dansband.ogg", "indoor/factory.ogg",
                "indoor/factory0.ogg", "indoor/factory1.ogg",
                "indoor/factory2.ogg", "indoor/mall.ogg",
                "indoor/small_room0.ogg", "indoor/small_room1.ogg",
                "indoor/small_room2.ogg", "indoor/small_room3.ogg",
                "outdoor/caribbean.ogg", "outdoor/caribbean_ocean.ogg",
                "outdoor/field.ogg", "outdoor/forest.ogg", "outdoor/lake.ogg",
                "outdoor/lake_birds.ogg", "outdoor/night.ogg",
                "outdoor/ocean.ogg", "outdoor/rain_heavy.ogg",
                "outdoor/rain_light.ogg", "outdoor/wind.ogg",
                "outdoor/winter.ogg", "outdoor/winter_snowstorm.ogg",
                "woonderland/lee_woonderland_cabins.ogg",
                "woonderland/lee_woonderland_freefall.ogg",
                "woonderland/lee_woonderland_motorcycles.ogg",
                "woonderland/lee_woonderland_sea_side_swings.ogg",
                "woonderland/lee_woonderland_swanboats.ogg",
                "woonderland/lee_woonderland_tire_carousel.ogg",
                "woonderland/lee_woonderland_wheel_of_woo.ogg",
                "woonderland/lee_woonderland_woocars.ogg", "underwater.ogg"
            }
        },
        slippery = {
            name = "Slipperiness",
            desc = "Slippery road. Affects vehicles when outdoors"
        },
        waterhurt = {
            name = "Water Damage",
            desc = "Players take damage being in water. If above zero,\nhealth will decrease and not regenerate in water"
        },
        wind = {
            name = "Wind Strength",
            desc = "Wind direction and strength: x y z",
            args = 3
        } -- I dunno, don't ask?
    }
}

function printEnv()

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
