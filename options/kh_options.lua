local KHOptions
local category, layout

StaticPopupDialogs["KH_UI_Set_Default"] = {
	text = "Are you sure you wish to set the default values? (Will reload)",
	button1 = "Yes",
	button2 = "No",
	OnAccept = function()
		KH_UI_Settings = KH_UI_Settings_Defaults
		C_UI.Reload()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
  }

local uniquealyzer = 1
local uniqueTextBox = 1
function KH_UI:createCheckbutton(parent, x_loc, y_loc, displayname)
	uniquealyzer = uniquealyzer + 1

	local checkbutton =
		CreateFrame("CheckButton", "KH_UI_CHECK_0" .. uniquealyzer, parent, "ChatConfigCheckButtonTemplate")
	checkbutton:SetPoint("TOPLEFT", x_loc, y_loc)
	getglobal(checkbutton:GetName() .. "Text"):SetText(displayname)

	return checkbutton
end

function KH_UI:Enable_BlizzardTarget()
	if not TargetFrame:IsEventRegistered("UNIT_HEALTH") then
		--Combo Frame
		ComboFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
		ComboFrame:RegisterUnitEvent("UNIT_POWER_FREQUENT", "player");
		ComboFrame:RegisterUnitEvent("UNIT_MAXPOWER", "player");
		ComboFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
		--Target Frame
		TargetFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		TargetFrame:RegisterEvent("UNIT_HEALTH")
		if (TargetFrame.showLevel) then
			TargetFrame:RegisterEvent("UNIT_LEVEL")
		end
		TargetFrame:RegisterEvent("UNIT_FACTION")
		if (TargetFrame.showClassification) then
			TargetFrame:RegisterEvent("UNIT_CLASSIFICATION_CHANGED")
		end
		if (TargetFrame.showLeader) then
			TargetFrame:RegisterEvent("PLAYER_FLAGS_CHANGED")
		end
		TargetFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
		TargetFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
		TargetFrame:RegisterEvent("RAID_TARGET_UPDATE")
		TargetFrame:RegisterUnitEvent("UNIT_AURA", "target")
	end
end

function KH_UI:Disable_BlizzardTarget()
	if (TargetFrame:IsEventRegistered("UNIT_HEALTH")) then
		TargetFrame:UnregisterAllEvents()
		TargetFrame:Hide()
		ComboFrame:UnregisterAllEvents()
		ComboFrame:Hide()
	end
end

function KH_UI:Set_KHFrames()
	--Player Frame--
	if (KH_UI_Settings["Player Frame"].enabled == false) then
		if (KH_UI.playerFrame:IsVisible()) then
			KH_UI.playerFrame:Hide()
		end
	elseif (KH_UI.playerFrame:IsVisible() == false) then
		KH_UI.playerFrame:Show()
	end
	--Party Frame--
	for i = 1, 4, 1 do
		if (KH_UI_Settings["Party Frame"].enabled == false) then
			if (KH_UI.partyFrame[i]:IsVisible()) then
				KH_UI.partyFrame[i]:Hide()
			end
		elseif (KH_UI.partyFrame[i]:IsVisible() == false) then
			KH_UI.partyFrame[i]:Show()
		end
	end
	--Target Frame--
	if (KH_UI_Settings["Target Frame"].enabled == false) then
		KH_UI:Enable_BlizzardTarget()
		if (KH_UI.targetFrame:IsVisible()) then
			KH_UI.targetFrame:Hide()
		end
		UnregisterStateDriver(KH_UI.targetFrame, "visibility")
		UnregisterStateDriver(KH_UI.targettargetFrame, "visibility")
		if (KH_UI.targettargetFrame:IsVisible()) then
			KH_UI.targettargetFrame:Hide()
		end
	else
		RegisterStateDriver(KH_UI.targetFrame, "visibility", "[@target,exists] show; hide")
		RegisterStateDriver(KH_UI.targettargetFrame, "visibility", "[@targettarget,exists] show; hide")
		if (KH_UI_Settings["Player Frame"].blizzardEnabled) then
			KH_UI:Disable_BlizzardTarget()
		end
		if (KH_UI.targetFrame:IsVisible() == false) then
			KH_UI.targetFrame:Show()
		end
		if (KH_UI.targettargetFrame:IsVisible() == false) then
			KH_UI.targettargetFrame:Show()
		end
	end
