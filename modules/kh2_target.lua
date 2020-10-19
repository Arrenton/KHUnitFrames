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
            --mainFrame.Update_FrameInfo()
            if (UnitIsGroupLeader(mainFrame.unit)) then
                mainFrame.portrait.leaderFrame:Show()
            else
                mainFrame.portrait.leaderFrame:Hide()
            end
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
            --------Master Loot----------
            local lootMethod, lootMaster = GetLootMethod()
            if (lootMaster == 0 and IsInGroup()) then
                mainFrame.portrait.masterLootFrame:Show()
            else
                mainFrame.portrait.masterLootFrame:Hide()
            end
            --[[local icon = _G[frame:GetName().."RoleIcon"];
	  if (icon:IsVisible()) then
	    mainFrame.portrait.roleFrame:Show();
	  else
	    mainFrame.portrait.roleFrame:Hide();
	  end
	  local role = UnitGroupRolesAssigned(mainFrame.unit);
	  if ( role == "TANK" or role == "HEALER" or role == "DAMAGER") then
	    mainFrame.portrait.roleFrame.texture:SetTexCoord(GetTexCoordsForRoleSmallCircle(role));
	  end]]
            --
        end
    )
    mainFrame.portrait:SetSize(56, 56)
    mainFrame.portrait:SetPoint("CENTER", 0, 0)
    mainFrame.portrait:SetFrameLevel(1)
    -------------------
    --Level------------
    -------------------
    mainFrame.portrait.levelFrame = CreateFrame("Frame", nil, mainFrame.portrait)
    mainFrame.portrait.levelFrame:SetSize(24, 24)
    mainFrame.portrait.levelFrame:SetPoint("BottomLeft", -4, -4)
    mainFrame.portrait.levelFrame.texture = mainFrame.portrait.levelFrame:CreateTexture(nil, "BACKGROUND")
    mainFrame.portrait.levelFrame.texture:SetPoint("CENTER", 16, 16)
    mainFrame.portrait.levelFrame.texture:SetAllPoints()
    mainFrame.portrait.levelFrame.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\levelRing")
    mainFrame.portrait.levelFrame.skull = CreateFrame("Frame", nil, mainFrame.portrait.levelFrame)
    mainFrame.portrait.levelFrame.skull:SetSize(16, 16)
    mainFrame.portrait.levelFrame.skull:SetPoint("BottomLeft", 4, 4)
    mainFrame.portrait.levelFrame.skull.texture = mainFrame.portrait.levelFrame.skull:CreateTexture(nil, "BACKGROUND")
    mainFrame.portrait.levelFrame.skull.texture:SetPoint("CENTER", 16, 16)
    mainFrame.portrait.levelFrame.skull.texture:SetAllPoints()
    mainFrame.portrait.levelFrame.skull.texture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Skull")
    mainFrame.portrait.levelFrame.text = mainFrame.portrait.levelFrame:CreateFontString(nil, nil, "GameNormalNumberFont")
    mainFrame.portrait.levelFrame.text:SetText("??")
    mainFrame.portrait.levelFrame.text:SetVertexColor(1.0, 0.82, 0.0, 1.0)
    mainFrame.portrait.levelFrame.text:SetPoint("Center", 0, 0)
    mainFrame.portrait.levelFrame:SetScript(
        "OnEvent",
        function()
            mainFrame.CheckLevel(mainFrame)
        end
    )
    mainFrame.portrait.levelFrame:RegisterEvent("UNIT_LEVEL")
    mainFrame.portrait.levelFrame:RegisterEvent("UNIT_HEALTH")
    mainFrame.portrait.levelFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
    mainFrame.portrait.levelFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    --------------------
    --Party Leader------
    --------------------
    mainFrame.portrait.leaderFrame = CreateFrame("Frame", nil, mainFrame.portrait)
    mainFrame.portrait.leaderFrame:SetSize(16, 16)
    mainFrame.portrait.leaderFrame:SetPoint("TopLeft", 0, 0)
    mainFrame.portrait.leaderFrame.texture = mainFrame.portrait.leaderFrame:CreateTexture(nil, "BACKGROUND")
    mainFrame.portrait.leaderFrame.texture:SetPoint("CENTER", 24, 24)
    mainFrame.portrait.leaderFrame.texture:SetAllPoints()
    mainFrame.portrait.leaderFrame.texture:SetTexture("Interface\\GROUPFRAME\\UI-Group-LeaderIcon")
    --------------------
    --Master Loot------
    --------------------
    mainFrame.portrait.masterLootFrame = CreateFrame("Frame", nil, mainFrame.portrait)
    mainFrame.portrait.masterLootFrame:SetSize(24, 24)
    mainFrame.portrait.masterLootFrame:SetPoint("TopLeft", 64, -6)
    mainFrame.portrait.masterLootFrame.texture = mainFrame.portrait.masterLootFrame:CreateTexture(nil, "BACKGROUND")
    mainFrame.portrait.masterLootFrame.texture:SetPoint("CENTER", 16, 16)
    mainFrame.portrait.masterLootFrame.texture:SetAllPoints()
    mainFrame.portrait.masterLootFrame.texture:SetTexture("Interface\\GroupFrame\\UI-Group-MasterLooter")

    --------------------
    --PvP Icon----------
    --------------------
    mainFrame.portrait.pvpIcon = CreateFrame("Frame", nil, mainFrame.portrait)
    mainFrame.portrait.pvpIcon:SetSize(42, 42)
    mainFrame.portrait.pvpIcon:SetPoint("TopLeft", -14, -12)
    mainFrame.portrait.pvpIcon.texture = mainFrame.portrait.pvpIcon:CreateTexture(nil, "BACKGROUND")
    mainFrame.portrait.pvpIcon.texture:SetPoint("CENTER", 0, 0)
    mainFrame.portrait.pvpIcon.texture:SetAllPoints()
    mainFrame.portrait.pvpIcon.texture:SetTexture("Interface\\TargetingFrame\\UI-PVP-HORDE")

    --[[------------------
	--Role--------------
	--------------------
	mainFrame.portrait.roleFrame = CreateFrame("Frame",nil,mainFrame.portrait)
	mainFrame.portrait.roleFrame:SetSize(32,32)
	mainFrame.portrait.roleFrame:SetPoint("TopLeft",0,0);
	mainFrame.portrait.roleFrame.texture = mainFrame.portrait.roleFrame:CreateTexture(nil, "BACKGROUND")
	mainFrame.portrait.roleFrame.texture:SetPoint("CENTER",32,32)
	mainFrame.portrait.roleFrame.texture:SetAllPoints()
	mainFrame.portrait.roleFrame.texture:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES")
  ]]
    --
