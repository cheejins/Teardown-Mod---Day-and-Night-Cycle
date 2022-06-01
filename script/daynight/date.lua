#include "env_presets.lua"
#include "utility.lua"


function InitTime()

    TIME_RUN = true

    TimeRate = 1

    Seconds = 0
    r,g,b = 1,1,1

    DayPhasesTable = {
        { name = 'Morning', startH = 6, env = ENV_PRESETS.sunrise},
        { name = 'Noon',    startH = 12, env = ENV_PRESETS.sunny},
        { name = 'Evening', startH = 18, env = ENV_PRESETS.sunset},
        { name = 'Night',   startH = 24, env = ENV_PRESETS.night},
    }

    EnvTimer = TimerCreate(0, 180)
    TimerResetTime(EnvTimer)

end
function ManageTime()

    if InputPressed('r') then
        Seconds = 0
    end

    if InputPressed('t') then
        TIME_RUN = not TIME_RUN
    end

    if InputPressed('o') then
        SetTime24(6, 9, 6, 9)
    end

    if InputPressed('p') then
        AddTime24(1, 1, 1, 1)
    end

    if TIME_RUN then

        Seconds = Seconds + GetTimeStep() * 60 * 60 * TimeRate
        Minutes = SecondsToMinutes(Seconds)
        Hours = SecondsToHours(Seconds)
        Days = SecondsToDays(Seconds)

        Time = GetTimeStamp()
        Time12 = GetTimeFormatted12H(Seconds)

    end

    ManageEnvLerping()

end
function DrawTime()
    if TIME_RUN then

        UiAlign('center middle')
        UiFont('regular.ttf', 48)
        UiColor(1,1,1, 1)
        UiTextShadow(0,0,0, 0.5, 1,1)


        UiTranslate(UiCenter(), UiMiddle() + 100)
        UiText(Time)

        UiTranslate(0, 60)
        UiText(Time12)

        UiTranslate(0, 60)
        UiText(GetDayPhase())

    end
end



--- Convert the current time or seconds to a 12h time string. Returns something like "12:32 AM"
---@param seconds number Total number of seconds to convert to 12h time.
---@return string
function GetTimeFormatted12H(seconds)

    local h = ternary(seconds, SecondsToHours(seconds), Hours)
    local m = ternary(seconds, SecondsToMinutes(seconds), Minutes)

    local ampm = ternary(Hours % 24 >= 12, 'PM', 'AM')
    local timeStr = sfnPadZeroes(sfnInt(h) % 12, 2) .. ':' .. sfnPadZeroes(sfnInt(m) % 60, 2) .. ' ' .. ampm

    return timeStr

end


-- Convert time to a formatted full time clock. Example: "d:1 h:21 m:34 s:02"
function GetTimeStamp()
    return
    'd:' .. sfnPadZeroes(sfnInt(Days)) .. '  ' ..
    'h:' .. sfnPadZeroes(sfnInt(Hours % 24)) .. '  ' ..
    'm:' .. sfnPadZeroes(sfnInt(Minutes % 60)) .. '  ' ..
    's:' .. sfnPadZeroes(sfnInt(Seconds % 60)) .. '  '
end


--- Gets the phase of the day from the DayPhases table. Ex: Morning, Noon, etc...
function GetDayPhase()

    local ht = Hours % 24 -- 24h

    for index, phase in ipairs(DayPhasesTable) do

        local nextPhase = DayPhasesTable[GetTableNextIndex(DayPhasesTable, index)]

        if phase.startH < nextPhase.startH then
            if ht >= phase.startH and ht <= nextPhase.startH then -- Check if ht is between phase interval.
                return phase.name
            end
        else
            if phase.startH - nextPhase.startH < 24 then -- Offset 24h loop and check interval.
                return phase.name
            end
        end

    end

end


---The number of hours between two hour values. Example: hours between 6 and 13 = 7 or 23 and 1 = 2.
---@param h1 number Earlier time.
---@param h2 number Later time.
function GetHourDistance(h1, h2)
    if h2 > h1 then -- No 24h loop.
        return h2 - h1
    else -- 24h loop.
        return math.abs(h1 - 24) + h2
    end
end


---Set the date/time by each unit of time.
---@param s number Seconds
---@param m number Minutes
---@param h number Hours
---@param d number Days
function SetTime24(s, m, h, d)

    local sec = 0

    sec = s
    sec = sec + MinutesToSeconds(m)
    sec = sec + HoursToSeconds(h)
    sec = sec + DaysToSeconds(d)

    Seconds = sec

end


---Add units of time to the existing time.
---@param s number Seconds
---@param m number Minutes
---@param h number Hours
---@param d number Days
function AddTime24(s, m, h, d)

    local sec = 0

    sec = s
    sec = sec + MinutesToSeconds(m)
    sec = sec + HoursToSeconds(h)
    sec = sec + DaysToSeconds(d)

    Seconds = Seconds + sec

end


-- Get phase of the day.
function isMorning() return GetDayPhase() == 'Morning' end
function isNoon() return GetDayPhase() == 'Noon' end
function isEvening() return GetDayPhase() == 'Evening' end
function isNight() return GetDayPhase() == 'Night' end


-- Time unit conversions.
function SecondsToMinutes(s) return s / 60 end
function SecondsToHours(s) return s / 60 / 60 end
function SecondsToDays(s) return s / 60 / 60 / 24 end
function DaysToSeconds(d) return d * 24 * 60 * 60 end
function HoursToSeconds(h) return h * 60 * 60 end
function MinutesToSeconds(m) return m * 60 end
