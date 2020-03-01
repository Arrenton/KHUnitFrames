function KH_UI:Create_KH_Target_Style_Settings(panel, frame, type)
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
            if (type == "player" or type == "target") then
                frame.Update_Health()
            elseif (type == "party") then
                for i in pairs(frame) do
                    frame[i].Update_Health()
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
    --HP Bars max----
    -----------------
    panel.healthBox.maxLength = CreateFrame("Frame", nil, panel.healthBox)
    panel.healthBox.maxLength:SetSize(1, 1)
    panel.healthBox.maxLength:SetPoint("TOPRight", -16, -16)
    panel.healthBox.maxLength.text = panel.healthBox.maxLength:CreateFontString(nil, nil, "GameFontWhite")
    panel.healthBox.maxLength.text:SetText("Max total bars")
    panel.healthBox.maxLength.text:SetPoint("Right", 0, 0)

    panel.healthBox.maxLength.inputBox =
        KH_UI:Create_InputBox(
        KH_UI_Settings[panel.name].maxBars,
        panel.healthBox.maxLength,
        "Right",
        0,
        -16,
        112,
        function()
            local max = panel.healthBox.maxLength.inputBox:GetNumber()
            if max < 1 then
                max = 1
            end
            KH_UI_Settings[panel.name].maxBars = max
            if (type == "player" or type == "target") then
                frame.Update_Health()
            elseif (type == "party") then
                for i in pairs(frame) do
                    frame[i].Update_Health()
                end
            end
            panel.healthBox.maxLength.inputBox:SetText(KH_UI_Settings[panel.name].maxBars)
        end
    )
    panel.healthBox.maxLength.tooltip = CreateFrame("Button", nil, panel.healthBox, "UIPanelGoldButtonTemplate")
    panel.healthBox.maxLength.tooltip:SetAlpha(0)
    panel.healthBox.maxLength.tooltip.tooltipText = "Sets the maximum amount of extra bars health can extend. Limit 6."
    panel.healthBox.maxLength.tooltip:SetSize(80, 12)
    panel.healthBox.maxLength.tooltip:SetPoint("TOPRIGHT", panel.healthBox, "TOPRIGHT", -12, -12)
    GameTooltip_AddNewbieTip(
        panel.healthBox.maxLength.tooltip,
        panel.healthBox.maxLength.tooltip.tooltipText,
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
    panel.healthBox.barGrowth.text:SetText("Bar Growth")
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
                frame.Update_Health()
            elseif (type == "party") then
                for i in pairs(frame) do
                    frame[i].Update_Health()
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
    panel.powerBox.text:SetText("Power Settings")
    panel.powerBox.text:SetPoint("TOP", 0, 16)
    --------------------
    --Power Ring Max----
    --------------------
    panel.powerBox.maxLength = CreateFrame("Frame", nil, panel.powerBox)
    panel.powerBox.maxLength:SetSize(1, 1)
    panel.powerBox.maxLength:SetPoint("TOPLEFT", 16, -16)
    panel.powerBox.maxLength.text = panel.powerBox.maxLength:CreateFontString(nil, nil, "GameFontWhite")
    panel.powerBox.maxLength.text:SetText("Maximum length")
    panel.powerBox.maxLength.text:SetPoint("LEFT", 0, 0)

    panel.powerBox.maxLength.inputBox =
        KH_UI:Create_InputBox(
        KH_UI_Settings[panel.name].manaLengthMax,
        panel.powerBox.maxLength,
        "Left",
        0,
        -16,
        112,
        function()
            local max = panel.powerBox.maxLength.inputBox:GetNumber()
            if max < 1 then
                max = 1
            end
            KH_UI_Settings[panel.name].manaLengthMax = max
            if (type == "player" or type == "target") then
                frame.Update_Health()
                frame.Update_Power()
            elseif (type == "party") then
                for i in pairs(frame) do
                    frame[i].Update_Health()
                    frame[i].Update_Power()
                end
            end
            panel.powerBox.maxLength.inputBox:SetText(KH_UI_Settings[panel.name].manaLengthMax)
        end
    )
    panel.powerBox.maxLength.tooltip = CreateFrame("Button", nil, panel.powerBox, "UIPanelGoldButtonTemplate")
    panel.powerBox.maxLength.tooltip:SetAlpha(0)
    panel.powerBox.maxLength.tooltip.tooltipText = "Sets how long in total the power bar can be. (In maximum power)"
    panel.powerBox.maxLength.tooltip:SetSize(136, 12)
    panel.powerBox.maxLength.tooltip:SetPoint("TOPLEFT", panel.powerBox, "TOPLEFT", 0, -12)
    GameTooltip_AddNewbieTip(panel.powerBox.maxLength.tooltip, panel.powerBox.maxLength.tooltip.tooltipText, 1.0, 1.0, 0)
    GameTooltip:Hide()
    -----------------
    --PP Bar Growth--
    -----------------
    panel.powerBox.barGrowth = CreateFrame("Frame", nil, panel.powerBox)
    panel.powerBox.barGrowth:SetSize(1, 1)
    panel.powerBox.barGrowth:SetPoint("TOPRight", -16, -16)
    panel.powerBox.barGrowth.text = panel.powerBox.barGrowth:CreateFontString(nil, nil, "GameFontWhite")
    panel.powerBox.barGrowth.text:SetText("Bar Growth")
    panel.powerBox.barGrowth.text:SetPoint("Right", 0, 0)

    panel.powerBox.barGrowth.inputBox =
        KH_UI:Create_InputBox(
        KH_UI_Settings[panel.name].manaLengthRate,
        panel.powerBox.barGrowth,
        "Right",
        0,
        -16,
        112,
        function()
            local max = panel.powerBox.barGrowth.inputBox:GetNumber()
            if max < 1 then
                max = 1
            end
            KH_UI_Settings[panel.name].manaLengthRate = max
            if (type == "player" or type == "target") then
                frame.Update_Power()
            elseif (type == "party") then
                for i in pairs(frame) do
                    frame[i].Update_Power()
                end
            end
            panel.powerBox.barGrowth.inputBox:SetText(KH_UI_Settings[panel.name].manaLengthRate)
        end
    )
    panel.powerBox.barGrowth.tooltip =
        CreateFrame("Button", nil, panel.powerBox.barGrowth, "UIPanelGoldButtonTemplate")
    panel.powerBox.barGrowth.tooltip:SetAlpha(0)
    panel.powerBox.barGrowth.tooltip.tooltipText =
        "Sets the rate at which the bar will extend. (5000 = 5 pixels every 1 PP, 1000 = 1 pixel every 1 PP, 200 = 1 pixel every 5 PP)"
    panel.powerBox.barGrowth.tooltip:SetSize(136, 12)
    panel.powerBox.barGrowth.tooltip:SetPoint("TOPRight", panel.powerBox, "TOPRight", -12, -8)
    GameTooltip_AddNewbieTip(
        panel.powerBox.barGrowth.tooltip,
        panel.powerBox.barGrowth.tooltip.tooltipText,
        1.0,
        1.0,
        1.0
    )
    GameTooltip:Hide()
    --------------------------
    --Display Value Checkbox--
    --------------------------
    panel.powerBox.displayPowerCheck = KH_UI:createCheckbutton(panel.powerBox.maxLength, -4, -32, "Display Power Value")
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
end