end

local function CreateBarPretties(mainFrame)
    ---Health Frame
    ---------BASE
    mainFrame.healthFrame.base = KH_UI:CreateImageFrame(29, 14, mainFrame.healthFrame, "TOP", 38, -11, 3, {x = 98 / 128, xw = 127 / 128, y = 15 / 64, yh = 29 / 64}, "Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")

    -------Back Bar
    mainFrame.healthFrame.back =
        KH_UI:CreateImageFrame(200, 16, mainFrame.healthFrame.base, "TOPLEFT", 27, 1, 7, {x = 67.5 / 128, xw = 67.5 / 128, y = 48 / 64, yh = 64 / 64}, "Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")

    -------HP Last
    mainFrame.healthFrame.healthLast =
        KH_UI:CreateImageFrame(200, 10, mainFrame.healthFrame.base, "TOPLEFT", 27, -2, 8, {x = 77.5 / 128, xw = 77.5 / 128, y = 54 / 64, yh = 64 / 64}, "Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")
    mainFrame.healthFrame.healthLast.alpha = 0
    mainFrame.healthFrame.healthLast:SetAlpha(0)
    -------HP
    mainFrame.healthFrame.health =
        KH_UI:CreateImageFrame(200, 10, mainFrame.healthFrame.base, "TOPLEFT", 27, -2, 9, {x = 75.5 / 128, xw = 75.5 / 128, y = 54 / 64, yh = 64 / 64}, "Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")

    -------Edge
    mainFrame.healthFrame.edge =
        KH_UI:CreateImageFrame(3, 14, mainFrame.healthFrame.back, "TOPRight", 3, -1, 7, {x = 69 / 128, xw = 71.75 / 128, y = 49 / 64, yh = 63 / 64}, "Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")

    ------Extra bar
    mainFrame.healthFrame.extra = CreateFrame("Frame", nil, mainFrame.healthFrame.base)
    mainFrame.healthFrame.extra:SetSize(1, 1)
    mainFrame.healthFrame.extra:SetPoint("TOPLEFT", 0, 0)
    mainFrame.healthFrame.extra:SetAlpha(0.25)
    mainFrame.healthFrame.extra:Hide()

    -------Back Bar
    mainFrame.healthFrame.backExtra =
        KH_UI:CreateImageFrame(200, 16, mainFrame.healthFrame.extra, "TOPLEFT", 27, 1, 4, {x = 67.5 / 128, xw = 67.5 / 128, y = 48 / 64, yh = 64 / 64}, "Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")

    -------HP
    mainFrame.healthFrame.healthExtra =
        KH_UI:CreateImageFrame(200, 10, mainFrame.healthFrame.extra, "TOPLEFT", 27, -2, 6, {x = 75.5 / 128, xw = 75.5 / 128, y = 54 / 64, yh = 64 / 64}, "Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")

    -------Edge
    mainFrame.healthFrame.edgeExtra =
        KH_UI:CreateImageFrame(3, 14, mainFrame.healthFrame.backExtra, "TOPRight", 3, -1, 3, {x = 69 / 128, xw = 71.75 / 128, y = 49 / 64, yh = 63 / 64}, "Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")

    -------Bar Blobs
    mainFrame.healthFrame.blobFrame = CreateFrame("Frame", nil, mainFrame.healthFrame.base)
    mainFrame.healthFrame.blobFrame:SetSize(1, 1)
    mainFrame.healthFrame.blobFrame:SetPoint("TOPLEFT", 0, 0)
    mainFrame.healthFrame.blobFrame.full = {x = 63 / 128, xw = 81 / 128, y = 28.35 / 64, yh = 38 / 64}
    mainFrame.healthFrame.blobFrame.damaged = {x = 63 / 128, xw = 81 / 128, y = 17.35 / 64, yh = 27 / 64}
    mainFrame.healthFrame.blobFrame.empty = {x = 76 / 128, xw = 94 / 128, y = 39.35 / 64, yh = 49 / 64}
    mainFrame.healthFrame.blobFrame:Hide()
    mainFrame.healthFrame.blob = {}
    mainFrame.healthFrame.blob[1] =
        KH_UI:CreateImageFrame(23, 15, mainFrame.healthFrame.blobFrame, "TOPLEFT", 6, -12, 9, {x = 63 / 128, xw = 86 / 128, y = 1 / 64, yh = 16 / 64}, "Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")
    mainFrame.healthFrame.blob[1].inside = KH_UI:CreateImageFrame(18, 10, mainFrame.healthFrame.blob[1], "TOPLEFT", 2, -2, 10, mainFrame.healthFrame.blobFrame.full, "Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")
    for i = 2, 100 do
        mainFrame.healthFrame.blob[i] =
            KH_UI:CreateImageFrame(23, 15, mainFrame.healthFrame.blob[i - 1], "TOPLEFT", 20, 0, 9+i*0.05, {x = 63 / 128, xw = 86 / 128, y = 1 / 64, yh = 16 / 64}, "Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")
        mainFrame.healthFrame.blob[i].inside = KH_UI:CreateImageFrame(18, 10, mainFrame.healthFrame.blob[i], "TOPLEFT", 2, -2, 10, mainFrame.healthFrame.blobFrame.full, "Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")
    end
    --------------------Name----------------
    mainFrame.nameFrame = CreateFrame("Frame", nil, mainFrame.healthFrame.base)
    mainFrame.nameFrame:SetWidth(27)
    mainFrame.nameFrame:SetHeight(6)
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
    mainFrame.nameFrame:SetPoint("TOP", 0, 8)
    mainFrame.nameFrame:SetFrameLevel(4)
    mainFrame.nameFrame.text = mainFrame.nameFrame:CreateFontString(nil, nil, "GameFontNormal")
    mainFrame.nameFrame.text:SetText(format("NAME"))
    mainFrame.nameFrame.text:SetPoint("left", 0, 0)

    --------------------HP Value----------------
    mainFrame.healthFrame.healthVal = CreateFrame("Frame", nil, mainFrame.healthFrame.base)
    mainFrame.healthFrame.healthVal:SetWidth(27)
    mainFrame.healthFrame.healthVal:SetHeight(10)
    mainFrame.healthFrame.healthVal:SetPoint("TOP", 24, -8)
    mainFrame.healthFrame.healthVal:SetFrameLevel(10)
    mainFrame.healthFrame.healthVal.text = mainFrame.healthFrame.healthVal:CreateFontString(nil, nil, "NumberFont_Outline_Med")
    mainFrame.healthFrame.healthVal.text:SetText(format("HP"))
    mainFrame.healthFrame.healthVal.text:SetScale(0.75)
    mainFrame.healthFrame.healthVal.text:SetPoint("left", 0, 0)

    ------------Power Frame
    ---------BASE
    mainFrame.powerFrame.base = CreateFrame("Frame", nil, mainFrame.powerFrame)
    mainFrame.powerFrame.base:SetWidth(29)
    mainFrame.powerFrame.base:SetHeight(14)
    mainFrame.powerFrame.base:SetFrameLevel(3)
    mainFrame.powerFrame.base:SetPoint("bottom", 38, 11)
    mainFrame.powerFrame.base.texture = mainFrame.powerFrame.base:CreateTexture(nil, "BACKGROUND")
    mainFrame.powerFrame.base.texture:SetAllPoints()
    mainFrame.powerFrame.base.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")
    mainFrame.powerFrame.base.texture:SetTexCoord(98 / 128, 127 / 128, 30 / 64, 44 / 64)

    -------Back Bar
    mainFrame.powerFrame.back = CreateFrame("Frame", nil, mainFrame.powerFrame.base)
    mainFrame.powerFrame.back:SetWidth(200)
    mainFrame.powerFrame.back:SetHeight(16)
    mainFrame.powerFrame.back:SetFrameLevel(4)
    mainFrame.powerFrame.back:SetPoint("TOPLEFT", 27, 1)
    mainFrame.powerFrame.back.texture = mainFrame.powerFrame.back:CreateTexture(nil, "BACKGROUND")
    mainFrame.powerFrame.back.texture:SetAllPoints()
    mainFrame.powerFrame.back.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")
    mainFrame.powerFrame.back.texture:SetTexCoord(67.5 / 128, 67.5 / 128, 48 / 64, 64 / 64)

    -------PP
    mainFrame.powerFrame.power = CreateFrame("Frame", nil, mainFrame.powerFrame.base)
    mainFrame.powerFrame.power:SetWidth(200)
    mainFrame.powerFrame.power:SetHeight(10)
    mainFrame.powerFrame.power:SetFrameLevel(6)
    mainFrame.powerFrame.power:SetPoint("TOPLEFT", 27, -2)
    mainFrame.powerFrame.power.texture = mainFrame.powerFrame.power:CreateTexture(nil, "BACKGROUND")
    mainFrame.powerFrame.power.texture:SetAllPoints()
    mainFrame.powerFrame.power.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")
    mainFrame.powerFrame.power.texture:SetTexCoord(79.5 / 128, 79.5 / 128, 54 / 64, 64 / 64)

    -------Edge{x = 84 / 128, xw = 86.75 / 128, y = 19 / 64, yh = 33 / 64}
    mainFrame.powerFrame.edge = CreateFrame("Frame", nil, mainFrame.powerFrame.back)
    mainFrame.powerFrame.edge:SetWidth(3)
    mainFrame.powerFrame.edge:SetHeight(14)
    mainFrame.powerFrame.edge:SetFrameLevel(3)
    mainFrame.powerFrame.edge:SetPoint("TOPRight", 3, -1)
    mainFrame.powerFrame.edge.texture = mainFrame.powerFrame.edge:CreateTexture(nil, "BACKGROUND")
    mainFrame.powerFrame.edge.texture:SetAllPoints()
    mainFrame.powerFrame.edge.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2Target\\target_frame")
    mainFrame.powerFrame.edge.texture:SetTexCoord(69 / 128, 71.75 / 128, 49 / 64, 63 / 64)

    --------------------PP Value----------------
    mainFrame.powerFrame.powerVal = CreateFrame("Frame", nil, mainFrame.powerFrame.base)
    mainFrame.powerFrame.powerVal:SetWidth(27)
    mainFrame.powerFrame.powerVal:SetHeight(6)
    mainFrame.powerFrame.powerVal:SetPoint("TOP", 24, -8)
    mainFrame.powerFrame.powerVal:SetFrameLevel(7)
    mainFrame.powerFrame.powerVal.text = mainFrame.powerFrame.powerVal:CreateFontString(nil, nil, "NumberFont_Outline_Med")
    mainFrame.powerFrame.powerVal.text:SetText(format("PP"))
    mainFrame.powerFrame.powerVal.text:SetScale(0.75)
    mainFrame.powerFrame.powerVal.text:SetPoint("left", 0, 0)
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
            if (self.healthFrame.healthLast.alpha <= 0) then
                self.damageHealth = self.unitHealth
                self.Update_Health()
            end
        elseif self.healthFrame.healthLast.alpha > 0.7 then
            self.healthFrame.healthLast.alpha = self.healthFrame.healthLast.alpha - 0.006
            self.healthFrame.healthLast:SetAlpha(self.healthFrame.healthLast.alpha)
        end
    end

    self.healthFrame:ClearAllPoints()
    self.healthFrame:SetPoint("CENTER", 0, self.offsety - 0.5)
    self.powerFrame:ClearAllPoints()
    self.powerFrame:SetPoint("CENTER", 0, self.offsety - 0.5)
