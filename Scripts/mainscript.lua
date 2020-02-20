local tableofmembers = {}
local tablenewmembers = {}
local leavemembers = {}
local renamemembers = {}
local GuildInfo = {}

function SetPos(wt,posX,sizeX,posY,sizeY,highPosX,highPosY,alignX, alignY)
  if wt then
    local p = wt:GetPlacementPlain()
    if posX then p.posX = posX end
    if sizeX then p.sizeX = sizeX end
    if posY then p.posY = posY end
    if sizeY then p.sizeY = sizeY end
    if highPosX then p.highPosX = highPosX end
    if highPosY then p.highPosY = highPosY end
	if alignX then p.alignX = alignX end
	if alignY then p.alignY = alignY end
    wt:SetPlacementPlain(p) 
  end
end

--WHOISLIVE

local wtViewPanel = mainForm:GetChildChecked( "ViewPanel", false )
local wtContainer = wtViewPanel:GetChildChecked( "Container", false )
local wtTextcontainer = wtViewPanel:GetChildChecked( "Text", false )
local wtButtonClose = wtViewPanel:GetChildChecked( "Close", false )
wtButtonClose:SetVal("button_label", userMods.ToWString(GTL('Button')) )
local wtHeaderLeave = wtViewPanel:GetChildChecked( "HeaderText", false )
wtHeaderLeave:SetClassVal("class", "tip_yellow" )
SetPos(wtHeaderLeave,0,250,nil,nil,nil,nil,WIDGET_ALIGN_CENTER)
wtViewPanel:SetBackgroundColor( {  r = 1; g = 0.17; b = 0.5; a = 1.0 } )
local wtCheckLive = wtViewPanel:GetChildChecked( "CheckBox", false )
wtCheckLive:Show(true)
SetPos(wtCheckLive,nil,32,nil,32,50,15,WIDGET_ALIGN_HIGH , WIDGET_ALIGN_HIGH )
SetPos(wtViewPanel,nil,400)
SetPos(wtContainer,nil,380)

--WHOISNEW

local wtNewbiePanel = mainForm:GetChildChecked( "NewPanel", false )
local wtContainerNew = wtNewbiePanel:GetChildChecked( "Container", false )
local wtNewHeader = wtNewbiePanel:GetChildChecked( "HeaderText", false )
SetPos(wtNewHeader,0,250,nil,nil,nil,nil,WIDGET_ALIGN_CENTER)
wtNewHeader:SetClassVal("class", "tip_yellow" )
local wtTextcontainerNew = wtNewbiePanel:GetChildChecked( "Text", false )
local wtNewButton = wtNewbiePanel:GetChildChecked( "ButtonTime", false )
wtNewButton:SetVal("button_label", userMods.ToWString(GTL('Button')) )
wtNewbiePanel:SetBackgroundColor( {  r = 0.17; g = 1; b = 0.5; a = 1.0 } )
local wtCheckNew = wtNewbiePanel:GetChildChecked( "CheckBox", false )
wtCheckNew:Show(true)
SetPos(wtCheckNew,nil,32,nil,32,50,15,WIDGET_ALIGN_HIGH , WIDGET_ALIGN_HIGH )

--WHATISYGUILD

local wtGuildQuestion = mainForm:GetChildChecked( "QuestionPanel", false )
local wtGuildQuestionText = wtGuildQuestion:GetChildChecked( "Text", false )
local wtGuildQuestionButton = wtGuildQuestion:GetChildChecked( "ButtonYes", false )
wtGuildQuestionButton:SetVal("button_label", userMods.ToWString(GTL('ButtonYes')) )
SetPos(wtGuildQuestionText,0,200,60,30)
local wtGuildQuestionName = mainForm:CreateWidgetByDesc(wtGuildQuestionText:GetWidgetDesc())
wtGuildQuestion:AddChild(wtGuildQuestionName)
SetPos(wtGuildQuestionName,0,200,30,30)
wtGuildQuestion:Show(false)

function IsGuildMember( name )
	if not guild.IsExist() then return false end
	if guild.GetMember(name) then return true end
	return false
end

