require("imgui/imgui_enum")
require("common/keydefs")

local cl_crosshair_size_values = {
    "auto",
    "small",
    "medium",
    "large"
}
local cl_crosshair_size_names = {
    "自动调整",
    "小",
    "中等",
    "大"
}
local sc = 1.0 / 255.0;

local function UI_ResetKeysList()
    local afile = engfunc.COM_LoadFile("gfx/shell/kb_def.lst", nil)
    if not afile then
        engfunc.Con_Printf( "UI_Parse_KeysList: kb_def.lst not found\n" )
        return
    end

    imgui_mainui_keys_def = {}
    local pfile = afile
    local token = cpp.new("char", 1024)

    pfile = engfunc.COM_ParseFile( pfile, token )
    local last_key = nil
    while pfile  do
        if last_key then
            local def = tostring(token)
            imgui_mainui_keys_def[last_key] = def
            last_key = nil
        else
            local key = tostring(token)
            last_key = key
        end
        pfile = engfunc.COM_ParseFile( pfile, token )
    end
    
    cpp.delete(token, 1024)
    engfunc.COM_FreeFile(afile)

    for key, def in pairs(imgui_mainui_keys_def) do
        engfunc.pfnClientCmd( 1, string.format("bind \"%s\" \"%s\"\n", key, def) )
    end
end

local function IsMouseKey(key)
    return key >= K_MOUSE1 and key <= K_MOUSE5
end
local function IsKeyboardKey(key)
    return key <= K_AUX32
end

local function UI_GetKeyBindings(cmd)
    local astBindings = {}
    for keynum = 0, 256 do
        local b = engfunc.pfnKeyGetBinding( keynum )
        if cmd == b then
            table.insert(astBindings, { m_iKeyNum = keynum, m_szKeyName = engfunc.pfnKeynumToString( keynum ) })
        end
    end
    return astBindings
end

local function UI_InitKeysList()
    local afile = engfunc.COM_LoadFile("gfx/shell/kb_act.lst", nil)
    if not afile then
        engfunc.Con_Printf( "UI_Parse_KeysList: kb_act.lst not found\n" )
        return
    end
    imgui_mainui_keys_act = {}
    local pfile = afile
    local token = cpp.new("char", 1024)
    
    pfile = engfunc.COM_ParseFile( pfile, token )
    local last_cmd = nil
    while pfile  do
        if last_cmd then
            table.insert(imgui_mainui_keys_act, { m_szCmd = last_cmd, m_szDesc = tostring(token), m_astBindings = UI_GetKeyBindings(last_cmd) })
            last_cmd = nil
        else
            last_cmd = tostring(token)
        end
        pfile = engfunc.COM_ParseFile( pfile, token )
    end
    
    cpp.delete(token, 1024)
    engfunc.COM_FreeFile(afile)
end