end

function KH_UI:Set_BlizzardFrames()
	if (not InCombatLockdown()) then
		--KH_UI.targetFrame = KH_UI:New_TargetFrame()
		--KH_UI.targettargetFrame = KH_UI:New_TargetofTargetFrame()
		if (KH_UI_Settings["Player Frame"].blizzardEnabled or KH_UI_Settings["Player Frame"].enabled == false) then
			PlayerFrame:Show()
		elseif (PlayerFrame:IsVisible()) then
			PlayerFrame:Hide()
		end
		if (KH_UI_Settings["Party Frame"].blizzardEnabled or KH_UI_Settings["Party Frame"].enabled == false) then
			ShowPartyFrame()
		else
			HidePartyFrame()
		end
		--Target Frame--
		if
			(KH_UI_Settings["Target Frame"].blizzardEnabled or
				KH_UI_Settings["Target Frame"].enabled == false)
		 then
			KH_UI:Enable_BlizzardTarget()
		else
			KH_UI:Disable_BlizzardTarget()
		end
	end
end

function KH_UI:Create_InputBox(text, parent, point, ofsx, ofsy, width, method)
	uniqueTextBox = uniqueTextBox + 1
	local f = CreateFrame("EditBox", "KH_UI_INPUT_0" .. uniqueTextBox, parent, "InputBoxTemplate")
	f:SetAutoFocus(false)
	f:SetMaxBytes(9)
	f:SetSize(width, 12)
	f:SetNumeric(true)
	f:SetText(text)
	f:SetCursorPosition(0)
	f:SetPoint(point, ofsx, ofsy)
	f.method = function(self)
		f:ClearFocus()
		f.button:Hide()
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		method(f)
	end

	f:SetScript(
		"OnEnterPressed",
		function()
			f:method()
		end
	)

	f:SetScript(
		"OnTextChanged",
		function()
			if f.init == nil then
				f.init = 1
			elseif f.init == 1 then
				f.init = 2
			elseif f.init == 2 then
				f.button:Show()
			end
		end
	)

	f:SetScript(
		"OnEscapePressed",
		function()
			f:method()
		end
	)

	f.button = CreateFrame("Button", "KH_UI_INPUTBUTTON_0" .. uniqueTextBox, f, "UIPanelButtonTemplate")
	f.button:SetWidth(40)
	f.button:SetHeight(20)
	f.button:SetScale(0.5)
	f.button:SetPoint("RIGHT", -2, 0)
	f.button:SetText("OKAY")
	f.button:SetScript(
		"OnClick",
		function()
			f:method()
		end
	)
	f.button:Hide()

	return f
end

function KH_UI:Construct_DropDownMenu(name, setting, parent, point, ofsx, ofsy, width, items, method)
	local f = CreateFrame("FRAME", nil, parent)
	f:SetSize(width, 32)
	f:SetPoint(point, ofsx, ofsy)
	f.text = f:CreateFontString(nil, nil, "GameFontNormal")
	f.text:SetText(name)
	f.text:SetPoint("left", 0, 0)
	if KHOptions.dropDownCount == nil then
		KHOptions.dropDownCount = 0
	end
	KHOptions.dropDownCount = KHOptions.dropDownCount + 1
	f.dropDown = CreateFrame("FRAME", "KH_UI_DropDown0" .. KHOptions.dropDownCount, f, "UIDropDownMenuTemplate")
	f.dropDown:SetPoint("topleft", -24, -24)
	UIDropDownMenu_SetWidth(f.dropDown, width)
	UIDropDownMenu_SetText(f.dropDown, setting)
	f.dropDown.func = function(self, arg1, arg2, checked)
		UIDropDownMenu_SetSelectedName(f.dropDown, self.value)
		UIDropDownMenu_SetText(f.dropDown, self.value)
		setting = self.value
		method(self.value)
	end

	UIDropDownMenu_Initialize(
		f.dropDown,
		function(self, level, menuList)
			local info = UIDropDownMenu_CreateInfo()
			info.func = f.dropDown.func
			info.tooltipOnButton = true
			info.tooltipTitle = f.tip
			for i in ipairs(items) do
				info.text, info.checked = items[i], items[i] == setting
				UIDropDownMenu_AddButton(info)
			end
		end
	)
	return f
