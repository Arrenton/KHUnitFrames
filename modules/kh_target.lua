local HEALTH_COLOR = {
    [1] = {
        r = 0.0,
        g = 1.0,
        b = 0.0
    },
    [2] = {
        r = 0.0,
        g = 0.7,
        b = 1.0
    },
    [3] = {
        r = 1.0,
        g = 1.0,
        b = 0.0
    },
    [4] = {
        r = 1.0,
        g = 0.5,
        b = 0.1
    },
    [5] = {
        r = 1.0,
        g = 0.2,
        b = 0.2
    },
    [6] = {
        r = 1.0,
        g = 0.4,
        b = 1.0
    }
}
local PowerBarColor = {
    ["MANA"] = {
        r = 0.0,
        g = 0.50,
        b = 1
    },
    ["ENERGY"] = {
        r = 1,
        g = 0.86,
        b = 0.0
    },
    ["RAGE"] = {
        r = 0.85,
        g = 0.0,
        b = 0.0
    },
    ["FOCUS"] = {
        r = 0.84,
        g = 0.29,
        b = 0.16
    }
}
local function create_bars(mainFrame)
    mainFrame.healthFrame.bg = KH_UI:CreateColorFrame(71 + 25, 37, mainFrame.healthFrame, "TOPLEFT", -6, 6, 0, {r = 1, g = 1, b = 1, a = 0.1})
    mainFrame.healthFrame.base = KH_UI:CreateImageFrame(65, 25, mainFrame.healthFrame, "TOPLEFT", 0, 0, 1, {x = 1 / 128, xw = 66 / 128, y = 1 / 64, yh = 25.8 / 64}, "Interface\\AddOns\\KHUnitframes\\textures\\KH_Target\\targetTex")
    mainFrame.healthFrame.healthBg = KH_UI:CreateColorFrame(13, 25, mainFrame.healthFrame.base, "TOPLEFT", 71, 0, 1, {r = 0, g = 0, b = 0, a = 1})
    mainFrame.healthFrame.health =
        KH_UI:CreateImageFrame(1, 14, mainFrame.healthFrame.healthBg, "TOPLEFT", 6, -6, 3, {x = 72.5 / 128, xw = 73.5 / 128, y = 7 / 64, yh = 21 / 64}, "Interface\\AddOns\\KHUnitframes\\textures\\KH_Target\\targetTex")
    mainFrame.healthFrame.healthEdge = KH_UI:CreateColorFrame(3, 14, mainFrame.healthFrame.health, "TOPRIGHT", 3, 0, 4, {r = 0, g = 0, b = 0, a = 1})
    mainFrame.healthFrame.healthExtra =
        KH_UI:CreateImageFrame(1, 14, mainFrame.healthFrame.healthBg, "TOPLEFT", 6, -6, 2, {x = 72.5 / 128, xw = 73.5 / 128, y = 7 / 64, yh = 21 / 64}, "Interface\\AddOns\\KHUnitframes\\textures\\KH_Target\\targetTex")
    --Power
    mainFrame.powerFrame:ClearAllPoints()
    mainFrame.powerFrame:SetPoint("TOPLEFT", mainFrame.healthFrame, "BOTTOMLEFT", 0, 2)
    mainFrame.powerFrame.base = KH_UI:CreateImageFrame(65, 10, mainFrame.powerFrame, "TOPLEFT", 0, 0, 2, {x = 1 / 128, xw = 66 / 128, y = 30 / 64, yh = 41 / 64}, "Interface\\AddOns\\KHUnitframes\\textures\\KH_Target\\targetTex")
    mainFrame.powerFrame.powerBg = KH_UI:CreateColorFrame(13, 13, mainFrame.powerFrame.base, "TOPLEFT", 71, 3, 1, {r = 0, g = 0, b = 0, a = 1})
    mainFrame.powerFrame.power = KH_UI:CreateImageFrame(1, 7, mainFrame.powerFrame.powerBg, "TOPLEFT", 6, -3, 3, {x = 72.5 / 128, xw = 73.5 / 128, y = 7 / 64, yh = 21 / 64}, "Interface\\AddOns\\KHUnitframes\\textures\\KH_Target\\targetTex")

    mainFrame.healthFrame.health.texture:SetVertexColor(HEALTH_COLOR[1].r, HEALTH_COLOR[1].g, HEALTH_COLOR[1].b)
