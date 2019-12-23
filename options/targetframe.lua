function KH_UI:KH_Target_Frame_Options(panel)
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
	panel.generalBox.enabledCheckbox.tooltip = "Enables the target frame"
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
	panel.generalBox.blizzardEnabledCheckbox.tooltip = "Enables the default blizzard target frame"
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
			KH_UI.targetFrame.Update_FrameInfo()
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
	panel.scaleSlider = CreateFrame("Slider", "KHTargetScaleSlider", panel.generalBox, "OptionsSliderTemplate")
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
			KH_UI.targetFrame.Update_FrameInfo()
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
			KH_UI.targetFrame.Update_FrameInfo()
		end
	)
	panel.scaleSlider.inputBox:SetNumeric(false)
	panel.scaleSlider.inputBox:SetText(panel.scaleSlider:GetValue() / 100)
	panel.scaleSlider.inputBox:SetCursorPosition(0)
	panel.scaleSlider.tooltipText = "Sets how large the frame is."
	_G[panel.scaleSlider:GetName() .. "Low"]:SetText("0.5") -- Sets the left-side slider text (default is "Low").
	_G[panel.scaleSlider:GetName() .. "High"]:SetText("3") -- Sets the right-side slider text (default is "High").
	_G[panel.scaleSlider:GetName() .. "Text"]:SetText("Scale") -- Sets the "title" text (top-centre of slider).
	if (KH_UI_Settings[panel.name].style == "KH Target") then
		KH_UI:Create_KH_Target_Style_Settings(panel, KH_UI.targetFrame, "target")
	elseif (KH_UI_Settings[panel.name].style == "KH2 Target") then
		KH_UI:Create_KH2_Target_Style_Settings(panel, KH_UI.targetFrame, "target")
	end
end