function CheckGuiName()
wtGuildQuestionName:SetVal("name", guild.GetName())
wtGuildQuestionText:SetVal("name", GTL('Gui'))
wtGuildQuestionName:SetClassVal("class", "tip_green" )
wtGuildQuestion:Show(true)
end

function AcceptButton(params)
if params.sender=="ButtonYes" then
	wtGuildQuestion:Show(false)
	GuildInfo.GuildName = userMods.FromWString(guild.GetName())
	userMods.SetGlobalConfigSection("GuildInfo", GuildInfo)
	end
end

function ReloadGuildList()
local tablegmembers = nil tablegmembers = {}
local GuildMembers = guild.GetMembers()
	for i = 0, GetTableSize( GuildMembers ) - 1 do
			tablegmembers[i] = {}
	end
	for i = 0, GetTableSize( GuildMembers ) - 1 do
		if guild.GetMemberInfo then 
		GuildMembers[i] = guild.GetMemberInfo( GuildMembers[i] )
		tablegmembers[i].NAME = GuildMembers[i].name
		tablegmembers[i].JDATE = userMods.FromWString(common.FormatInt(GuildMembers[i].joinTime.y, "%02d")).."."..userMods.FromWString(common.FormatInt(GuildMembers[i].joinTime.m, "%02d")).."."..userMods.FromWString(common.FormatInt(GuildMembers[i].joinTime.d, "%02d"))
		GuildInfo.GuiMembers = tablegmembers
		GuildInfo.NumMembers = #tablegmembers
		userMods.SetGlobalConfigSection ("GuildInfo", GuildInfo)
		end
	end
end

local shardtable = {
["Наследие Богов"] = "nasledie-bogov",
["Нить судьбы"] = "nit-sudby",
["Вечный Зов"] = "vechnyy-zov",
["Молодая Гвардия"] = "molodaya-gvardiya",
}


local ReplaceTable = {
["а"] = "a",
["б"] = "b",
["в"] = "v",
["г"] = "g",
["д"] = "d",
["е"] = "e",
["ё"] = "yo",
["ж"] = "zh",
["з"] = "z",
["и"] = "i",
["й"] = "j",
["к"] = "k",
["л"] = "l",
["м"] = "m",
["н"] = "n",
["о"] = "o",
["п"] = "p",
["р"] = "r",
["с"] = "s",
["т"] = "t",
["у"] = "u",
["ф"] = "f",
["х"] = "x",
["ц"] = "ce",
["ч"] = "ch",
["щ"] = "sh",
["щ"] = "sc",
["ь"] = "-",
["ы"] = "yi",
["ъ"] = "_",
["э"] = "eh",
["ю"] = "yu",
["я"] = "ya",

["А"] = "a",
["Б"] = "b",
["В"] = "v",
["Г"] = "g",
["Д"] = "d",
["Е"] = "e",
["Ё"] = "yo",
["Ж"] = "zh",
["З"] = "z",
["И"] = "i",
["Й"] = "j",
["К"] = "k",
["Л"] = "l",
["М"] = "m",
["Н"] = "n",
["О"] = "o",
["П"] = "p",
["Р"] = "r",
["С"] = "s",
["Т"] = "t",
["У"] = "u",
["Ф"] = "f",
["Х"] = "x",
["Ц"] = "ce",
["Ч"] = "ch",
["Ш"] = "sh",
["Щ"] = "sc",
["Ь"] = "-",
["Ы"] = "yi",
["Ъ"] = "_",
["Э"] = "eh",
["Ю"] = "yu",
["Я"] = "ya",
}

function ConverseName(s)
local m = s:gsub("%W", function(m) if ReplaceTable[m] == nil then return m else return ReplaceTable[m] end end )
return m
end

function armoryLink(name, typelink)
LogInfo(typelink, "http://armory.allodswiki.ru/avatar/", shardtable[userMods.FromWString(unit.GetPlayerShardName(avatar.GetId()))], "/", ConverseName(name))
end

