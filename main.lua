#include "script/daynight/date.lua"


function init()
    InitTime()
end
function tick()
    ManageTime()
end
function draw()
    DrawTime()
end
