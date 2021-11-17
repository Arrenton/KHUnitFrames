function KH_UI:Create_KH1_Style_Settings(panel, frame, type)
    --------------------
    --Health Container--
    --------------------
    --panel.healthBox = CreateFrame("Frame", nil, panel.generalBox)
    panel.healthBox = CreateFrame("Frame", nil, panel.generalBox, BackdropTemplateMixin and "BackdropTemplate")
	--if not panel.healthBox.SetBackdrop then
	--	Mixin(panel.healthBox, BackdropTemplateMixin)
	--end
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
            if (type == "player" or type == "target") then
                frame.Update_Health(true)
            elseif (type == "party") then
                for i in pairs(frame) do
                    frame[i].Update_Health(true)
                end
            end
        end
    )
    panel.healthBox.lengthMax.tooltip = CreateFrame("Button", nil, panel.healthBox, "UIPanelGoldButtonTemplate")
    panel.healthBox.lengthMax.tooltip:SetAlpha(0)
    panel.healthBox.lengthMax.tooltip.tooltipText = "Sets how long in total the health bar can be. (In maximum health)"
    panel.healthBox.lengthMax.tooltip:SetSize(136, 12)
    panel.healthBox.lengthMax.tooltip:SetPoint("TOPLEFT", panel.healthBox, "TOPLEFT", 0, -12)
    GameTooltip_AddNewbieTip(
        panel.healthBox.lengthMax.tooltip,
        panel.healthBox.lengthMax.tooltip.tooltipText,
        1.0,
        1.0,
        0
    )
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
            if (type == "player" or type == "target") then
                frame.Update_Health(true)
            elseif (type == "party") then
                for i in pairs(frame) do
                    frame[i].Update_Health(true)
                end
            end
            panel.healthBox.fullRing.inputBox:SetText(KH_UI_Settings[panel.name].ringMaxHealth)
        end
    )
    panel.healthBox.fullRing.tooltip = CreateFrame("Button", nil, panel.healthBox, "UIPanelGoldButtonTemplate")
    panel.healthBox.fullRing.tooltip:SetAlpha(0)
    panel.healthBox.fullRing.tooltip.tooltipText = "Sets how much health will make the ring full"
    panel.healthBox.fullRing.tooltip:SetSize(80, 12)
    panel.healthBox.fullRing.tooltip:SetPoint("TOPRIGHT", panel.healthBox, "TOPRIGHT", -12, -12)
    GameTooltip_AddNewbieTip(
        panel.healthBox.fullRing.tooltip,
        panel.healthBox.fullRing.tooltip.tooltipText,
        1.0,
        1.0,
        1.0
    )
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
            if (type == "player" or type == "target") then
                frame.Update_Health(true)
            elseif (type == "party") then
                for i in pairs(frame) do
                    frame[i].Update_Health(true)
                end
            end
            panel.healthBox.barGrowth.inputBox:SetText(KH_UI_Settings[panel.name].longBarHealthLengthRate)
        end
    )
    panel.healthBox.barGrowth.tooltip =
        CreateFrame("Button", nil, panel.healthBox.barGrowth, "UIPanelGoldButtonTemplate")
    panel.healthBox.barGrowth.tooltip:SetAlpha(0)
    panel.healthBox.barGrowth.tooltip.tooltipText =
        "Sets the rate at which the stretch bar will extend. (5000 = 5 pixels every 1 HP, 1000 = 1 pixel every 1 HP, 200 = 1 pixel every 5 HP)"
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
    panel.powerBox = CreateFrame("Frame", nil, panel.healthBox, BackdropTemplateMixin and "BackdropTemplate")
	--[[if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
		panel.powerBox = CreateFrame("Frame", nil, panel.healthBox)
	elseif WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
		panel.powerBox = CreateFrame("Frame", nil, panel.healthBox, 'BackdropTemplate')
	else
		panel.powerBox = CreateFrame("Frame", nil, panel.healthBox)
	end]]
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
    panel.powerBox.text:SetText("Mana Ring Settings")
    panel.powerBox.text:SetPoint("TOP", 0, 16)
    --------------------
    --Mana Ring Max----
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
            if (type == "player" or type == "target") then
                frame.Update_Health(true)
                frame.Update_Power(true)
            elseif (type == "party") then
                for i in pairs(frame) do
                    frame[i].Update_Health(true)
                    frame[i].Update_Power(true)
                end
            end
            panel.powerBox.fullRing.inputBox:SetText(KH_UI_Settings[panel.name].ringMaxPower)
        end
    )
    panel.powerBox.fullRing.tooltip = CreateFrame("Button", nil, panel.powerBox, "UIPanelGoldButtonTemplate")
    panel.powerBox.fullRing.tooltip:SetAlpha(0)
    panel.powerBox.fullRing.tooltip.tooltipText = "Sets how much in mana will make the ring full (In maximum mana)"
    panel.powerBox.fullRing.tooltip:SetSize(136, 12)
    panel.powerBox.fullRing.tooltip:SetPoint("TOPLEFT", panel.powerBox, "TOPLEFT", 0, -12)
    GameTooltip_AddNewbieTip(panel.powerBox.fullRing.tooltip, panel.powerBox.fullRing.tooltip.tooltipText, 1.0, 1.0, 0)
    GameTooltip:Hide()
    -------------------
    --Mana Length Rate--
    -------------------
    panel.powerBox.manaRate = CreateFrame("Frame", nil, panel.powerBox)
    panel.powerBox.manaRate:SetSize(1, 1)
    panel.powerBox.manaRate:SetPoint("TOPRight", -16, -16)
    panel.powerBox.manaRate.text = panel.powerBox.manaRate:CreateFontString(nil, nil, "GameFontWhite")
    panel.powerBox.manaRate.text:SetText("Length Rate")
    panel.powerBox.manaRate.text:SetPoint("Right", 0, 0)

    panel.powerBox.manaRate.inputBox =
        KH_UI:Create_InputBox(
        KH_UI_Settings[panel.name].manaLengthRate,
        panel.powerBox.manaRate,
        "Right",
        0,
        -16,
        112,
        function()
            panel.powerBox.manaRate.inputBox:ClearFocus()
            local max = panel.powerBox.manaRate.inputBox:GetNumber()
            if max < 1 then
                max = 1
            end
            KH_UI_Settings[panel.name].manaLengthRate = max
            panel.powerBox.manaRate.inputBox:SetText(KH_UI_Settings[panel.name].manaLengthRate)
        end
    )
    panel.powerBox.manaRate.tooltip = CreateFrame("Button", nil, panel.powerBox, "UIPanelGoldButtonTemplate")
    panel.powerBox.manaRate.tooltip:SetAlpha(0)
    panel.powerBox.manaRate.tooltip.tooltipText = "Sets the rate at which the mana bar will extend after max ring. (5000 = 5 pixels every 1 MP, 1000 = 1 pixel every 1 MP, 200 = 1 pixel every 5 MP)"
    panel.powerBox.manaRate.tooltip:SetSize(90, 12)
    panel.powerBox.manaRate.tooltip:SetPoint("TOPRIGHT", panel.powerBox, "TOPRIGHT", -12, -12)
    GameTooltip_AddNewbieTip(panel.powerBox.manaRate.tooltip, panel.powerBox.manaRate.tooltip.tooltipText, 1.0, 1.0, 0)
    GameTooltip:Hide()
    -------------------
    --Mana Length Max--
    -------------------
    panel.powerBox.manaMax = CreateFrame("Frame", nil, panel.powerBox.fullRing)
    panel.powerBox.manaMax:SetSize(1, 1)
    panel.powerBox.manaMax:SetPoint("BOTTOMLEFT", 0, -38)
    panel.powerBox.manaMax.text = panel.powerBox.manaMax:CreateFontString(nil, nil, "GameFontWhite")
    panel.powerBox.manaMax.text:SetText("Mana Length Max")
    panel.powerBox.manaMax.text:SetPoint("LEFT", 0, 0)

    panel.powerBox.manaMax.inputBox =
        KH_UI:Create_InputBox(
        KH_UI_Settings[panel.name].manaLengthMax,
        panel.powerBox.manaMax,
        "Left",
        0,
        -16,
        112,
        function()
            local max = panel.powerBox.manaMax.inputBox:GetNumber()
            if max < 1 then
                max = 1
            end
            KH_UI_Settings[panel.name].manaLengthMax = max
            panel.powerBox.manaMax.inputBox:SetText(KH_UI_Settings[panel.name].manaLengthMax)
        end
    )
    panel.powerBox.manaMax.tooltip = CreateFrame("Button", nil, panel.powerBox.manaMax, "UIPanelGoldButtonTemplate")
    panel.powerBox.manaMax.tooltip:SetAlpha(0)
    panel.powerBox.manaMax.tooltip.tooltipText = "Sets the maximum value of mana the bar will extend"
    panel.powerBox.manaMax.tooltip:SetSize(110, 12)
    panel.powerBox.manaMax.tooltip:SetPoint("TOPLEFT", panel.powerBox.manaMax, "TOPLEFT", 0, 6)
    GameTooltip_AddNewbieTip(panel.powerBox.manaMax.tooltip, panel.powerBox.manaMax.tooltip.tooltipText, 1.0, 1.0, 0)
    GameTooltip:Hide()
    --------------------------
    --Display Value Checkbox--
    --------------------------
    panel.powerBox.displayPowerCheck = KH_UI:createCheckbutton(panel.powerBox.manaMax, -4, -32, "Display Mana Value")
    panel.powerBox.displayPowerCheck.tooltip = "Displays the unit's current mana value"
    panel.powerBox.displayPowerCheck:SetChecked(KH_UI_Settings[panel.name].displayManaValue)
    panel.powerBox.displayPowerCheck:SetScript(
        "OnClick",
        function()
            KH_UI_Settings[panel.name].displayManaValue = panel.powerBox.displayPowerCheck:GetChecked()
            if (panel.powerBox.displayPowerCheck:GetChecked()) then
                PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
            else
                PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
            end
        end
    )
    ------------------
    --Power Container--
    ------------------
    panel.manaBox = CreateFrame("Frame", nil, panel.healthBox, BackdropTemplateMixin and "BackdropTemplate")
	--[[if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
		panel.manaBox = CreateFrame("Frame", nil, panel.healthBox)
	elseif WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
		panel.manaBox = CreateFrame("Frame", nil, panel.healthBox, 'BackdropTemplate')
	else
		panel.manaBox = CreateFrame("Frame", nil, panel.healthBox)
	end]]
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
    panel.manaBox.text:SetText("Power Settings")
    panel.manaBox.text:SetPoint("TOP", 0, 16)
    --------------------------
    --Display Value Checkbox--
    --------------------------
    panel.manaBox.displayManaCheck = KH_UI:createCheckbutton(panel.manaBox, 12, -16, "Display Power Value")
    panel.manaBox.displayManaCheck.tooltip = "Displays the unit's current power value"
    panel.manaBox.displayManaCheck:SetChecked(KH_UI_Settings[panel.name].displayPowerValue)
    panel.manaBox.displayManaCheck:SetScript(
        "OnClick",
        function()
            KH_UI_Settings[panel.name].displayPowerValue = panel.manaBox.displayManaCheck:GetChecked()
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
    panel.styleContainer = CreateFrame("Frame", nil, panel.manaBox, BackdropTemplateMixin and "BackdropTemplate")
	--[[if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
		panel.styleContainer = CreateFrame("Frame", nil, panel.manaBox)
	elseif WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
		panel.styleContainer = CreateFrame("Frame", nil, panel.manaBox, 'BackdropTemplate')
	else
		panel.styleContainer = CreateFrame("Frame", nil, panel.manaBox)
	end]]
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
            KH_UI:update_ring_segments(frame)
            if (type == "player" or type == "target") then
                frame.Update_FrameInfo()
                frame.Update_Health(true)
                frame.Update_Power(true)
                frame.Refresh_Points()
            elseif (type == "party") then
                for i in pairs(frame) do
                    frame[i].Update_FrameInfo()
                    frame[i].Update_Health(true)
                    frame[i].Update_Power(true)
                    frame[i].Refresh_Points()
                end
            end
        end
    )
    panel.styleContainer.orientationDropDown.tip =
        "Rotates the frame to fit the desired corner of the screen. \nRequires reload to fix some visual errors"
end
