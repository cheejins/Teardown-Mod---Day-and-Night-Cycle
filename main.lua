#include "date.lua"
#include "utility.lua"



function init()
    InitTime()
end
function tick()
    ManageTime()
end

function draw()
    DrawTime()
end
