require("imgui/imgui_enum")

function UI_NewGame()
    if imgui_newgame_open then
        if not imgui_newgame_maps_list then
            engfunc.pfnCreateMapsList(1)
            local afile = engfunc.COM_LoadFile("maps.lst", nil)
            if afile then
                imgui_newgame_maps_list = {}
                local pfile = afile
                local token = cpp.new("char", 1024)
                
                pfile = engfunc.COM_ParseFile( pfile, token )
                local is_map = true
                while pfile  do
                    if is_map then
                        table.insert(imgui_newgame_maps_list, tostring(token))
                    end
                    is_map = not is_map
                    pfile = engfunc.COM_ParseFile( pfile, token )
                end
                
                cpp.delete(token, 1024)
                engfunc.COM_FreeFile(afile)
            end
        end

        imgui_utils.CenterNextWindow(ImGuiCond.Appearing)
        imgui_newgame_open = imgui.Begin("新建游戏", imgui_newgame_open)
        
        local mp_gamemode = engfunc.pfnGetCvarString("mp_gamemode")
        local modes_name_list = {
            "竞技模式", "死亡竞赛模式", "生化1(感染)", "生化3(三禁)", "生化4(暗夜)", "大灾变"
        }
        local modes_list = {
            "none", "tdm", "zb1", "zb3f2p", "z4", "zbs"
        }
        local imgui_newgame_combo_item_mode = 0
        for i, v in ipairs(modes_list) do
            if v == mp_gamemode then
                imgui_newgame_combo_item_mode = i
            end
        end
        imgui_newgame_combo_item_mode = imgui.Combo("选择模式", imgui_newgame_combo_item_mode, modes_name_list, #modes_name_list)
        if imgui_newgame_combo_item_mode then
            engfunc.pfnCvarSetString("mp_gamemode", modes_list[imgui_newgame_combo_item_mode])
        end
        
        imgui_newgame_combo_item_map = imgui_newgame_combo_item_map or 1
        local maps_list = imgui_newgame_maps_list or { "de_dust", "de_dust2", "cs_assault" }
        imgui_newgame_combo_item_map = imgui.Combo("选择地图", imgui_newgame_combo_item_map, maps_list, #maps_list) or imgui_newgame_combo_item_map
        
        local maxplayers = engfunc.pfnGetCvarFloat("maxplayers")
        maxplayers = imgui.DragInt("最大人数", maxplayers, 0.1, 1, 32, "%.0f人")
        if maxplayers then
            engfunc.pfnCvarSetValue("maxplayers", maxplayers)
        end

        local bot_quota = engfunc.pfnGetCvarFloat("bot_quota")
        bot_quota = imgui.DragInt("BOT数量", bot_quota, 0.1, 0, 32, "%.0f只")
        if bot_quota then
            engfunc.pfnCvarSetValue("bot_quota", bot_quota)
        end

        local bot_difficulty = engfunc.pfnGetCvarString("bot_difficulty")
        local bot_difficulty_name_list = {
            "简单", "中等", "困难", "精英"
        }
        local imgui_newgame_combo_item_bot_difficulty = bot_difficulty + 1
        imgui_newgame_combo_item_bot_difficulty = imgui.Combo("BOT难度", imgui_newgame_combo_item_bot_difficulty, bot_difficulty_name_list, #bot_difficulty_name_list)
        if imgui_newgame_combo_item_bot_difficulty then
            engfunc.pfnCvarSetString("bot_difficulty", imgui_newgame_combo_item_bot_difficulty - 1)
        end

        if imgui.Button("开始游戏") then
            local mapname = maps_list[imgui_newgame_combo_item_map]
            -- 调用开始游戏
            engfunc.pfnCvarSetValue("deathmatch", 1)
            engfunc.pfnCvarSetValue("defaultmap", mapname)
            engfunc.pfnCvarSetValue("sv_nat", 1)
            engfunc.pfnWriteServerConfig( engfunc.pfnGetCvarString( "lservercfgfile" ) )
            engfunc.pfnClientCmd( true, "exec %s\n", engfunc.pfnGetCvarString( "lservercfgfile" ))
            engfunc.pfnClientCmd( false, string.format("endgame;menu_connectionprogress localserver;wait;wait;wait;latch;map %s\n", mapname) )
            -- 关闭该窗口
            imgui_newgame_open = false
        end

        imgui.End()
    end
end