function KH_UI:KH_Player_Frame_Options(panel)
	---------------------
	--General Container--
	---------------------
	panel.generalBox = CreateFrame("Frame", nil, panel)
	panel.generalBox:SetSize(590, 75)
	panel.generalBox:SetPoint("TOPLEFT", 16, -64)
	panel.generalBox:SetBackdrop(
		{
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 16,
			edgeSize = 16,
			insets = {left = 5, right = 5, top = 5, bottom = 5}
		}
	)
	panel.generalBox:SetBackdropColor(0, 0, 0, 0.25)
	panel.generalBox.text = panel.generalBox:CreateFontString(nil, nil, "GameFontNormal")
	panel.generalBox.text:SetText("General")
	panel.generalBox.text:SetPoint("TOP", 0, 16)
	--------------------
	--Enabled Checkbox--
	--------------------
	panel.generalBox.enabledCheckbox = KH_UI:createCheckbutton(panel.generalBox, 16, -16, "Enabled")
	panel.generalBox.enabledCheckbox.tooltip = "Enables the player frame"
	panel.generalBox.enabledCheckbox:SetChecked(KH_UI_Settings[panel.name].enabled)
	panel.generalBox.enabledCheckbox:SetScript(
		"OnClick",
		function()
			KH_UI_Settings[panel.name].enabled = panel.generalBox.enabledCheckbox:GetChecked()
			KH_UI:Set_BlizzardFrames()
			panel.generalBox.blizzardEnabledCheckbox:Hide()
			if panel.generalBox.enabledCheckbox:GetChecked() then
				panel.generalBox.blizzardEnabledCheckbox:Show()
			end
			if (panel.generalBox.blizzardEnabledCheckbox:GetChecked()) then
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			else
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
			end
		end
	)
	-----------------------------------
	--Blizzard frame enabled Checkbox--
	-----------------------------------
	panel.generalBox.blizzardEnabledCheckbox =
		KH_UI:createCheckbutton(panel.generalBox.enabledCheckbox, 0, -24, "Blizzard Frame Enabled")
	panel.generalBox.blizzardEnabledCheckbox.tooltip = "Enables the default blizzard player frame"
	panel.generalBox.blizzardEnabledCheckbox:SetChecked(KH_UI_Settings[panel.name].blizzardEnabled)
	panel.generalBox.blizzardEnabledCheckbox:SetScript(
		"OnClick",
		function()
			KH_UI_Settings[panel.name].blizzardEnabled = panel.generalBox.blizzardEnabledCheckbox:GetChecked()
			KH_UI:Set_BlizzardFrames()
			if (panel.generalBox.blizzardEnabledCheckbox:GetChecked()) then
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			else
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
			end
		end
	)
	--------------------------
	--Movable Checkbox--
	--------------------------
	panel.generalBox.draggableCheck = KH_UI:createCheckbutton(panel.generalBox, 192, -16, "Movable")
	panel.generalBox.draggableCheck.tooltip = "Locks/Unlocks the unit frame to be movable"
	panel.generalBox.draggableCheck:SetChecked(KH_UI_Settings[panel.name].movable)
	panel.generalBox.draggableCheck:SetScript(
		"OnClick",
		function()
			KH_UI_Settings[panel.name].movable = panel.generalBox.draggableCheck:GetChecked()
			KH_UI.playerFrame.Update_FrameInfo()
			if (panel.generalBox.draggableCheck:GetChecked()) then
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			else
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
			end
		end
	)
	----------------
	--Scale Slider--
	----------------
	panel.scaleSlider = CreateFrame("Slider", "KHPlayerScaleSlider", panel.generalBox, "OptionsSliderTemplate")
	panel.scaleSlider:SetPoint("TOPRight", -16, -24)
	panel.scaleSlider:SetMinMaxValues(50, 300)
	panel.scaleSlider:SetStepsPerPage(1)
	panel.scaleSlider:SetValueStep(1)
	panel.scaleSlider:SetValue(KH_UI_Settings[panel.name].scale * 100)
	panel.scaleSlider:SetScript(
		"OnValueChanged",
		function(self)
			self:SetValue(round(self:GetValue(), 2))
			self.inputBox:SetText(self:GetValue() / 100)
			KH_UI_Settings[panel.name].scale = self:GetValue() / 100
			KH_UI.playerFrame.Update_FrameInfo()
			panel.scaleSlider.inputBox.button:Hide()
		end
	)
	panel.scaleSlider.inputBox =
		KH_UI:Create_InputBox(
		panel.scaleSlider:GetValue() / 100,
		panel.scaleSlider,
		"CENTER",
		0,
		-16,
		64,
		function()
			panel.scaleSlider:SetValue(panel.scaleSlider.inputBox:GetNumber() * 100)
			panel.scaleSlider.inputBox:SetText(panel.scaleSlider:GetValue() / 100)
			KH_UI_Settings[panel.name].scale = panel.scaleSlider:GetValue() / 100
			KH_UI.playerFrame.Update_FrameInfo()
		end
	)
	panel.scaleSlider.inputBox:SetNumeric(false)
	panel.scaleSlider.inputBox:SetText(panel.scaleSlider:GetValue() / 100)
	panel.scaleSlider.tooltipText = "Sets how large the frame is."
	_G[panel.scaleSlider:GetName() .. "Low"]:SetText("0.5") -- Sets the left-side slider text (default is "Low").
	_G[panel.scaleSlider:GetName() .. "High"]:SetText("3") -- Sets the right-side slider text (default is "High").
	_G[panel.scaleSlider:GetName() .. "Text"]:SetText("Scale") -- Sets the "title" text (top-centre of slider).
	--------------------
	--Health Container--
	--------------------
	panel.healthBox = CreateFrame("Frame", nil, panel.generalBox)
	panel.healthBox:SetSize(280, 150)
	panel.healthBox:SetPoint("TOPLEFT", panel.generalBox, "BOTTOMLEFT", 0, -24)
	panel.healthBox:SetBackdrop(
		{
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 16,
			edgeSize = 16,
			insets = {left = 5, right = 5, top = 5, bottom = 5}
		}
	)
	panel.healthBox:SetBackdropColor(0, 0, 0, 0.25)
	panel.healthBox.text = panel.healthBox:CreateFontString(nil, nil, "GameFontNormal")
	panel.healthBox.text:SetText("Health Settings")
	panel.healthBox.text:SetPoint("TOP", 0, 16)
	-----------------
	--HP Length Max--
	-----------------
	panel.healthBox.lengthMax = CreateFrame("Frame", nil, panel.healthBox)
	panel.healthBox.lengthMax:SetSize(1, 1)
	panel.healthBox.lengthMax:SetPoint("TOPLEFT", 16, -16)
	panel.healthBox.lengthMax.text = panel.healthBox.lengthMax:CreateFontString(nil, nil, "GameFontWhite")
	panel.healthBox.lengthMax.text:SetText("Maximum Length")
	panel.healthBox.lengthMax.text:SetPoint("LEFT", 0, 0)

	panel.healthBox.lengthMax.inputBox =
		KH_UI:Create_InputBox(
		KH_UI_Settings[panel.name].healthLengthMax,
		panel.healthBox.lengthMax,
		"Left",
		0,
		-16,
		112,
		function()
			local max = panel.healthBox.lengthMax.inputBox:GetNumber()
			if max < 1 then
				max = 1
			end
			KH_UI_Settings[panel.name].healthLengthMax = max
			KH_UI.playerFrame.Update_Health()
		end
	)
	panel.healthBox.lengthMax.tooltip = CreateFrame("Button", nil, panel.healthBox, "UIPanelGoldButtonTemplate")
	panel.healthBox.lengthMax.tooltip:SetAlpha(0)
	panel.healthBox.lengthMax.tooltip.tooltipText = "Sets how long in total the health bar can be. (In maximum health)"
	panel.healthBox.lengthMax.tooltip:SetSize(136, 12)
	panel.healthBox.lengthMax.tooltip:SetPoint("TOPLEFT", panel.healthBox, "TOPLEFT", 0, -12)
	GameTooltip_AddNewbieTip(panel.healthBox.lengthMax.tooltip, panel.healthBox.lengthMax.tooltip.tooltipText, 1.0, 1.0, 0)
	GameTooltip:Hide()
	-----------------
	--HP Ring Max----
	-----------------
	panel.healthBox.fullRing = CreateFrame("Frame", nil, panel.healthBox)
	panel.healthBox.fullRing:SetSize(1, 1)
	panel.healthBox.fullRing:SetPoint("TOPRight", -16, -16)
	panel.healthBox.fullRing.text = panel.healthBox.fullRing:CreateFontString(nil, nil, "GameFontWhite")
	panel.healthBox.fullRing.text:SetText("Full Ring")
	panel.healthBox.fullRing.text:SetPoint("Right", 0, 0)

	panel.healthBox.fullRing.inputBox =
		KH_UI:Create_InputBox(
		KH_UI_Settings[panel.name].ringMaxHealth,
		panel.healthBox.fullRing,
		"Right",
		0,
		-16,
		112,
		function()
			local max = panel.healthBox.fullRing.inputBox:GetNumber()
			if max < 1 then
				max = 1
			end
			KH_UI_Settings[panel.name].ringMaxHealth = max
			KH_UI.playerFrame.Update_Health()
			panel.healthBox.fullRing.inputBox:SetText(KH_UI_Settings[panel.name].ringMaxHealth)
		end
	)
	panel.healthBox.fullRing.tooltip = CreateFrame("Button", nil, panel.healthBox, "UIPanelGoldButtonTemplate")
	panel.healthBox.fullRing.tooltip:SetAlpha(0)
	panel.healthBox.fullRing.tooltip.tooltipText = "Sets how much health will make the ring full"
	panel.healthBox.fullRing.tooltip:SetSize(80, 12)
	panel.healthBox.fullRing.tooltip:SetPoint("TOPRIGHT", panel.healthBox, "TOPRIGHT", -12, -12)
	GameTooltip_AddNewbieTip(panel.healthBox.fullRing.tooltip, panel.healthBox.fullRing.tooltip.tooltipText, 1.0, 1.0, 1.0)
	GameTooltip:Hide()
	-----------------
	--HP Bar Growth--
	-----------------
	panel.healthBox.barGrowth = CreateFrame("Frame", nil, panel.healthBox.lengthMax)
	panel.healthBox.barGrowth:SetSize(1, 1)
	panel.healthBox.barGrowth:SetPoint("TOPLEFT", panel.healthBox.lengthMax, "BOTTOMLEFT", 0, -38)
	panel.healthBox.barGrowth.text = panel.healthBox.barGrowth:CreateFontString(nil, nil, "GameFontWhite")
	panel.healthBox.barGrowth.text:SetText("Long Bar Growth")
	panel.healthBox.barGrowth.text:SetPoint("Left", 0, 0)

	panel.healthBox.barGrowth.inputBox =
		KH_UI:Create_InputBox(
		KH_UI_Settings[panel.name].longBarHealthLengthRate,
		panel.healthBox.barGrowth,
		"Left",
		0,
		-16,
		112,
		function()
			local max = panel.healthBox.barGrowth.inputBox:GetNumber()
			if max < 1 then
				max = 1
			end
			KH_UI_Settings[panel.name].longBarHealthLengthRate = max
			KH_UI.playerFrame.Update_Health()
			panel.healthBox.barGrowth.inputBox:SetText(KH_UI_Settings[panel.name].longBarHealthLengthRate)
		end
	)
	panel.healthBox.barGrowth.tooltip = CreateFrame("Button", nil, panel.healthBox.barGrowth, "UIPanelGoldButtonTemplate")
	panel.healthBox.barGrowth.tooltip:SetAlpha(0)
	panel.healthBox.barGrowth.tooltip.tooltipText = "Sets how slow the stretch bar will extend. (How many HPs per pixel)"
	panel.healthBox.barGrowth.tooltip:SetSize(136, 12)
	panel.healthBox.barGrowth.tooltip:SetPoint("TOPLEFT", panel.healthBox.barGrowth, "TOPLEFT", -12, 4)
	GameTooltip_AddNewbieTip(
		panel.healthBox.barGrowth.tooltip,
		panel.healthBox.barGrowth.tooltip.tooltipText,
		1.0,
		1.0,
		1.0
	)
	GameTooltip:Hide()
	--------------------------
	--Display Value Checkbox--
	--------------------------
	panel.healthBox.displayHealthCheck =
		KH_UI:createCheckbutton(panel.healthBox.barGrowth, -4, -34, "Display Health Value")
	panel.healthBox.displayHealthCheck.tooltip = "Displays the unit's current health value"
	panel.healthBox.displayHealthCheck:SetChecked(KH_UI_Settings[panel.name].displayHealthValue)
	panel.healthBox.displayHealthCheck:SetScript(
		"OnClick",
		function()
			KH_UI_Settings[panel.name].displayHealthValue = panel.healthBox.displayHealthCheck:GetChecked()
			if (panel.healthBox.displayHealthCheck:GetChecked()) then
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			else
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
			end
		end
	)
	--------------------
	--Power Container---
	--------------------
	panel.powerBox = CreateFrame("Frame", nil, panel.healthBox)
	panel.powerBox:SetSize(280, 150)
	panel.powerBox:SetPoint("TOPLEFT", panel.healthBox, "TOPRIGHT", 30, 0)
	panel.powerBox:SetBackdrop(
		{
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 16,
			edgeSize = 16,
			insets = {left = 5, right = 5, top = 5, bottom = 5}
		}
	)
	panel.powerBox:SetBackdropColor(0, 0, 0, 0.25)
	panel.powerBox.text = panel.powerBox:CreateFontString(nil, nil, "GameFontNormal")
	panel.powerBox.text:SetText("Power Ring Settings")
	panel.powerBox.text:SetPoint("TOP", 0, 16)
	--------------------
	--Power Ring Max----
	--------------------
	panel.powerBox.fullRing = CreateFrame("Frame", nil, panel.powerBox)
	panel.powerBox.fullRing:SetSize(1, 1)
	panel.powerBox.fullRing:SetPoint("TOPLEFT", 16, -16)
	panel.powerBox.fullRing.text = panel.powerBox.fullRing:CreateFontString(nil, nil, "GameFontWhite")
	panel.powerBox.fullRing.text:SetText("Ring Max")
	panel.powerBox.fullRing.text:SetPoint("LEFT", 0, 0)

	panel.powerBox.fullRing.inputBox =
		KH_UI:Create_InputBox(
		KH_UI_Settings[panel.name].ringMaxPower,
		panel.powerBox.fullRing,
		"Left",
		0,
		-16,
		112,
		function()
			local max = panel.powerBox.fullRing.inputBox:GetNumber()
			if max < 1 then
				max = 1
			end
			KH_UI_Settings[panel.name].ringMaxPower = max
			KH_UI.playerFrame.Update_Health()
			KH_UI.playerFrame.Update_Power()
			panel.powerBox.fullRing.inputBox:SetText(KH_UI_Settings[panel.name].ringMaxPower)
		end
	)
	panel.powerBox.fullRing.tooltip = CreateFrame("Button", nil, panel.powerBox, "UIPanelGoldButtonTemplate")
	panel.powerBox.fullRing.tooltip:SetAlpha(0)
	panel.powerBox.fullRing.tooltip.tooltipText = "Sets how much in power will make the ring full (In maximum power)"
	panel.powerBox.fullRing.tooltip:SetSize(136, 12)
	panel.powerBox.fullRing.tooltip:SetPoint("TOPLEFT", panel.powerBox, "TOPLEFT", 0, -12)
	GameTooltip_AddNewbieTip(panel.powerBox.fullRing.tooltip, panel.powerBox.fullRing.tooltip.tooltipText, 1.0, 1.0, 0)
	GameTooltip:Hide()
	--------------------------
	--Display Value Checkbox--
	--------------------------
	panel.powerBox.displayPowerCheck = KH_UI:createCheckbutton(panel.powerBox.fullRing, -4, -32, "Display Power Value")
	panel.powerBox.displayPowerCheck.tooltip = "Displays the unit's current power value"
	panel.powerBox.displayPowerCheck:SetChecked(KH_UI_Settings[panel.name].displayPowerValue)
	panel.powerBox.displayPowerCheck:SetScript(
		"OnClick",
		function()
			KH_UI_Settings[panel.name].displayPowerValue = panel.powerBox.displayPowerCheck:GetChecked()
			if (panel.powerBox.displayPowerCheck:GetChecked()) then
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			else
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
			end
		end
	)
	------------------
	--Mana Container--
	------------------
	panel.manaBox = CreateFrame("Frame", nil, panel.healthBox)
	panel.manaBox:SetSize(280, 150)
	panel.manaBox:SetPoint("TOPLEFT", panel.healthBox, "BOTTOMLEFT", 0, -24)
	panel.manaBox:SetBackdrop(
		{
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 16,
			edgeSize = 16,
			insets = {left = 5, right = 5, top = 5, bottom = 5}
		}
	)
	panel.manaBox:SetBackdropColor(0, 0, 0, 0.25)
	panel.manaBox.text = panel.manaBox:CreateFontString(nil, nil, "GameFontNormal")
	panel.manaBox.text:SetText("Mana Settings")
	panel.manaBox.text:SetPoint("TOP", 0, 16)
	-------------------
	--Mana Length Max--
	-------------------
	panel.manaBox.manaMax = CreateFrame("Frame", nil, panel.manaBox)
	panel.manaBox.manaMax:SetSize(1, 1)
	panel.manaBox.manaMax:SetPoint("TOPLEFT", 16, -16)
	panel.manaBox.manaMax.text = panel.manaBox.manaMax:CreateFontString(nil, nil, "GameFontWhite")
	panel.manaBox.manaMax.text:SetText("Length Max")
	panel.manaBox.manaMax.text:SetPoint("LEFT", 0, 0)

	panel.manaBox.manaMax.inputBox =
		KH_UI:Create_InputBox(
		KH_UI_Settings[panel.name].manaLengthMax,
		panel.manaBox.manaMax,
		"Left",
		0,
		-16,
		112,
		function()
			local max = panel.manaBox.manaMax.inputBox:GetNumber()
			if max < 1 then
				max = 1
			end
			KH_UI_Settings[panel.name].manaLengthMax = max
			panel.manaBox.manaMax.inputBox:SetText(KH_UI_Settings[panel.name].manaLengthMax)
		end
	)
	panel.manaBox.manaMax.tooltip = CreateFrame("Button", nil, panel.manaBox, "UIPanelGoldButtonTemplate")
	panel.manaBox.manaMax.tooltip:SetAlpha(0)
	panel.manaBox.manaMax.tooltip.tooltipText = "Sets the maximum value of mana the bar will extend"
	panel.manaBox.manaMax.tooltip:SetSize(136, 12)
	panel.manaBox.manaMax.tooltip:SetPoint("TOPLEFT", panel.manaBox, "TOPLEFT", 0, -12)
	GameTooltip_AddNewbieTip(panel.manaBox.manaMax.tooltip, panel.manaBox.manaMax.tooltip.tooltipText, 1.0, 1.0, 0)
	GameTooltip:Hide()
	-------------------
	--Mana Length Rate--
	-------------------
	panel.manaBox.manaRate = CreateFrame("Frame", nil, panel.manaBox)
	panel.manaBox.manaRate:SetSize(1, 1)
	panel.manaBox.manaRate:SetPoint("TOPRight", -16, -16)
	panel.manaBox.manaRate.text = panel.manaBox.manaRate:CreateFontString(nil, nil, "GameFontWhite")
	panel.manaBox.manaRate.text:SetText("Length Rate")
	panel.manaBox.manaRate.text:SetPoint("Right", 0, 0)

	panel.manaBox.manaRate.inputBox =
		KH_UI:Create_InputBox(
		KH_UI_Settings[panel.name].manaLengthRate,
		panel.manaBox.manaRate,
		"Right",
		0,
		-16,
		112,
		function()
			panel.manaBox.manaRate.inputBox:ClearFocus()
			local max = panel.manaBox.manaRate.inputBox:GetNumber()
			if max < 1 then
				max = 1
			end
			KH_UI_Settings[panel.name].manaLengthRate = max
			panel.manaBox.manaRate.inputBox:SetText(KH_UI_Settings[panel.name].manaLengthRate)
		end
	)
	panel.manaBox.manaRate.tooltip = CreateFrame("Button", nil, panel.manaBox, "UIPanelGoldButtonTemplate")
	panel.manaBox.manaRate.tooltip:SetAlpha(0)
	panel.manaBox.manaRate.tooltip.tooltipText = "Sets the rate the mana bar will extend by mana per pixel"
	panel.manaBox.manaRate.tooltip:SetSize(90, 12)
	panel.manaBox.manaRate.tooltip:SetPoint("TOPRIGHT", panel.manaBox, "TOPRIGHT", -12, -12)
	GameTooltip_AddNewbieTip(panel.manaBox.manaRate.tooltip, panel.manaBox.manaRate.tooltip.tooltipText, 1.0, 1.0, 0)
	GameTooltip:Hide()
	--------------------------
	--Display Value Checkbox--
	--------------------------
	panel.manaBox.displayManaCheck = KH_UI:createCheckbutton(panel.manaBox.manaMax, -4, -34, "Display Mana Value")
	panel.manaBox.displayManaCheck.tooltip = "Displays the unit's current mana value"
	panel.manaBox.displayManaCheck:SetChecked(KH_UI_Settings[panel.name].displayManaValue)
	panel.manaBox.displayManaCheck:SetScript(
		"OnClick",
		function()
			KH_UI_Settings[panel.name].displayManaValue = panel.manaBox.displayManaCheck:GetChecked()
			if (panel.manaBox.displayManaCheck:GetChecked()) then
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			else
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
			end
		end
	)
	-------------------
	--Style Container--
	-------------------
	panel.styleContainer = CreateFrame("Frame", nil, panel.manaBox)
	panel.styleContainer:SetSize(280, 150)
	panel.styleContainer:SetPoint("TOPLEFT", panel.manaBox, "TOPRIGHT", 30, 0)
	panel.styleContainer:SetBackdrop(
		{
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 16,
			edgeSize = 16,
			insets = {left = 5, right = 5, top = 5, bottom = 5}
		}
	)
	panel.styleContainer:SetBackdropColor(0, 0, 0, 0.25)
	panel.styleContainer.text = panel.styleContainer:CreateFontString(nil, nil, "GameFontNormal")
	panel.styleContainer.text:SetText("Style Settings")
	panel.styleContainer.text:SetPoint("TOP", 0, 16)
	--------------
	--Orientation-
	--------------
	panel.styleContainer.orientationDropDown =
		KH_UI:Construct_DropDownMenu(
		"Rotate Orientation",
		KH_UI_Settings[panel.name].orientation,
		panel.styleContainer,
		"TopLeft",
		16,
		0,
		110,
		{"Bottom Right", "Top Right", "Bottom Left", "Top Left"},
		function(value)
			KH_UI_Settings[panel.name].orientation = value
			KH_UI:update_ring_segments(KH_UI.playerFrame)
			KH_UI.playerFrame.Update_Health()
			KH_UI.playerFrame.Update_Power()
			KH_UI.playerFrame.Refresh_Points()
		end
	)
	panel.styleContainer.orientationDropDown.tip =
		"Rotates the frame to fit the desired corner of the screen. \nRequires reload to fix some visual errors"
end