end

local function create_infoFrames(mainFrame)
    mainFrame.nameFrame = KH_UI:CreateTextFrame("*NAME*", 0, 24, 1, 1, 0.75, "TOPLeft", mainFrame, "TOPLEFT", 4, "SystemFont_OutlineThick_Huge2")
    mainFrame.levelFrame = KH_UI:CreateTextFrame("??", -6, -2, 1, 1, 0.75, "RIGHT", mainFrame, "LEFT", 4, "SystemFont_OutlineThick_Huge2")
    mainFrame.classificationFrame = KH_UI:CreateTextFrame("Rare\nElite", -32, -24, 1, 1, 0.5, "TOP", mainFrame.levelFrame, "BOTTOMLEFT", 4, "SystemFont_OutlineThick_Huge2")
    mainFrame.levelFrame.skull = KH_UI:CreateImageFrame(32, 32, mainFrame.levelFrame, "CENTER", -16, 3, 1, {x = 0, xw = 1, y = 0, yh = 1}, "Interface\\TargetingFrame\\UI-TargetingFrame-Skull")
    mainFrame.powerFrame.powerVal = KH_UI:CreateTextFrame("???/???", 6, -2, 1, 1, 0.4, "LEFT", mainFrame.powerFrame.powerBg, "BOTTOMLEFT", 4, "SystemFont_OutlineThick_Huge2")
    mainFrame.healthFrame.healthVal = KH_UI:CreateTextFrame("???/???", 6, 16, 1, 1, 0.4, "LEFT", mainFrame.healthFrame.healthBg, "BOTTOMLEFT", 4, "SystemFont_OutlineThick_Huge2")
    mainFrame.factionPvPFrame = KH_UI:CreateImageFrame(48, 48, mainFrame.levelFrame, "CENTER", -4, 22, 1, {x = 0, xw = 1, y = 0, yh = 1}, "Interface\\TargetingFrame\\UI-PVP-FFA")
    mainFrame.factionPvPFrame:Hide()
    mainFrame.factionPvPFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
    mainFrame.factionPvPFrame:RegisterEvent("UNIT_FLAGS")
    mainFrame.factionPvPFrame:SetScript(
        "OnEvent",
        function(self)
            local factionGroup = UnitFactionGroup(mainFrame.unit)
            if (UnitIsPVPFreeForAll(mainFrame.unit)) then
                self.texture:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA")
                self:Show()
            elseif (factionGroup and factionGroup ~= "Neutral" and UnitIsPVP(mainFrame.unit)) then
                self.texture:SetTexture("Interface\\TargetingFrame\\UI-PVP-" .. factionGroup)
                self:Show()
            else
                self:Hide()
            end
        end
    )
end