end

function KH_UI:New_KH2TargetUnitframe(unit, setting)
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

        if (UnitIsCorpse(self.unit)) then
            self.portrait.levelFrame.text:Hide()
            self.portrait.levelFrame.skull:Show()
        elseif (targetEffectiveLevel > 0) then
            -- Normal level target
            self.portrait.levelFrame.text:SetText(targetEffectiveLevel)
            -- Color level number
            if (UnitCanAttack("player", self.unit)) then
                local color = GetCreatureDifficultyColor(targetEffectiveLevel)
                self.portrait.levelFrame.text:SetVertexColor(color.r, color.g, color.b)
            else
                self.portrait.levelFrame.text:SetVertexColor(1.0, 0.82, 0.0)
            end

            self.portrait.levelFrame.text:Show()
            self.portrait.levelFrame.skull:Hide()
        else
            -- Target is too high level to tell
            self.portrait.levelFrame.text:Hide()
            self.portrait.levelFrame.skull:Show()
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
        local unitHPMax, unitCurrHP, unitLevel
        unitCurrHP = UnitHealth(f.unit)
        unitHPMax = UnitHealthMax(f.unit)
        if f.lastHealth > unitCurrHP then
            f.healthFrame.healthLast.alpha = 1.1
            f.lastTimer = 2
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
        if f.unitHealthMax > KH_UI_Settings[f.settings].healthLengthMax * KH_UI_Settings[f.settings].maxBars then
            f.healthMaxMult = (KH_UI_Settings[f.settings].healthLengthMax * KH_UI_Settings[f.settings].maxBars) / f.unitHealthMax
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
        f.damageHealth = f.damageHealth * f.healthMaxMult
        unitHPMax = unitHPMax * f.healthMaxMult
        local extraBars = math.floor(unitCurrHP / (KH_UI_Settings[f.settings].healthLengthMax + 1))
        local extraDamageBars = math.floor(f.damageHealth / (KH_UI_Settings[f.settings].healthLengthMax + 1))
        local extraMaxBars = math.floor(unitHPMax / (KH_UI_Settings[f.settings].healthLengthMax + 1))
        if (extraMaxBars > 0) then
            f.healthFrame.healthExtra:SetWidth(math.ceil((KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000) * KH_UI_Settings[f.settings].healthLengthMax))
            f.healthFrame.backExtra:SetWidth(math.ceil((KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000) * KH_UI_Settings[f.settings].healthLengthMax))
            for i, blob in ipairs(f.healthFrame.blob) do
                if (i <= extraMaxBars) then
                    blob:Show()
                    if i <= extraBars then
                        texcoord = f.healthFrame.blobFrame.full
                        blob.inside.texture:SetTexCoord(texcoord.x, texcoord.xw, texcoord.y, texcoord.yh)
                    elseif i <= extraDamageBars then
                        texcoord = f.healthFrame.blobFrame.damaged
                        blob.inside.texture:SetTexCoord(texcoord.x, texcoord.xw, texcoord.y, texcoord.yh)
                    else
                        texcoord = f.healthFrame.blobFrame.empty
                        blob.inside.texture:SetTexCoord(texcoord.x, texcoord.xw, texcoord.y, texcoord.yh)
                    end
                else
                    blob:Hide()
                end
            end
            if not (f.healthFrame.extra:IsVisible() or f.healthFrame.blobFrame:IsVisible()) then
                f.healthFrame.extra:Show()
                f.healthFrame.blobFrame:Show()
            end
        else
            f.healthFrame.extra:Hide()
            f.healthFrame.blobFrame:Hide()
        end
        if (unitCurrHP > 0) then
            local tempHP = unitCurrHP - extraBars * KH_UI_Settings[f.settings].healthLengthMax
            local width = math.ceil(tempHP * (KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000))
            --Limit Length
            if (width > math.ceil((KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000) * KH_UI_Settings[f.settings].healthLengthMax)) then
                width = math.ceil((KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000) * KH_UI_Settings[f.settings].healthLengthMax)
            end
            f.healthFrame.health:SetWidth(width)
        else
            f.healthFrame.health:SetWidth(0.0001)
        end
        if (f.damageHealth > 0) then
            local tempHP = f.damageHealth - extraBars * KH_UI_Settings[f.settings].healthLengthMax
            if (tempHP < 0) then
                tempHP = 0
            end
            local width = math.ceil(tempHP * (KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000))
            --Limit Length
            if (width > math.ceil((KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000) * KH_UI_Settings[f.settings].healthLengthMax)) then
                width = math.ceil((KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000) * KH_UI_Settings[f.settings].healthLengthMax)
            end
            f.healthFrame.healthLast:SetWidth(width)
        else
            f.healthFrame.health:SetWidth(0.0001)
        end
        local tempHP = unitHPMax - extraBars * KH_UI_Settings[f.settings].healthLengthMax
        if (tempHP < 0) then
            tempHP = 0
        end
        local width = math.ceil(tempHP * (KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000))
        --Limit Length
        if (width > math.ceil((KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000) * KH_UI_Settings[f.settings].healthLengthMax)) then
            width = math.ceil((KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000) * KH_UI_Settings[f.settings].healthLengthMax)
        end
        f.healthFrame.back:SetWidth(width)
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
                f.powerFrame.back:SetWidth(math.ceil(powerMax * (KH_UI_Settings[f.settings].manaLengthRate / 1000) * f.powerMaxMult))
            else
                if (power > 0) then
                    f.powerFrame.power:SetWidth(math.ceil(power * 1.5))
                else
                    f.powerFrame.power:SetWidth(0.0001)
                end
                f.powerFrame.back:SetWidth(math.ceil(powerMax * 1.5))
            end
            if (KH_UI_Settings[f.settings].displayPowerValue) then
                f.powerFrame.powerVal.text:SetText(power .. " / " .. powerMax)
                if not (f.powerFrame:IsVisible()) then
                    f.powerFrame.powerVal:Show()
                end
            else
                f.powerFrame.powerVal:Hide()
            end
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
            if (event == "UNIT_HEALTH" and arg1 == self.unit) then
                self.Update_Health()
            elseif (event == "UNIT_POWER_UPDATE" or event == "UNIT_MAXPOWER" and arg1 == self.unit) then
                self.Update_Power()
            elseif (event == "PLAYER_TARGET_CHANGED") then
                -- Moved here to avoid taint from functions below
                CloseDropDownMenus()
                self.damageHealth = 1
                self.lastHealth = 1
                self.healthFrame.healthLast.alpha = 0
                if (UnitExists(self.unit)) then
                    self.Update_Health()
                    self.Update_Power()
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
    )
    return f
end
