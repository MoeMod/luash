local texture = require("imgui/texture")
local texureList = {}
local player_class_TE = {
	-- 介绍图片, 按钮, 介绍
	{"yuri", "安娜","冠名：白白,QQ群：706711420"},
	{"pirateboy", "渡鸦", "冠名：橘子,QQ群：706711420"},
	{"marineboy", "恩佐", "冠名：維吉爾,QQ群：706711420"},
	{"pirategirl", "米娜","冠名：樓哥,QQ群：706711420"},
	{"rb", "红帽子","冠名：馬桶GIEGIE,QQ群：706711420"},
	{"jpngirl01", "熏","冠名：掉下來的鴿子,QQ群：706711420"},
	{"ritsuka", "伊琳娜", "冠名：南桐姥爷,QQ群：706711420"}
}

local player_class_CT = {
	-- 介绍图片, 按钮, 介绍
	{"saf", "丛林猛虎", "冠名：慕名病嬌：706711420"},
	{"choijiyoon", "崔志云", "冠名：泡泡茶壶,QQ群：706711420"},
	{"fernando", "费尔南多", "冠名：华强哥：QQ群：706711420"},
	{"707", "707", "冠名：生化哥，直播间DI:PLAHF666,QQ群：706711420"},
	{"sozo", "雷霆小组", "冠名：空位,QQ群：706711420"},
	{"magui", "炎龙战术小队", "冠名：空位,QQ群：706711420"},
	{"natasha", "娜塔莎", "冠名：空位,QQ群：706711420"}
}

local lastSelected
local lastDesc = ""
local curPage = 1
local PAGE_PER_COUNT = 7 -- 每一页的个数
local MAX_NUMBER_KEY = ImGuiKey.KEY_0 + PAGE_PER_COUNT
local selectedTeam

local selectedCallBack = function (index, team)
	engine.pfnClientCmd("jointeam "..team)
	engine.pfnClientCmd("joinclass "..index)
	imgui.CaptureMouseFromApp(false)
	engine.pfnSetMouseEnable(true)
	imgui_jointeam_open = false
end

local function updateDesc(tex, desc)
	-- 右侧图片和说明
	local w, h = imgui.GetWindowSize()
	imgui.SameLine(imgui_utils.GetScaledValue(w/2))
	imgui.BeginGroup()
	if lastSelected then 
		imgui.Dummy(0, imgui_utils.GetScaledValue(h/2 - tex.height/1.5 - h/5))
		imgui.Image(tex.id, imgui_utils.GetScaledValue(tex.width), imgui_utils.GetScaledValue(tex.height))
	end
	imgui.TextWrapped(desc)
	imgui.EndGroup()
end

local function addNumberButton(number, name, clickCB, hoverCB)
	imgui.BeginGroup()
	imgui.Button(number, imgui_utils.GetScaledValue(40), imgui_utils.GetScaledValue(30))
	imgui.SameLine()
	imgui.Button(name, imgui_utils.GetScaledValue(180), imgui_utils.GetScaledValue(30))
	imgui.EndGroup()
	if hoverCB then
		if imgui.IsItemHovered() then
			hoverCB()
		end
	end
	if clickCB then
		if imgui.IsItemClicked() then
			clickCB()
		end
	end
end

local function addAppearanceList(team)
	local list = team == 1 and player_class_TE or player_class_CT
	local maxPages = math.floor(#list / PAGE_PER_COUNT)
	if maxPages <= 0 then
		return 0
	end

	-- 左侧按钮列表
	imgui.BeginGroup()
		local start = (curPage-1) * PAGE_PER_COUNT+1
		local length = math.min(start + PAGE_PER_COUNT-1, #list)
		for i=start,length do
			local v = list[i]
			addNumberButton(i - start + 1, v[2], function()
				selectedCallBack(i, team)
			end, function()
				if not texureList[v[1]] then
					texureList[v[1]] = texture.new("gfx/vgui/"..v[1], _, true)
				end

				if texureList[v[1]] then
					lastSelected = v[1]
					lastDesc = v[3]
				end
			end)
		end

		imgui.Dummy(0, imgui_utils.GetScaledValue(70))
		addNumberButton("0", "自动选择", function ()
			selectedCallBack(0, team)
		end, function()
			local auto_select = team == 1 and "t_random" or "ct_random"
			if not texureList[auto_select] then
				texureList[auto_select] = texture.new("gfx/vgui/"..auto_select, _, true)
			end

			if texureList[auto_select] then
				lastSelected = auto_select
				lastDesc = "随机选择角色的外观"
			end
		end)

		if maxPages > 1 then
			imgui.NewLine()
			imgui.BeginGroup()
				if curPage > 1 then
					if imgui.Button("<-上一页(-)", imgui_utils.GetScaledValue(100), imgui_utils.GetScaledValue(30)) then
						curPage = math.max(1, curPage-1)
					end
				else
					imgui.Dummy(imgui_utils.GetScaledValue(120), imgui_utils.GetScaledValue(30))
				end
				
				if(curPage < maxPages) then
					imgui.SameLine()
					imgui.Indent(imgui_utils.GetScaledValue(120))
					if imgui.Button("下一页(+)->", imgui_utils.GetScaledValue(100), imgui_utils.GetScaledValue(30)) then
						curPage = math.min(maxPages, curPage+1)
					end
				end
			imgui.EndGroup()
		end
	imgui.EndGroup()

	updateDesc(texureList[lastSelected], lastDesc)
	return maxPages
end

function CL_JoinTeam()
	if not imgui_jointeam_open then
		return
	end

	imgui_utils.CenterNextWindow(ImGuiCond.Appearing)
    imgui.SetNextWindowSize(imgui_utils.GetScaledValue(750), imgui_utils.GetScaledValue(480), { "Appearing" })

	imgui_jointeam_open = imgui.Begin("选择人物", imgui_jointeam_open, 2 + 4 + 8 + 16 + 32)
	engine.pfnSetMouseEnable(false)
	imgui.CaptureMouseFromApp(true)
	local maxPages = 0
	if imgui.BeginTabBar("ChooseTeam.TabBar") then
		imgui.Indent(imgui_utils.GetScaledValue(50))
		if imgui.BeginTabItem("恐怖分子") then
			if selectedTeam ~= 1 then
				selectedTeam = 1
				curPage = 1
			end
			maxPages = addAppearanceList(1)
            imgui.EndTabItem()
		end
		if imgui.BeginTabItem("反恐精英") then
			if selectedTeam ~= 2 then
				selectedTeam = 2
				curPage = 1
			end
			maxPages = addAppearanceList(2)
            imgui.EndTabItem()
		end
		if imgui.BeginTabItem("观察者") then
			if imgui.Button("确认选择") then
				engine.pfnClientCmd("jointeam 6")
				imgui.CaptureMouseFromApp(false)
				engine.pfnSetMouseEnable(true)
				imgui_jointeam_open = false
			end
            imgui.EndTabItem()
		end
		imgui.EndTabBar()
	end

	-- 监听按键
	if imgui.IsKeyPressed(45) then -- '-'
		curPage = math.max(1, curPage-1)
	elseif imgui.IsKeyPressed(61) then -- '='
		curPage = math.min(maxPages, curPage+1)
	end
	
	for i = ImGuiKey.KEY_0, MAX_NUMBER_KEY do
		if imgui.IsKeyPressed(i) then
			if i == ImGuiKey.KEY_0  then
				selectedCallBack(0, selectedTeam)
			else
				selectedCallBack((curPage-1) * PAGE_PER_COUNT + i - ImGuiKey.KEY_0, selectedTeam)
			end
			break
		end
	end

	imgui.End()
end