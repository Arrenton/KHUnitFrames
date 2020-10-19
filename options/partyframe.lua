function KH_UI:KH_Party_Frame_Options(panel)
	---------------------
	--General Container--
	---------------------
	panel.generalBox = CreateFrame("Frame", nil, panel)
	if not panel.generalBox.SetBackdrop then
		Mixin(panel.generalBox, BackdropTemplateMixin)
	end
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
	panel.generalBox.enabledCheckbox.tooltip = "Enables the party frame"
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
	panel.generalBox.blizzardEnabledCheckbox.tooltip = "Enables the default blizzard party frame"
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
			for i in pairs(KH_UI.partyFrame) do
				KH_UI.partyFrame[i].Update_FrameInfo()
			end
			if (panel.generalBox.draggableCheck:GetChecked()) then
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			else
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
			end
		end
	)
	-----------------------------------
	--Blizzard frame enabled Checkbox--
	-----------------------------------
	panel.generalBox.hideNotInPartyCheckbox = KH_UI:createCheckbutton(panel.generalBox.draggableCheck, 0, -24, "Hide when not in party")
	panel.generalBox.hideNotInPartyCheckbox.tooltip = "Hides the party frames when not in a party\nDisable to help with positioning"
	panel.generalBox.hideNotInPartyCheckbox:SetChecked(KH_UI_Settings[panel.name].hideNotInParty)
	panel.generalBox.hideNotInPartyCheckbox:SetScript(
		"OnClick",
		function()
			if (panel.generalBox.hideNotInPartyCheckbox:GetChecked()) then
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
				for i = 1, 4, 1 do
					RegisterStateDriver(KH_UI.partyFrame[i], "visibility", "[@raid1, exists]hide;[@party" .. i .. ",exists]show;hide")
					KH_UI_Settings[panel.name].hideNotInParty = true
				end
			else
				PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
				for i = 1, 4, 1 do
					UnregisterStateDriver(KH_UI.partyFrame[i], "visibility")
					KH_UI.partyFrame[i]:Show()
					KH_UI_Settings[panel.name].hideNotInParty = false
				end
			end
		end
	)
	----------------
	--Scale Slider--
	----------------
	panel.scaleSlider = CreateFrame("Slider", "KHPartyScaleSlider", panel.generalBox, "OptionsSliderTemplate")
	panel.scaleSlider:SetPoint("TOPRight", -16, -24)
	panel.scaleSlider:SetMinMaxValues(25, 150)
	panel.scaleSlider:SetStepsPerPage(1)
	panel.scaleSlider:SetValueStep(1)
	panel.scaleSlider:SetValue(KH_UI_Settings[panel.name].scale * 100)
	panel.scaleSlider:SetScript(
		"OnValueChanged",
		function(self)
			self:SetValue(round(self:GetValue(), 2))
			self.inputBox:SetText(self:GetValue() / 100)
			KH_UI_Settings[panel.name].scale = self:GetValue() / 100
			for i in pairs(KH_UI.partyFrame) do
				KH_UI.partyFrame[i]:SetScale(KH_UI_Settings[panel.name].scale)
			end
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
			for i in pairs(KH_UI.partyFrame) do
				KH_UI.partyFrame[i]:SetScale(KH_UI_Settings[panel.name].scale)
			end
		end
	)
	panel.scaleSlider.inputBox:SetNumeric(false)
	panel.scaleSlider.inputBox:SetText(panel.scaleSlider:GetValue() / 100)
	panel.scaleSlider.inputBox:SetCursorPosition(0)
	panel.scaleSlider.tooltipText = "Sets how large the frame is."
	_G[panel.scaleSlider:GetName() .. "Low"]:SetText("0.25") -- Sets the left-side slider text (default is "Low").
	_G[panel.scaleSlider:GetName() .. "High"]:SetText("1.5") -- Sets the right-side slider text (default is "High").
	_G[panel.scaleSlider:GetName() .. "Text"]:SetText("Scale") -- Sets the "title" text (top-centre of slider).
	if (KH_UI_Settings[panel.name].style == "KH2") then
		KH_UI:Create_KH2_Style_Settings(panel, KH_UI.partyFrame, "party")
	elseif (KH_UI_Settings[panel.name].style == "KH1") then
		KH_UI:Create_KH1_Style_Settings(panel, KH_UI.partyFrame, "party")
	end
end
