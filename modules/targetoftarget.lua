local PowerBarColor = {
    ['MANA'] = {
        r = 0.0,
        g = 0.50,
        b = 1
    },
    ['ENERGY'] = {
        r = 1,
        g = 0.86,
        b = 0.0
    },
    ['RAGE'] = {
        r = 0.85,
        g = 0.0,
        b = 0.0
    },
    ['FOCUS'] = {
        r = 0.84,
        g = 0.29,
        b = 0.16
    },
}
local function create_portrait(mainFrame)
    mainFrame.portrait = CreateFrame("Frame", nil, mainFrame.healthFrame)
    mainFrame.portrait:RegisterUnitEvent("UNIT_PORTRAIT_UPDATE", mainFrame.unit)
    mainFrame.portrait:RegisterEvent("UNIT_LEVEL")
    mainFrame.portrait:RegisterEvent("PLAYER_ENTERING_WORLD")
    mainFrame.portrait:RegisterEvent("PLAYER_TARGET_CHANGED")
    mainFrame.portrait:RegisterEvent("UNIT_FLAGS")
    mainFrame.portrait:RegisterEvent("UNIT_PHASE")
    mainFrame.portrait:RegisterEvent("UNIT_FACTION")
    mainFrame.portrait:RegisterEvent("UNIT_CONNECTION")
    mainFrame.portrait.Texture = mainFrame.portrait:CreateTexture("$parent_Texture", "BACKGROUND")
    mainFrame.portrait.Texture:SetAllPoints()
    SetPortraitTexture(mainFrame.portrait.Texture, mainFrame.unit)
    mainFrame.portrait:SetScript(
        "OnEvent",
        function(self)
            SetPortraitTexture(self.Texture, mainFrame.unit)
            ----PvP Icon----
            local factionGroup = UnitFactionGroup(mainFrame.unit)
            if (UnitIsPVPFreeForAll(mainFrame.unit)) then
                mainFrame.portrait.pvpIcon.texture:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA")
                mainFrame.portrait.pvpIcon:Show()
            elseif (factionGroup and factionGroup ~= "Neutral" and UnitIsPVP(mainFrame.unit)) then
                mainFrame.portrait.pvpIcon.texture:SetTexture("Interface\\TargetingFrame\\UI-PVP-" .. factionGroup)
                mainFrame.portrait.pvpIcon:Show()
            else
                mainFrame.portrait.pvpIcon:Hide()
            end
        end
    )
    mainFrame.portrait:SetSize(56, 56)
    mainFrame.portrait:SetPoint("CENTER", 0, 0)
    mainFrame.portrait:SetFrameLevel(1)

    --------------------
    --PvP Icon----------
    --------------------
    mainFrame.portrait.pvpIcon = CreateFrame("Frame", nil, mainFrame.portrait)
    mainFrame.portrait.pvpIcon:SetSize(64, 64)
    mainFrame.portrait.pvpIcon:SetPoint("TopLeft", -24, -8)
    mainFrame.portrait.pvpIcon.texture = mainFrame.portrait.pvpIcon:CreateTexture(nil, "BACKGROUND")
    mainFrame.portrait.pvpIcon.texture:SetPoint("CENTER", 0, 0)
    mainFrame.portrait.pvpIcon.texture:SetAllPoints()
    mainFrame.portrait.pvpIcon.texture:SetTexture("Interface\\TargetingFrame\\UI-PVP-HORDE")
end

