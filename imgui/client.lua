
require("imgui/imgui_enum")
require("imgui/extern")
require("imgui/clientui_jointeam")

local imgui_buy_context = {}

imgui_buy_open = true;
function HUD_OnGUI()
    CL_JoinTeam()
end
return HUD_OnGUI