function KH_UI:New_KHTargetUnitframe(unit, setting)
    local f = CreateFrame("Button", "KH_UI " .. unit, UIParent, "SecureUnitButtonTemplate")
    f.settings = setting
    f.unit = unit
    f.offsety = 0
    f.posx, f.posy = 0, 0
    if (f.settings == "Player Frame" or f.settings == "Target Frame") then
        f.posx, f.posy = KH_UI_Settings[f.settings].framex, KH_UI_Settings[f.settings].framey
    elseif (f.settings == "Party Frame") then
        f.posx, f.posy = KH_UI_Settings[f.settings].individualSettings[unit].framex, KH_UI_Settings[f.settings].individualSettings[unit].framey
    end
    f.width = 65
    f.height = 25
    f.unitHealthMax = 1
    f.unitPowerMax = 1
    f.unitMana = 1
    f.unitManaMax = 1
    f.unitHealth = 1
    f.scale = KH_UI_Settings[f.settings].scale
    if (f.settings == "Party Frame") then
        f.scale = f.scale / 2
    end
    if (f.unit == "targettarget") then
        f.scale = f.scale / 2
    end
    f.healthMaxMult = 1
    f.powerMaxMult = 1

    f.CheckLevel = function(self)
        local targetEffectiveLevel = UnitLevel(self.unit)
        local classification = UnitClassification(self.unit);
        if (classification == "worldboss") then
            self.classificationFrame.text:SetText("|cffff1010Boss")
        elseif (classification == "rareelite") then
            self.classificationFrame.text:SetText("|cffc5c2c2Rare\n|cffffbe00Elite")
        elseif (classification == "elite") then
            self.classificationFrame.text:SetText("|cffffbe00Elite")
        elseif (classification == "rare") then
            self.classificationFrame.text:SetText("|cffc5c2c2Rare")
        else
            self.classificationFrame.text:SetText(" ")
        end
        if (UnitIsCorpse(self.unit)) then
            self.levelFrame.text:Hide()
            self.levelFrame.skull:Show()
        elseif (targetEffectiveLevel > 0) then
            -- Normal level target
            self.levelFrame.text:SetText(targetEffectiveLevel)
            -- Color level number
            if (UnitCanAttack("player", self.unit)) then
                local color = GetCreatureDifficultyColor(targetEffectiveLevel)
                self.levelFrame.text:SetVertexColor(color.r, color.g, color.b)
            else
                self.levelFrame.text:SetVertexColor(1.0, 0.82, 0.0)
            end

            self.levelFrame.text:Show()
            self.levelFrame.skull:Hide()
        else
            -- Target is too high level to tell
            self.levelFrame.text:Hide()
            self.levelFrame.skull:Show()
        end
    end

    f.Update_FrameInfo = function()
        f.scale = KH_UI_Settings[f.settings].scale
        if (f.settings == "Party Frame") then
            f.scale = f.scale / 2
        end
        if (f.unit == "targettarget") then
            f.scale = f.scale / 2
        end
        f:SetScale(f.scale)
        f:SetMovable(KH_UI_Settings[f.settings].movable)
        f.nameFrame.text:SetText(UnitName(f.unit))
        if (KH_UI_Settings[f.settings].movable) then
            f:RegisterForDrag("LeftButton")
        else
            f:RegisterForDrag(nil)
        end
        f.Update_Health()
        f.Update_Power()
    end

    f.Update_Health = function()
        local unitHPMax, unitCurrHP, unitLevel
        unitCurrHP = UnitHealth(f.unit)
        unitHPMax = UnitHealthMax(f.unit)
        f.unitHPPercent = unitCurrHP / unitHPMax
        f.unitHealth = unitCurrHP
        f.unitHealthMax = unitHPMax
        if f.unitHealthMax > KH_UI_Settings[f.settings].healthLengthMax * min(KH_UI_Settings[f.settings].maxBars, 6) then
            f.healthMaxMult = (KH_UI_Settings[f.settings].healthLengthMax * min(KH_UI_Settings[f.settings].maxBars, 6)) / f.unitHealthMax
        else
            f.healthMaxMult = 1
        end
        if (KH_UI_Settings[f.settings].displayHealthValue) then
            f.healthFrame.healthVal.text:SetText(unitCurrHP .. " / " .. unitHPMax)
            if not (f.healthFrame.healthVal:IsVisible()) then
                f.healthFrame.healthVal:Show()
            end
        else
            f.healthFrame.healthVal:Hide()
        end
        unitCurrHP = unitCurrHP * f.healthMaxMult
        unitHPMax = unitHPMax * f.healthMaxMult
        local extraBars = math.floor(unitCurrHP / (KH_UI_Settings[f.settings].healthLengthMax + 1))
        local extraMaxBars = math.floor(unitHPMax / (KH_UI_Settings[f.settings].healthLengthMax + 1))
        if (extraMaxBars > 0) then
            local width = math.ceil((KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000) * KH_UI_Settings[f.settings].healthLengthMax)
            f.healthFrame.healthExtra:SetWidth(width)
            f.healthFrame.bg:SetWidth(95 + width)
            f.healthFrame.healthBg:SetWidth(width + 12)
        else
            local width = math.ceil(unitHPMax * (KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000))
            local powerWidth = f.powerFrame.powerBg:GetWidth()
            if (width >= powerWidth or not f.powerFrame:IsShown()) then
                f.healthFrame.bg:SetWidth(95 + width)
            elseif (width < powerWidth) then
                f.healthFrame.bg:SetWidth(83 + powerWidth)
            end
            f.healthFrame.healthBg:SetWidth(width + 12)
        end
        if (unitCurrHP > 0) then
            local tempHP = unitCurrHP - extraBars * KH_UI_Settings[f.settings].healthLengthMax
            local width = math.ceil(tempHP * (KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000))
            --Limit Length
            if (width > math.ceil((KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000) * KH_UI_Settings[f.settings].healthLengthMax)) then
                width = math.ceil((KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000) * KH_UI_Settings[f.settings].healthLengthMax)
            end
            f.healthFrame.health.texture:SetVertexColor(HEALTH_COLOR[extraBars + 1].r, HEALTH_COLOR[extraBars + 1].g, HEALTH_COLOR[extraBars + 1].b)
            f.healthFrame.health:SetWidth(width)
            if (extraBars > 0) then
                f.healthFrame.healthExtra.texture:SetVertexColor(HEALTH_COLOR[extraBars].r, HEALTH_COLOR[extraBars].g, HEALTH_COLOR[extraBars].b)
                if not (f.healthFrame.healthExtra:IsVisible()) then
                    f.healthFrame.healthExtra:Show()
                end
            else
                f.healthFrame.healthExtra:Hide()
            end
        else
            f.healthFrame.health:SetWidth(0.0001)
            f.healthFrame.healthExtra:Hide()
        end
    end

    f.Update_Power = function()
        local powerType, powerToken, altR, altG, altB = UnitPowerType(f.unit)
        local power = UnitPower(f.unit, powerType)
        local powerMax = UnitPowerMax(f.unit, powerType)
        local info, r, g, b = PowerBarColor[powerToken], 0, 0, 0

        if (info) then
            --The PowerBarColor takes priority
            r, g, b = info.r, info.g, info.b
        elseif (not altR) then
            -- Couldn't find a power token entry. Default to indexing by power type or just mana if  we don't have that either.
            info = PowerBarColor[powerType] or PowerBarColor["MANA"]
            r, g, b = info.r, info.g, info.b
        else
            r, g, b = altR, altG, altB
        end

        if powerMax > KH_UI_Settings[f.settings].manaLengthMax then
            f.powerMaxMult = 1 / (powerMax / KH_UI_Settings[f.settings].manaLengthMax)
        else
            f.powerMaxMult = 1
        end

        if (powerMax > 1) then
            if not (f.powerFrame:IsVisible()) then
                f.powerFrame:Show()
            end
            if (powerToken == "MANA") then
                if (power > 0) then
                    f.powerFrame.power:SetWidth(math.ceil(power * (KH_UI_Settings[f.settings].manaLengthRate / 1000) * f.powerMaxMult))
                else
                    f.powerFrame.power:SetWidth(0.0001)
                end
                f.powerFrame.powerBg:SetWidth(math.ceil(powerMax * (KH_UI_Settings[f.settings].manaLengthRate / 1000) * f.powerMaxMult) + 12)
            else
                if (power > 0) then
                    f.powerFrame.power:SetWidth(math.ceil(power * 20 * (KH_UI_Settings[f.settings].manaLengthRate / 1000)))
                else
                    f.powerFrame.power:SetWidth(0.0001)
                end
                f.powerFrame.powerBg:SetWidth(math.ceil(powerMax * 20 * (KH_UI_Settings[f.settings].manaLengthRate / 1000)) + 12)
            end
            if (KH_UI_Settings[f.settings].displayPowerValue) then
                f.powerFrame.powerVal.text:SetText(power .. " / " .. powerMax)
                if not (f.powerFrame:IsVisible()) then
                    f.powerFrame.powerVal:Show()
                end
            else
                f.powerFrame.powerVal:Hide()
            end
            local healthWidth = f.healthFrame.healthBg:GetWidth()
            local powerWidth = f.powerFrame.powerBg:GetWidth()
            if (healthWidth >= powerWidth or not f.powerFrame:IsShown()) then
                f.healthFrame.bg:SetWidth(83 + healthWidth)
            elseif (healthWidth < powerWidth) then
                f.healthFrame.bg:SetWidth(83 + powerWidth)
            end
            f.powerFrame.power.texture:SetVertexColor(r, g, b, 1)
            f.powerFrame.base.texture:SetVertexColor(r, g, b, 1)
        else
            f.powerFrame:Hide()
        end
        f.unitPower = power
        f.UnitPowerMax = powerMax
    end

    f:EnableMouse(true)
    f:SetClampedToScreen(true)
    f:RegisterForClicks("AnyUp")
    f:SetMovable(KH_UI_Settings[f.settings].movable)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript(
        "OnDragStop",
        function()
            local _, _, _, xOfs, yOfs = f:GetPoint(1)
            f:ClearAllPoints()
            f.posx = xOfs
            f.posy = yOfs
            if (f.settings == "Player Frame" or f.settings == "Target Frame") then
                KH_UI_Settings[f.settings].framex = f.posx
                KH_UI_Settings[f.settings].framey = f.posy
            elseif (f.settings == "Party Frame") then
                KH_UI_Settings[f.settings].individualSettings[f.unit].framex = f.posx
                KH_UI_Settings[f.settings].individualSettings[f.unit].framey = f.posy
            end
            f:StopMovingOrSizing()
            f:SetPoint("TopLeft", f.posx, f.posy)
        end
    )

    local menuFunc = TargetFrameDropDown_Initialize

    if f.unit == "player" then
        menuFunc = function()
            ToggleDropDownMenu(1, nil, PlayerFrameDropDown, f, 106, 27)
        end
    elseif f.unit == "target" then
        menuFunc = function()
            ToggleDropDownMenu(1, nil, _G["TargetFrameDropDown"], f, 106, 27)
        end
    elseif (f.settings == "Party Frame") then
        local id = 1
        if f.unit == "party2" then
            id = 2
        elseif f.unit == "party3" then
            id = 3
        elseif f.unit == "party4" then
            id = 4
        end
        menuFunc = function()
            ToggleDropDownMenu(1, nil, _G["PartyMemberFrame" .. id .. "DropDown"], f, 47, 45)
        end
    end
    SecureUnitButton_OnLoad(f, f.unit, menuFunc)
    f:SetScript("OnEnter", UnitFrame_OnEnter)
    f:SetScript("OnLeave", UnitFrame_OnLeave)

    f.healthFrame = CreateFrame("Frame", nil, f)
    f.powerFrame = CreateFrame("Frame", nil, f)
    f:SetWidth(f.width)
    f:SetHeight(f.height)
    f:SetScale(f.scale)
    f.healthFrame:SetWidth(f.width)
    f.healthFrame:SetHeight(f.height)
    f.healthFrame:SetPoint("TopLeft", 0, 0)
    f.powerFrame:SetWidth(f.width)
    f.powerFrame:SetHeight(f.height)
    f:ClearAllPoints()
    f:SetPoint("TopLeft", f.posx, f.posy)

    f.powerFrame:SetScript(
        "OnHide",
        function()
            f.healthFrame.bg:SetHeight(37)
            if (UnitExists(f.unit)) then
                f.Update_Health()
            end
        end
    )

    f.powerFrame:SetScript(
        "OnShow",
        function()
            f.healthFrame.bg:SetHeight(45)
        end
    )

    create_bars(f)
    create_infoFrames(f)

    f:RegisterEvent("PLAYER_ENTERING_WORLD")
    if (TargetFrame.showLevel) then
        f:RegisterEvent("UNIT_LEVEL")
    end
    if (TargetFrame.showClassification) then
        f:RegisterEvent("UNIT_CLASSIFICATION_CHANGED")
    end
    if (TargetFrame.showLeader) then
        f:RegisterEvent("PLAYER_FLAGS_CHANGED")
    end
    f:RegisterEvent("UNIT_HEALTH")
    f:RegisterEvent("UNIT_HEALTH")
    f:RegisterEvent("UNIT_POWER_UPDATE")
    f:RegisterEvent("UNIT_MAXPOWER")
    f:RegisterEvent("UNIT_FACTION")
    f:RegisterEvent("PLAYER_TARGET_CHANGED")
    f:RegisterEvent("GROUP_ROSTER_UPDATE")
    f:RegisterEvent("RAID_TARGET_UPDATE")
    f:RegisterUnitEvent("UNIT_AURA", "target")
    RegisterStateDriver(f, "visibility", "[@target,exists] show; hide")

    f:SetScript(
        "OnHide",
        function()
            PlaySound(SOUNDKIT.INTERFACE_SOUND_LOST_TARGET_UNIT)
            CloseDropDownMenus()
        end
    )

    f:SetScript(
        "OnEvent",
        function(self, event, arg1)
            if (KH_UI_Settings["Target Frame"].enabled == true) then
                if (event == "UNIT_HEALTH" and arg1 == self.unit) then
                    self.Update_Health()
                elseif (event == "UNIT_POWER_UPDATE" or event == "UNIT_MAXPOWER" and arg1 == self.unit) then
                    self.Update_Power()
                elseif (event == "PLAYER_TARGET_CHANGED") then
                    -- Moved here to avoid taint from functions below
                    CloseDropDownMenus()
                    if (UnitExists(self.unit)) then
                        self.Update_Health()
                        self.Update_Power()
                        self.CheckLevel(self)
                        self.nameFrame.text:SetText(format(UnitName(self.unit)))
                        if (not UnitPlayerControlled(self.unit) and UnitIsTapDenied(self.unit)) then
                            --self.nameFrame.text:SetVertexColor(0.5, 0.5, 0.5)
                            self.healthFrame.bg.texture:SetVertexColor(0.5, 0.5, 0.5)
                        else
                            --self.nameFrame.text:SetVertexColor(UnitSelectionColor(self.unit))
                            self.healthFrame.bg.texture:SetVertexColor(UnitSelectionColor(self.unit))
                        end
                    end

                    if (UnitExists(self.unit) and not IsReplacingUnit()) then
                        if (UnitIsEnemy(self.unit, "player")) then
                            PlaySound(SOUNDKIT.IG_CREATURE_AGGRO_SELECT)
                        elseif (UnitIsFriend("player", self.unit)) then
                            PlaySound(SOUNDKIT.IG_CHARACTER_NPC_SELECT)
                        else
                            PlaySound(SOUNDKIT.IG_CREATURE_NEUTRAL_SELECT)
                        end
                    end
                elseif (event == "UNIT_AURA") then
                    if (arg1 == self.unit) then
                    end
                end
            end
        end
    )
    return f
end