local function CreateBarPretties(mainFrame)
    ---Health Frame
    ---------BASE
    mainFrame.healthFrame.base = CreateFrame("Frame", nil, mainFrame.healthFrame)
    mainFrame.healthFrame.base:SetWidth(29)
    mainFrame.healthFrame.base:SetHeight(14)
    mainFrame.healthFrame.base:SetFrameLevel(3)
    mainFrame.healthFrame.base:SetPoint("TOP", 38, -11)
    mainFrame.healthFrame.base.texture = mainFrame.healthFrame.base:CreateTexture(nil, "BACKGROUND")
    mainFrame.healthFrame.base.texture:SetAllPoints()
    mainFrame.healthFrame.base.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")
    mainFrame.healthFrame.base.texture:SetTexCoord(98 / 128, 127 / 128, 15 / 64, 29 / 64)

    -------Back Bar
    mainFrame.healthFrame.back = CreateFrame("Frame", nil, mainFrame.healthFrame.base)
    mainFrame.healthFrame.back:SetWidth(200)
    mainFrame.healthFrame.back:SetHeight(14)
    mainFrame.healthFrame.back:SetFrameLevel(4)
    mainFrame.healthFrame.back:SetPoint("TOPLEFT", 27, 0)
    mainFrame.healthFrame.back.texture = mainFrame.healthFrame.back:CreateTexture(nil, "BACKGROUND")
    mainFrame.healthFrame.back.texture:SetAllPoints()
    mainFrame.healthFrame.back.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")
    mainFrame.healthFrame.back.texture:SetTexCoord(67.5 / 128, 67.5 / 128, 48 / 64,  64 / 64)

    -------HP Last
    mainFrame.healthFrame.healthLast = CreateFrame("Frame", nil, mainFrame.healthFrame.base)
    mainFrame.healthFrame.healthLast.alpha = 0
    mainFrame.healthFrame.healthLast:SetWidth(200)
    mainFrame.healthFrame.healthLast:SetHeight(10)
    mainFrame.healthFrame.healthLast:SetFrameLevel(5)
    mainFrame.healthFrame.healthLast:SetPoint("TOPLEFT", 27, -2)
    mainFrame.healthFrame.healthLast.texture = mainFrame.healthFrame.healthLast:CreateTexture(nil, "BACKGROUND")
    mainFrame.healthFrame.healthLast.texture:SetAllPoints()
    mainFrame.healthFrame.healthLast.texture:SetTexture(
        "Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame"
    )
    mainFrame.healthFrame.healthLast.texture:SetTexCoord(77.5 / 128, 77.5 / 128, 54 / 64, 64 / 64)

    -------HP
    mainFrame.healthFrame.health = CreateFrame("Frame", nil, mainFrame.healthFrame.base)
    mainFrame.healthFrame.health:SetWidth(200)
    mainFrame.healthFrame.health:SetHeight(10)
    mainFrame.healthFrame.health:SetFrameLevel(6)
    mainFrame.healthFrame.health:SetPoint("TOPLEFT", 27, -2)
    mainFrame.healthFrame.health.texture = mainFrame.healthFrame.health:CreateTexture(nil, "BACKGROUND")
    mainFrame.healthFrame.health.texture:SetAllPoints()
    mainFrame.healthFrame.health.texture:SetTexture(
        "Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame"
    )
    mainFrame.healthFrame.health.texture:SetTexCoord(75.5 / 128, 75.5 / 128, 54 / 64, 64 / 64)

    -------Edge
    mainFrame.healthFrame.edge = CreateFrame("Frame", nil, mainFrame.healthFrame.back)
    mainFrame.healthFrame.edge:SetWidth(2)
    mainFrame.healthFrame.edge:SetHeight(12)
    mainFrame.healthFrame.edge:SetFrameLevel(3)
    mainFrame.healthFrame.edge:SetPoint("TOPRight", 2, -1)
    mainFrame.healthFrame.edge.texture = mainFrame.healthFrame.edge:CreateTexture(nil, "BACKGROUND")
    mainFrame.healthFrame.edge.texture:SetAllPoints()
    mainFrame.healthFrame.edge.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")
    mainFrame.healthFrame.edge.texture:SetTexCoord(69 / 128, 71.75 / 128, 49 / 64, 63 / 64)

    --------------------Name----------------
    mainFrame.nameFrame = CreateFrame("Frame", nil, mainFrame.healthFrame.base)
    mainFrame.nameFrame:SetWidth(27)
    mainFrame.nameFrame:SetHeight(6)
    mainFrame.nameFrame:SetScale(1.5)
    mainFrame.nameFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    mainFrame.nameFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
    mainFrame.nameFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
    mainFrame.nameFrame:RegisterEvent("UNIT_OTHER_PARTY_CHANGED")
    mainFrame.nameFrame:SetScript(
        "OnEvent",
        function(self, event, unit)
            if UnitName(mainFrame.unit) ~= nil then
                mainFrame.nameFrame.text:SetText(format(UnitName(mainFrame.unit)))
            end
        end
    )
    mainFrame.nameFrame:SetPoint("TOP", 8, 8)
    mainFrame.nameFrame:SetFrameLevel(4)
    mainFrame.nameFrame.text = mainFrame.nameFrame:CreateFontString(nil, nil, "GameFontNormal")
    mainFrame.nameFrame.text:SetText(format("NAME"))
    mainFrame.nameFrame.text:SetPoint("left", 0, 0)

    ------------Power Frame

    -------Back Bar
    mainFrame.powerFrame.back = CreateFrame("Frame", nil, mainFrame.powerFrame)
    mainFrame.powerFrame.back:SetWidth(200)
    mainFrame.powerFrame.back:SetHeight(14)
    mainFrame.powerFrame.back:SetFrameLevel(4)
    mainFrame.powerFrame.back:SetPoint("TOPLEFT", 62, -23)
    mainFrame.powerFrame.back.texture = mainFrame.powerFrame.back:CreateTexture(nil, "BACKGROUND")
    mainFrame.powerFrame.back.texture:SetAllPoints()
    mainFrame.powerFrame.back.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")
    mainFrame.powerFrame.back.texture:SetTexCoord(67.5 / 128, 67.5 / 128, 48 / 64,  64 / 64)

    -------PP
    mainFrame.powerFrame.power = CreateFrame("Frame", nil, mainFrame.powerFrame)
    mainFrame.powerFrame.power:SetWidth(200)
    mainFrame.powerFrame.power:SetHeight(10)
    mainFrame.powerFrame.power:SetFrameLevel(6)
    mainFrame.powerFrame.power:SetPoint("TOPLEFT", 62, -25)
    mainFrame.powerFrame.power.texture = mainFrame.powerFrame.power:CreateTexture(nil, "BACKGROUND")
    mainFrame.powerFrame.power.texture:SetAllPoints()
    mainFrame.powerFrame.power.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")
    mainFrame.powerFrame.power.texture:SetTexCoord(79.5 / 128, 79.5 / 128, 54 / 64, 64 / 64)

    -------Edge
    mainFrame.powerFrame.edge = CreateFrame("Frame", nil, mainFrame.powerFrame.back)
    mainFrame.powerFrame.edge:SetWidth(2)
    mainFrame.powerFrame.edge:SetHeight(12)
    mainFrame.powerFrame.edge:SetFrameLevel(3)
    mainFrame.powerFrame.edge:SetPoint("TOPRight", 2, -1)
    mainFrame.powerFrame.edge.texture = mainFrame.powerFrame.edge:CreateTexture(nil, "BACKGROUND")
    mainFrame.powerFrame.edge.texture:SetAllPoints()
    mainFrame.powerFrame.edge.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")
    mainFrame.powerFrame.edge.texture:SetTexCoord(69 / 128, 71.75 / 128, 49 / 64, 63 / 64)