function UI_Options()
	if not window_option then
		return
	end
    
    imgui_utils.CenterNextWindow(ImGuiCond.Appearing);
    imgui.SetNextWindowSize(imgui_utils.GetScaledValue(480), imgui_utils.GetScaledValue(400), { "Appearing" })
    window_option = imgui.Begin("游戏设置", window_option)
    if imgui.BeginTabBar("OptionsDialog.TabBar") then
        if (imgui.BeginTabItem("多人运动")) then
            imgui.TextUnformatted("玩家名称");
            local buf = engfunc.pfnGetCvarString("name");
            local changed = false
            buf = imgui.InputText("name", buf, 32, { ImGuiInputTextFlags.CharsNoBlank })
            if buf then
                engfunc.pfnCvarSetString("name", buf);
            end
            imgui.TextUnformatted("准星外观");
            
            local cl_crosshair_type = engfunc.pfnGetCvarFloat("cl_crosshair_type");
            cl_crosshair_type = imgui.Combo("cl_crosshair_type", cl_crosshair_type, "十字型\0点射型\0圆形\0组合型\0单点\0")
            if cl_crosshair_type then
                engfunc.pfnCvarSetValue("cl_crosshair_type", cl_crosshair_type);
            end
            
            local cl_crosshair_size_idx = 1
            local cl_crosshair_size = engfunc.pfnGetCvarString("cl_crosshair_size");
            for i,v in ipairs(cl_crosshair_size_values) do
                if v == cl_crosshair_size then
                    cl_crosshair_size_idx = i
                    break
                end
            end
            cl_crosshair_size_idx = imgui.SliderInt("cl_crosshair_size", cl_crosshair_size_idx, 1, 4, cl_crosshair_size_names[cl_crosshair_size_idx])
            if cl_crosshair_size_idx then
                engfunc.pfnCvarSetString("cl_crosshair_size", cl_crosshair_size_values[cl_crosshair_size_idx]);
            end

            local crosshair_rgb = engfunc.pfnGetCvarString("cl_crosshair_color")
            local rgb = {}
            for value in string.gmatch(crosshair_rgb, "%d+") do 
                table.insert(rgb, tonumber(value)*sc)
            end
            local r, g, b = imgui.ColorEdit3("cl_crosshair_color", rgb[1], rgb[2], rgb[3])
            if r and g and b then
                rgb[1] = r * 255;
                rgb[2] = g * 255;
                rgb[3] = b * 255;
                engfunc.pfnCvarSetString("cl_crosshair_color", string.format("%d %d %d", rgb[1], rgb[2], rgb[3]));
            end
			imgui.TextUnformatted("控制台指令");   
			local csgoui_value = engfunc.pfnGetCvarFloat("hud_csgo");
            csgoui_value = imgui.SliderInt("仿CSGO UI", csgoui_value, 0, 1)
            if csgoui_value then
                engfunc.pfnCvarSetValue("hud_csgo", csgoui_value);
            end
			
			local hud_hitstyle = engfunc.pfnGetCvarFloat("hud_hitstyle");
            hud_hitstyle = imgui.SliderInt("伤害显示风格", hud_hitstyle, 1, 8)
            if hud_hitstyle then
                engfunc.pfnCvarSetValue("hud_hitstyle", hud_hitstyle);
            end
			local hud_centerid = engfunc.pfnGetCvarFloat("hud_centerid");
            hud_centerid = imgui.SliderInt("中间显示人名", hud_centerid, 0, 1)
            if hud_centerid then
                engfunc.pfnCvarSetValue("hud_centerid", hud_centerid);
            end
			
			local hud_sifiammostyle = engfunc.pfnGetCvarFloat("hud_sifiammostyle");
            hud_sifiammostyle = imgui.SliderInt("枪支显示弹药", hud_sifiammostyle, 0, 9)
            if hud_sifiammostyle then
                engfunc.pfnCvarSetValue("hud_sifiammostyle", hud_sifiammostyle);
            end

            local cl_crosshair_translucent = engfunc.pfnGetCvarFloat("cl_crosshair_translucent") > 0 and true or false;
            local checkBox
            cl_crosshair_translucent, checkBox = imgui.Checkbox("准星透明", cl_crosshair_translucent)
            if checkBox then
                engfunc.pfnCvarSetValue("cl_crosshair_translucent", cl_crosshair_translucent and 1 or 0);
            end
            imgui.SameLine(imgui.CalcItemWidth());
            imgui.TextUnformatted("cl_crosshair_translucent");
            
            imgui.EndTabItem();
        end

        if (imgui.BeginTabItem("键盘")) then
            if not imgui_mainui_keys_act then
                xpcall(UI_InitKeysList, function(...) print(debug.traceback(...)) end)
            end
            
            if imgui.Button("恢复默认键位") then
                xpcall(UI_ResetKeysList, function(...) print(debug.traceback(...)) end)
                xpcall(UI_InitKeysList, function(...) print(debug.traceback(...)) end)
            end
            
            if imgui_mainui_keys_act then
                local cached_blank = {}
                local has_tree_node = false
                local tree_node_open = false
                local tree_node_has_child = false
                for i, stActEntry in ipairs(imgui_mainui_keys_act) do
                    if stActEntry.m_szCmd == "blank" then
                        if tree_node_open and tree_node_has_child then
                            tree_node_open = false
                            tree_node_has_child = false
                            imgui.Columns(1)
                            imgui.TreePop()
                        end
                        table.insert(cached_blank, stActEntry.m_szDesc)
                    else
                        if next(cached_blank) then
                            local title = table.concat(cached_blank, "\n")
                            imgui.Columns(1)
                            tree_node_open = imgui.TreeNodeEx(title, {"Selected", "DefaultOpen", "Bullet"})
                            has_tree_node = true
                            cached_blank = {}
                            imgui.Columns(3, "keyColumns", false)
                            local x, y = imgui.GetWindowSize()
                            imgui.SetColumnWidth(0, x - 300 - 150)
                            imgui.SetColumnWidth(1, 150)
                            imgui.SetColumnWidth(2, 150)
                        end
                        tree_node_has_child = true

                        if not has_tree_node or tree_node_open then
                            if imgui.Selectable(stActEntry.m_szDesc, false, { "SpanAllColumns", "AllowDoubleClick" }) then
                                if imgui.IsMouseDoubleClicked(0) then
                                    window_key_binding = true
                                    window_key_binding_entry = stActEntry
                                end
                            end
                            imgui.NextColumn()

                            local stBindings
                            
                            stBindings = stActEntry.m_astBindings[1]
                            if stBindings then
                                if IsMouseKey(stBindings.m_iKeyNum) then
                                    imgui.TextColored(0, 0.5, 0.5, 1, stBindings.m_szKeyName)
                                else
                                    imgui.TextColored(0.5, 0.5, 0, 1, stBindings.m_szKeyName)
                                end
                            end
                            imgui.NextColumn()

                            stBindings = stActEntry.m_astBindings[2]
                            if stBindings then
                                if IsMouseKey(stBindings.m_iKeyNum) then
                                    imgui.TextColored(0, 0.5, 0.5, 1, stBindings.m_szKeyName)
                                else
                                    imgui.TextColored(0.5, 0.5, 0, 1, stBindings.m_szKeyName)
                                end
                            end
                            imgui.NextColumn()
                            imgui.Separator()
                        end
                    end
                end
                if tree_node_open and tree_node_has_child then
                    tree_node_open = false
                    tree_node_has_child = false
                    imgui.TreePop()
                end
                imgui.Columns(1)
            end

            imgui.EndTabItem();
        end

        if (imgui.BeginTabItem("鼠标")) then
            local sensitivity_value = engfunc.pfnGetCvarFloat("sensitivity");
            sensitivity_value = imgui.SliderFloat("鼠标灵敏度", sensitivity_value, 0.0, 20.0)
            if sensitivity_value then
                engfunc.pfnCvarSetValue("sensitivity", sensitivity_value);
            end
            -- TODO
            imgui.EndTabItem();
        end

        if (imgui.BeginTabItem("音频")) then
            local volume_value = engfunc.pfnGetCvarFloat("volume");
            volume_value = imgui.SliderFloat("声音效果音量", volume_value, 0.0, 1.0)
            if volume_value then
                engfunc.pfnCvarSetValue("volume", volume_value);
            end

            local MP3Volume_value = engfunc.pfnGetCvarFloat("MP3Volume");
            MP3Volume_value = imgui.SliderFloat("MP3音量", MP3Volume_value, 0.0, 1.0)
            if MP3Volume_value then
                engfunc.pfnCvarSetValue("MP3Volume", MP3Volume_value);
            end

            -- TODO
            imgui.EndTabItem();
        end

        if (imgui.BeginTabItem("画质")) then
            imgui.TextUnformatted("警告：建议修改画质设置后手动重启游戏避免BUG");   
            local gamma_value = engfunc.pfnGetCvarFloat("gamma");             
            gamma_value = imgui.SliderFloat("亮度（推荐设置在3.0以内，地图太暗建议拉大到10以上）", gamma_value, 1.8, 30.0)
            if gamma_value then
                engfunc.pfnCvarSetValue("gamma", gamma_value);
            end
            local brightness_value = engfunc.pfnGetCvarFloat("brightness");
            brightness_value = imgui.SliderFloat("灰度（需要重启游戏）", brightness_value, 0.0, 2.0)
            if brightness_value then
                engfunc.pfnCvarSetValue("brightness", brightness_value);
            end
			
			local hud_scale = engfunc.pfnGetCvarFloat("hud_scale");    
            hud_scale = math.floor((hud_scale - 1) * 4)
            hud_scale = imgui.Combo("HUD大小", hud_scale, " 100%\0 125%\0 150%\0 175%\0 200%\0 225%\0 250%\0 275%\0 300%\0 325%\0 350%\0 375%\0 400%\0")
            if hud_scale then
				hud_scale = 0.25 * hud_scale + 1.0
                engfunc.pfnCvarSetValue("hud_scale", hud_scale);
            end
			
			--local r_max_size = engfunc.pfnGetCvarFloat("r_max_size");  
            --local x, y = math.frexp(r_max_size)
            --y = imgui.Combo("贴图尺寸", math.floor(y - 6), " 64\0 128\0 256\0 512\0 1024\0 2048\0 4096\0 8192\0 16384\0")
            --if y then
			--	r_max_size = math.ldexp(1, y + 6)
            --    engfunc.pfnCvarSetValue("r_max_size", r_max_size);
            --end
			
            -- TODO
            imgui.EndTabItem();
        end
		
        if (imgui.BeginTabItem("性能")) then
			imgui.TextUnformatted("如果频繁闪退，请调小下面的数值");
			local r_texlru = engfunc.pfnGetCvarFloat("r_texlru");    
			if r_texlru == 0 or r_texlru > 1024 or r_texlru < 64 then
				r_texlru = 6
			else
				r_texlru = math.ceil(math.log(r_texlru, 2)) - 5
			end
            r_texlru = imgui.Combo("模型贴图渲染数", r_texlru, " 64\0 128\0 256\0 512\0 1024\0 无限制\0")
            if r_texlru then
				if r_texlru == 6 then
					r_texlru = 0
				else
					r_texlru = math.ceil(math.pow(2, r_texlru + 5))
				end
                engfunc.pfnCvarSetValue("r_texlru", r_texlru);
            end
            imgui.EndTabItem();
		end

        imgui.EndTabBar();
    end
    imgui.End()

    if window_key_binding then
        imgui.OpenPopup("柑橘 CSMoE 按键绑定")
        imgui_utils.CenterNextWindow(ImGuiCond.Always)
        if imgui.BeginPopupModal("柑橘 CSMoE 按键绑定", window_key_binding, {"AlwaysAutoResize"}) then
            imgui.CaptureKeyboardFromApp()

            for keynum = 0, 256 do
                if not IsMouseKey(keynum) then
                    if imgui.IsKeyPressed(keynum) then
                        current_key = keynum
                    end
                end
            end

            imgui.TextUnformatted("正在绑定 ")
            imgui.SameLine()
            imgui.TextColored(1, 0, 0, 1, window_key_binding_entry.m_szDesc)
            imgui.SameLine()
            imgui.TextUnformatted(" 的按键")

            if current_key then
                imgui.TextUnformatted("你选择的是：")
                imgui.SameLine()
                imgui.SameLine()
                if IsMouseKey(current_key) then
                    imgui.TextColored(0, 0.5, 0.5, 1, engfunc.pfnKeynumToString(current_key))
                else
                    imgui.TextColored(0.5, 0.5, 0, 1, engfunc.pfnKeynumToString(current_key))
                end
                imgui.SameLine()
                imgui.TextUnformatted("键")
            else
                imgui.TextUnformatted("你还未选择按键")
            end

            imgui.Separator()
            
            imgui.TextUnformatted("绑定键盘请直接按键，取消请按ESC键")

            imgui.Button("绑定鼠标请点我")
            if imgui.IsItemHovered() then
                for mousenum = 0, 4 do
                    if imgui.IsMouseDown(mousenum) then
                        current_key = K_MOUSE1 + mousenum
                    end
                end

                for keynum = K_MWHEELDOWN, K_MWHEELUP do
                    if imgui.IsKeyDown(keynum) then
                        current_key = keynum
                    end
                end
            end

            local w, h = imgui.GetWindowSize()
            imgui.Separator()

            imgui.SameLine(w * 1 / 4 - 30)
            if imgui.Button("确认") then
                if current_key then
                    local cmd = window_key_binding_entry.m_szCmd
                    local def = engfunc.pfnKeynumToString(current_key)
                    engfunc.pfnClientCmd( 1, string.format("bind \"%s\" \"%s\"\n", def, cmd) )

                    UI_InitKeysList()
                    window_key_binding = false
                    window_key_binding_entry = nil
                    imgui.CloseCurrentPopup()
                end
            end

            imgui.SameLine()

            imgui.SameLine(w / 2 + 30)
            if not window_key_binding or current_key == K_ESCAPE or imgui.Button("取消") then
                window_key_binding = false
                window_key_binding_entry = nil
                imgui.CloseCurrentPopup()
            end

            imgui.EndPopup()
        else
            window_key_binding = false
            window_key_binding_entry = nil
            imgui.CloseCurrentPopup()
        end
    end
end
-- window_option = 1
-- TEST_IMGUI["UI_Options"] = UI_Options