end

local function Options_Panel_Template(name, top)
	local f = CreateFrame("Frame", nil, UIParent)
	f:SetPoint("TOPLEFT", 0, 0)

	--if top ~= nil then
	--	f.parent = KHOptions.name
	--end

	f.name = name

	f.Title = CreateFrame("Frame", nil, f)
	f.Title:SetPoint("TOP", 0, -16)
	f.Title:SetSize(1, 1)
	f.Title.text = f.Title:CreateFontString(nil, nil, "GameFontNormalLarge")
	f.Title.text:SetText(name)
	f.Title.text:SetPoint("CENTER", 0, 0)

	f.resetUi = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
	f.resetUi:SetPoint("BottomRight", -16, 16)
	f.resetUi:SetWidth(100)
	f.resetUi.text = f.resetUi:CreateFontString(nil, nil, "GameFontNormal")
	f.resetUi.text:SetText("Reload UI")
	f.resetUi.text:SetPoint("CENTER", 0, 0)
	f.resetUi:SetScript(
		"OnClick",
		function()
			C_UI.Reload()
		end
	)

	f.setDefaults = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
	f.setDefaults:SetPoint("BOTTOMLEFT", 16, 16)
	f.setDefaults:SetWidth(100)
	f.setDefaults.text = f.setDefaults:CreateFontString(nil, nil, "GameFontNormal")
	f.setDefaults.text:SetText("Set Defaults")
	f.setDefaults.text:SetPoint("CENTER", 0, 0)
	f.setDefaults:SetScript(
		"OnClick",
		function()
			StaticPopup_Show ("KH_UI_Set_Default")
		end
	)
	if InterfaceOptions_AddCategory then
		InterfaceOptions_AddCategory(f)
	else
		if (not category) then
			category, layout = Settings.RegisterCanvasLayoutCategory(f, f.name);
			category.ID = f.name
			Settings.RegisterAddOnCategory(category);
		else
			local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, f, f.name);
			subcategory.ID = f.name
			Settings.RegisterAddOnCategory(subcategory);
		end
	end
	return f
end

local function Create_Panel(name, top)
	return Options_Panel_Template(name, top)
end

local loaded = false

KHOptions = Create_Panel("Kingdom Hearts UI");
local PlayerPanel = Create_Panel("Player Frame");
local PartyPanel = Create_Panel("Party Frame");
local TargetPanel = Create_Panel("Target Frame");

KHOptions:RegisterEvent("PLAYER_ENTERING_WORLD")
KHOptions:SetScript(
	"OnEvent",
	function(self, event, arg1)
		if ((event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LOGIN") and loaded == false) then
			KH_UI:General_Options(self)
			--local playerPanel = Create_Panel("Player Frame", true)
			--local partyPanel = Create_Panel("Party Frame", true)
			--local targetPanel = Create_Panel("Target Frame", true)

			KH_UI:KH_Player_Frame_Options(PlayerPanel)
			KH_UI:KH_Party_Frame_Options(PartyPanel)
			KH_UI:KH_Target_Frame_Options(TargetPanel)
			loaded = true
			--InterfaceOptionsFrame_Show()
			--InterfaceOptionsFrame_OpenToCategory(playerPanel)
			KHOptions:UnregisterEvent("PLAYER_ENTERING_WORLD")
		end
	end
)