end

local function Update(self, elapsed)
    self.lastUpdate = self.lastUpdate + elapsed

    if self.lastTimer > 0 then
        self.lastTimer = self.lastTimer - elapsed
    end

    if (self.lastUpdate > 0.99) then
        self.lastUpdate = 0.99
    end
    --Independant of FPS
    while (self.lastUpdate > (1 / 144)) do
        self.lastUpdate = self.lastUpdate - 1 / 144
        if self.lastTimer <= 0 and self.healthFrame.healthLast.alpha > 0 then
            self.healthFrame.healthLast.alpha = self.healthFrame.healthLast.alpha - 0.01
            self.healthFrame.healthLast:SetAlpha(self.healthFrame.healthLast.alpha)
        elseif self.healthFrame.healthLast.alpha > 0.7 then
            self.healthFrame.healthLast.alpha = self.healthFrame.healthLast.alpha - 0.006
            self.healthFrame.healthLast:SetAlpha(self.healthFrame.healthLast.alpha)
        end
    end
    --Update Unit
    if (SHOW_TARGET_OF_TARGET == "1" and UnitExists(self.unit)) then
        SetPortraitTexture(self.portrait.Texture, self.unit)
        if UnitName(self.unit) ~= nil then
            self.nameFrame.text:SetText(format(UnitName(self.unit)))
        end
        self.Update_Health()
        self.Update_Power()
    end

    self.healthFrame:ClearAllPoints()
    self.healthFrame:SetPoint("CENTER", 0, self.offsety - 0.5)
    self.powerFrame:ClearAllPoints()
    self.powerFrame:SetPoint("CENTER", 0, self.offsety - 0.5)
