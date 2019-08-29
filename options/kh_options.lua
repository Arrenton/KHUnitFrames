local KHOptions

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

function KH_UI:Set_BlizzardFrames()
	if (not InCombatLockdown()) then
		if (KH_UI_Settings["Player Frame"].blizzardEnabled or KH_UI_Settings["Player Frame"].enabled == false) then
			PlayerFrame:Show();
		elseif (PlayerFrame:IsVisible()) then
			PlayerFrame:Hide();
		end
		--Party Frame--
		if (KH_UI_Settings["Party Frame"].blizzardEnabled or KH_UI_Settings["Party Frame"].enabled == false) then
			ShowPartyFrame()
		else
			HidePartyFrame()
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

	if top ~= nil then
		f.parent = KHOptions.name
	end

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

	InterfaceOptions_AddCategory(f)
	return f
end

local function Create_Panel(name, top)
	return Options_Panel_Template(name, top)
end

KHOptions = Create_Panel("Kingdom Hearts UI")
KHOptions:RegisterEvent("PLAYER_ENTERING_WORLD")
KHOptions:SetScript(
	"OnEvent",
	function(self, event, arg1)
		if (event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LOGIN") then
			KH_UI:General_Options(self)
			local playerPanel = Create_Panel("Player Frame", true)
			local partyPanel = Create_Panel("Party Frame", true)

			KH_UI:KH_Player_Frame_Options(playerPanel)
			KH_UI:KH_Party_Frame_Options(partyPanel)

			--InterfaceOptionsFrame_Show()
			--InterfaceOptionsFrame_OpenToCategory(playerPanel)
			KHOptions:UnregisterEvent("PLAYER_ENTERING_WORLD")
		end
	end
)
