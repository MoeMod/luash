
require("imgui/mainui_newgame")
require("imgui/mainui_options")

function UI_OnGUI()
    UI_Options()
    UI_NewGame()
end
return UI_OnGUI