end

function KH_UI:New_KH2TargetofTargetUnitframe(unit, setting)
    local f = CreateFrame("Button", "KH_UI " .. unit, UIParent, "SecureUnitButtonTemplate")
    f.settings = setting
    f.unit = unit
    f.offsety = 0
    f.posx, f.posy = 0, 0
    if (f.settings == "Player Frame" or f.settings == "Target Frame" or f.settings == "ToT Frame") then
        f.posx, f.posy = KH_UI_Settings[f.settings].framex, KH_UI_Settings[f.settings].framey
    elseif (f.settings == "Party Frame") then
        f.posx, f.posy =
            KH_UI_Settings[f.settings].individualSettings[unit].framex,
            KH_UI_Settings[f.settings].individualSettings[unit].framey
    end
    f.width = 64
    f.height = 64
    f.unitHealthMax = 1
    f.unitPowerMax = 1
    f.unitMana = 1
    f.unitManaMax = 1
    f.unitHealth = 1
    f.lastHealth = 1
    f.damageHealth = 1
    f.lastTimer = 0
    f.lastUpdate = 0
    f.scale = KH_UI_Settings[f.settings].scale / 2
    f.healthMaxMult = 1

    f.Update_FrameInfo = function()
        f.scale = KH_UI_Settings[f.settings].scale
        if (f.settings == "Party Frame") then
            f.scale = f.scale / 2
        end
        if (f.settings == "ToT Frame") then
            f.scale = f.scale / 2
        end
        f.healthFrame:SetScale(f.scale)
        f.powerFrame:SetScale(f.scale)
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
        local unitHPMax, unitCurrHP
        unitCurrHP = UnitHealth(f.unit)
        unitHPMax = UnitHealthMax(f.unit)
        if f.lastHealth > unitCurrHP then
            f.healthFrame.healthLast.alpha = 1.1
            f.lastTimer = 3
            f.damageHealth = f.lastHealth
        end
        f.lastHealth = unitCurrHP
        f.unitHPPercent = unitCurrHP / unitHPMax
        f.unitHealth = unitCurrHP
        f.unitHealthMax = unitHPMax
        if (UnitIsPlayer(f.unit)) then
            if (f.portrait) then
                if (UnitIsDead(f.unit)) then
                    f.portrait.Texture:SetVertexColor(0.35, 0.35, 0.35, 1.0)
                elseif (UnitIsGhost(f.unit)) then
                    f.portrait.Texture:SetVertexColor(0.2, 0.2, 0.75, 1.0)
                elseif ((f.unitHPPercent > 0) and (f.unitHPPercent <= 0.2)) then
                    f.portrait.Texture:SetVertexColor(1.0, 0.0, 0.0)
                else
                    f.portrait.Texture:SetVertexColor(1.0, 1.0, 1.0, 1.0)
                end
            end
        end
        if f.unitHealthMax > KH_UI_Settings[f.settings].healthLengthMax then
            f.healthMaxMult = 1 / (f.unitHealthMax / KH_UI_Settings[f.settings].healthLengthMax)
        else
            f.healthMaxMult = 1
        end

        if (unitCurrHP > 0) then
            f.healthFrame.health:SetWidth(math.ceil(unitCurrHP / unitHPMax * 100))
        else
            f.healthFrame.health:SetWidth(0.0001)
        end
        if (f.damageHealth > 0) then
            f.healthFrame.healthLast:SetWidth(math.ceil(f.damageHealth / unitHPMax * 100))
        else
            f.healthFrame.health:SetWidth(0.0001)
        end
        f.healthFrame.back:SetWidth(100)
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

        if (powerMax > 1) then
            if not (f.powerFrame:IsVisible()) then
                f.powerFrame:Show()
            end
            if (power > 0) then
                f.powerFrame.power:SetWidth(math.ceil(power / powerMax * 100))
            else
                f.powerFrame.power:SetWidth(0.0001)
            end
            f.powerFrame.back:SetWidth(100)
            f.powerFrame.power.texture:SetVertexColor(r, g, b, 1)
        else
            f.powerFrame:Hide()
        end
        f.unitPower = power
        f.UnitPowerMax = powerMax
    end

    f.Refresh_Points = function()
    end

    f:EnableMouse(true)
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
            if (f.settings == "Player Frame" or f.settings == "Target Frame" or f.settings == "ToT Frame") then
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
    f.healthFrame:SetWidth(f.width)
    f.healthFrame:SetHeight(f.height)
    f.powerFrame:SetWidth(f.width)
    f.powerFrame:SetHeight(f.height)
    f:ClearAllPoints()
    f:SetPoint("TopLeft", f.posx, f.posy)
    f.healthFrame:SetScale(f.scale)
    f.powerFrame:SetScale(f.scale)

    create_portrait(f)
    CreateBarPretties(f)

    f:SetScript("OnUpdate", Update)

    ----Background
    f.healthFrame.bg = CreateFrame("Frame", nil, f.healthFrame)
    f.healthFrame.bg:SetPoint("CENTER", 0, 0)
    f.healthFrame.bg.alpha = 1
    f.healthFrame.bg:SetWidth(62)
    f.healthFrame.bg:SetHeight(62)
    f.healthFrame.bg:SetFrameLevel(0)
    local bgtex = f.healthFrame.bg:CreateTexture(nil, "BACKGROUND")
    bgtex:SetAllPoints()
    bgtex:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")
    bgtex:SetTexCoord(0 / 128, 62 / 128, 0 / 64, 62 / 64)

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
	if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
		f:RegisterEvent("UNIT_HEALTH")
	else
		f:RegisterEvent("UNIT_HEALTH_FREQUENT")
	end
    f:RegisterEvent("UNIT_POWER_UPDATE")
    f:RegisterEvent("UNIT_MAXPOWER")
    f:RegisterEvent("UNIT_FACTION")
    f:RegisterEvent("UNIT_TARGET")
    f:RegisterEvent("PLAYER_TARGET_CHANGED")
    f:RegisterEvent("GROUP_ROSTER_UPDATE")
    f:RegisterEvent("RAID_TARGET_UPDATE")
    f:RegisterUnitEvent("UNIT_AURA", "target")

    RegisterStateDriver(f, "visibility", "[@targettarget,exists] show; hide")

    f:SetScript(
        "OnEvent",
        function(self, event, arg1)
            if (event == "UNIT_HEALTH" or event == "UNIT_HEALTH_FREQUENT" and arg1 == self.unit) then
                self.Update_Health()
            end
            if (event == "UNIT_POWER_UPDATE" or event == "UNIT_MAXPOWER" and arg1 == self.unit) then
                self.Update_Power()
            end
            if (event == "PLAYER_TARGET_CHANGED") then
                -- Moved here to avoid taint from functions below
                self.damageHealth = 1
                self.lastHealth = 1
                self.healthFrame.healthLast.alpha = 0
                if (UnitExists(self.unit)) then
                    self.Update_Health()
                    self.Update_Power()
                end
            end
        end
    )
    return f
end