function CheckGuiMembers()
clearW()
leavemembers = nil leavemembers = {}
renamemembers = nil renamemembers = {}
local tablegmembers = {}
local GuildMembers = guild.GetMembers()
	for i = 0, GetTableSize( GuildMembers ) - 1 do
			tablegmembers[i] = {}
	
	if guild.GetMemberInfo then 
		GuildMembers[i] = guild.GetMemberInfo( GuildMembers[i] )
		tablegmembers[i].NAME = GuildMembers[i].name
		tablegmembers[i].JDATE = userMods.FromWString(common.FormatInt(GuildMembers[i].joinTime.y, "%02d")).."."..userMods.FromWString(common.FormatInt(GuildMembers[i].joinTime.m, "%02d")).."."..userMods.FromWString(common.FormatInt(GuildMembers[i].joinTime.d, "%02d"))
		end
	end
tableofmembers = nil tableofmembers = {}
if GuildInfo.GuiMembers then
for i = 0, #GuildInfo.GuiMembers do
if not IsGuildMember(GuildInfo.GuiMembers[i].NAME) then
	local wtUserLeave = mainForm:CreateWidgetByDesc(wtTextcontainer:GetWidgetDesc())
	table.insert(tableofmembers, wtUserLeave)
	wtUserLeave:SetClassVal("class", "tip_white" )
	wtHeaderLeave:SetVal("name", GTL('GMHeader')..tostring(#tableofmembers))
	SetPos(wtUserLeave,0,170,0,30)
		wtUserLeave:SetVal("name", userMods.FromWString(GuildInfo.GuiMembers[i].NAME))
		table.insert(leavemembers, userMods.FromWString(GuildInfo.GuiMembers[i].NAME))
		for l = 0, #tablegmembers do
			if tablegmembers[l].JDATE == GuildInfo.GuiMembers[i].JDATE then
			wtUserLeave:SetVal("name", userMods.FromWString(GuildInfo.GuiMembers[i].NAME).." --> "..userMods.FromWString(tablegmembers[l].NAME))
			table.insert(renamemembers, userMods.FromWString(tablegmembers[l].NAME))
			for k, v in pairs(leavemembers) do
				if v == userMods.FromWString(GuildInfo.GuiMembers[l].NAME) then
				table.remove(leavemembers, k)
					end
				end
			end
		end
	wtContainer:PushFront( wtUserLeave )
			end 
		end 
	end
end

function clearW()
	for k = #tableofmembers, 1, -1 do
			tableofmembers[k]:DestroyWidget()
			table.remove(tableofmembers, k)
		end
end

function UpdateGui()
--CheckGuiMembers()
if #tableofmembers <= 0 then wtViewPanel:Show(false) else wtViewPanel:Show(true) 
CheckGuiMembers()
	end
end

function Close()
if DnD:IsDragging() then
		return
	end
	if wtViewPanel:IsVisible() then	
		wtViewPanel:Show(false)
		LinkLeave()
		clearW()
		ReloadGuildList()
	end  
end

function LinkLeave()
if wtCheckLive:GetVariant() == 1 then 
	for k, v in pairs(leavemembers) do
	armoryLink(v, GTL('Leave'))
		end
	for k, v in pairs(renamemembers) do
	armoryLink(v, GTL('Rename'))
		end
	end
end

function SetTimeStamp()
GuildInfo.TimeStamp = common.GetMsFromDateTime(common.GetLocalDateTime())
userMods.SetGlobalConfigSection ("GuildInfo", GuildInfo)
end

function CheckNewMembers()
clearNewW()
tablenewmembers = nil tablenewmembers = {}
local GuildMembers = guild.GetMembers()
	for _, Member in pairs(GuildMembers) do
		if guild.GetMemberInfo then 
			Member = guild.GetMemberInfo( Member )
			if common.GetMsFromDateTime(Member.joinTime) >= GuildInfo.TimeStamp then 
local wtNewUser = mainForm:CreateWidgetByDesc( wtTextcontainerNew:GetWidgetDesc() )
table.insert(tablenewmembers, wtNewUser)
wtNewUser:SetVal("name", userMods.FromWString(Member.name).."  "..tostring(Member.joinTime.d).."."..tostring(Member.joinTime.m).."."..tostring(Member.joinTime.y))
wtNewUser:SetClassVal("class", "tip_white" )
SetPos(wtNewUser,0,170,0,30)
wtContainerNew:PushFront( wtNewUser )
wtNewHeader:SetVal("name", GTL('GNHeader')..tostring(#tablenewmembers))
			end
		end
	end
end

function clearNewW()
	for k = #tablenewmembers, 1, -1 do
			tablenewmembers[k]:DestroyWidget()
			table.remove(tablenewmembers, k)
	end
end

function UpdateNew()
if #tablenewmembers <= 0 then wtNewbiePanel:Show(false) else wtNewbiePanel:Show(true)
CheckNewMembers() 
	end
end

function LinkNew()
if wtCheckNew:GetVariant() == 1 then 
	for _, v in pairs(tablenewmembers) do
		local d = common.ExtractWStringFromValuedText(v.NAME:GetValuedText())
		armoryLink(userMods.FromWString(d.NAME), GTL('GNHeader'))
		end 
	end
end

function CloseTime()
if DnD:IsDragging() then
		return
	end
	if wtNewbiePanel:IsVisible() then	
		wtNewbiePanel:Show(false)
		SetTimeStamp()
		LinkNew()
	end  
end

function LoadTime()
if userMods.GetGlobalConfigSection ("GuildInfo") then
GuildInfo = userMods.GetGlobalConfigSection ("GuildInfo")
end
if not GuildInfo.TimeStamp then SetTimeStamp() end
if not GuildInfo.GuiMembers then ReloadGuildList() end
if not GuildInfo.NumMembers and guild.IsExist() then GuildInfo.NumMembers = GetTableSize(guild.GetMembers()) end
if not GuildInfo.GuildName and guild.IsExist() then CheckGuiName() end
end 

function CloseLeave()
wtViewPanel:Show(false)
end

function CloseNew()
wtNewbiePanel:Show(false)
end

function CloseQuestion()
wtGuildQuestion:Show(false)
end

function ReactionCBox(pars)
if pars.sender == pars.widget:GetName() then
	if pars.widget:GetVariant()==0 then 
	pars.widget:SetVariant(1)
	else
	pars.widget:SetVariant(0)
		end 
	end 
end

function Init()
	wtNewbiePanel:Show(false)
	wtViewPanel:Show(false)
	LoadTime()
	if guild.IsExist() then 
		if userMods.FromWString(guild.GetName()) == GuildInfo.GuildName then 
		CheckGuiMembers() CheckNewMembers() wtViewPanel:Show(true) wtNewbiePanel:Show(true) 
		else 
		wtViewPanel:Show(false) wtNewbiePanel:Show(false)
		end 
	end
	if #tableofmembers <= 0 then wtViewPanel:Show(false) else wtViewPanel:Show(true) end
	if #tablenewmembers <= 0 then wtNewbiePanel:Show(false) else wtNewbiePanel:Show(true) end
	common.RegisterReactionHandler( Close, "Close" )
	common.RegisterReactionHandler( CloseTime, "ButtonTime" )
	common.RegisterReactionHandler( AcceptButton, "ButtonTime" )
	common.RegisterReactionHandler( CloseLeave, "CornerCrossLeave" )
	common.RegisterReactionHandler( CloseQuestion, "CornerCrossNew" )
	common.RegisterReactionHandler( CloseNew, "CornerCrossNew" )
	common.RegisterReactionHandler( ReactionCBox, "checkbox" )
	common.RegisterEventHandler( UpdateGui, "EVENT_GUILD_MEMBER_ONLINE_STATUS_CHANGED" )
	common.RegisterEventHandler( UpdateNew, "EVENT_GUILD_MEMBER_ONLINE_STATUS_CHANGED" )
	common.RegisterEventHandler( UpdateGui, "EVENT_GUILD_LIST_CHANGED" )
	common.RegisterEventHandler( UpdateNew, "EVENT_GUILD_LIST_CHANGED" )
	DnD.Init(wtViewPanel,wtViewPanel,true)
	DnD.Init(wtNewbiePanel,wtNewbiePanel,true)
end 

if (avatar.IsExist()) then Init()
else common.RegisterEventHandler(Init, "EVENT_AVATAR_CREATED")	
end