local ring_table = {
    [1] = {
        global = {
            gfx_texture = "KH2Party\\ring_segment",
            segments_used = 2,
            start_segment = 3,
            fill_direction = 1,
            ringtype = "maxhealth"
        },
        segment = {
            color = {r = 32 / 255, g = 32 / 255, b = 31 / 255, a = 1},
            framelevel = 2,
            outer_radius = 95,
            inner_radius = 75
        }
    },
    [2] = {
        global = {
            gfx_texture = "KH2Party\\ring_segment",
            segments_used = 2,
            start_segment = 3,
            fill_direction = 1,
            ringtype = "maxhealth"
        },
        segment = {
            color = {r = 227 / 255, g = 1 / 255, b = 38 / 255, a = 1},
            framelevel = 3,
            outer_radius = 95,
            inner_radius = 75
        }
    },
    [3] = {
        global = {
            gfx_texture = "KH2Party\\ring_segment",
            segments_used = 2,
            start_segment = 3,
            fill_direction = 1,
            ringtype = "lasthealth"
        },
        segment = {
            color = {r = 227 / 255, g = 1 / 255, b = 38 / 255, a = 1},
            framelevel = 3,
            outer_radius = 95,
            inner_radius = 75
        }
    },
    [4] = {
        global = {
            gfx_texture = "KH2Party\\ring_segment",
            segments_used = 2,
            start_segment = 3,
            fill_direction = 1,
            ringtype = "health"
        },
        segment = {
            color = {r = 34 / 255, g = 183 / 255, b = 1 / 255, a = 1},
            framelevel = 5,
            outer_radius = 95,
            inner_radius = 75
        }
    },
    [5] = {
        global = {
            gfx_texture = "KH2Party\\ring_segment",
            segments_used = 2,
            start_segment = 2,
            fill_direction = 0,
            ringtype = "maxpower"
        },
        segment = {
            color = {r = 32 / 255, g = 32 / 255, b = 31 / 255, a = 1},
            framelevel = 3,
            outer_radius = 95,
            inner_radius = 75
        }
    },
    [6] = {
        global = {
            gfx_texture = "KH2Party\\ring_segment",
            segments_used = 2,
            start_segment = 2,
            fill_direction = 0,
            ringtype = "power"
        },
        segment = {
            color = {r = 32 / 255, g = 32 / 255, b = 31 / 255, a = 1},
            framelevel = 5,
            outer_radius = 95,
            inner_radius = 75
        }
    }
}

local function create_ring_pretties(mainFrame)
    --------------------Health Value----------------
    mainFrame.healthFrame.healthVal = CreateFrame("Frame", nil, mainFrame.healthFrame)
    mainFrame.healthFrame.healthVal:SetWidth(27)
    mainFrame.healthFrame.healthVal:SetHeight(6)
    mainFrame.healthFrame.healthVal:RegisterEvent("UNIT_HEALTH_FREQUENT")
    mainFrame.healthFrame.healthVal:RegisterEvent("PLAYER_ENTERING_WORLD")
    mainFrame.healthFrame.healthVal:SetScript(
        "OnEvent",
        function(self, event, unit)
            if
                KH_UI_Settings[mainFrame.settings].displayHealthValue and
                    mainFrame.healthFrame.healthVal:IsVisible() == false
             then
                mainFrame.healthFrame.healthVal:Show()
            elseif
                KH_UI_Settings[mainFrame.settings].displayHealthValue == false and
                    mainFrame.healthFrame.healthVal:IsVisible()
             then
                mainFrame.healthFrame.healthVal:Hide()
            end
            if mainFrame.unitHealth ~= nil then
                mainFrame.healthFrame.healthVal.text:SetText(format(mainFrame.unitHealth))
            end
        end
    )
    mainFrame.healthFrame.healthVal:SetPoint("center", -20, -77)
    mainFrame.healthFrame.healthVal:SetFrameLevel(6)
    mainFrame.healthFrame.healthVal:SetScale(1.35)
    mainFrame.healthFrame.healthVal.text = mainFrame.healthFrame.healthVal:CreateFontString(nil, nil, "SpellFont_Small")
    mainFrame.healthFrame.healthVal.text:SetText(format("HP"))
    mainFrame.healthFrame.healthVal.text:SetPoint("right", 0, 0)
    ----------------Power Value----------------------------------
    mainFrame.powerFrame.power_val = CreateFrame("Frame", nil, mainFrame.powerFrame)
    mainFrame.powerFrame.power_val:SetWidth(27)
    mainFrame.powerFrame.power_val:SetHeight(6)
    mainFrame.powerFrame.power_val:SetPoint("center", 20, -77)
    mainFrame.powerFrame.power_val:SetFrameLevel(6)
    mainFrame.powerFrame.power_val:SetScale(1.35)
    mainFrame.powerFrame.power_val:SetScript(
        "OnUpdate",
        function(self, event, unit)
            if
                KH_UI_Settings[mainFrame.settings].displayPowerValue and
                    mainFrame.powerFrame.power_val:IsVisible() == false
             then
                mainFrame.powerFrame.power_val:Show()
            elseif
                KH_UI_Settings[mainFrame.settings].displayPowerValue == false and
                    mainFrame.powerFrame.power_val:IsVisible()
             then
                mainFrame.powerFrame.power_val:Hide()
            end
            if mainFrame.unitPower ~= nil then
                mainFrame.powerFrame.power_val.text:SetText(format(mainFrame.unitPower))
            end
        end
    )
    mainFrame.powerFrame.power_val.text = mainFrame.powerFrame.power_val:CreateFontString(nil, nil, "SpellFont_Small")
    mainFrame.powerFrame.power_val.text:SetText(format("PP"))
    mainFrame.powerFrame.power_val.text:SetPoint("left", 0, 0)
    --------------------Name----------------
    mainFrame.nameFrame = CreateFrame("Frame", nil, mainFrame.healthFrame)
    mainFrame.nameFrame:SetWidth(27)
    mainFrame.nameFrame:SetHeight(6)
    mainFrame.nameFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    mainFrame.nameFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
    mainFrame.nameFrame:RegisterEvent("UNIT_OTHER_PARTY_CHANGED")
    mainFrame.nameFrame:SetScript(
        "OnEvent",
        function(self, event, unit)
            if UnitName(mainFrame.unit) ~= nil then
                mainFrame.nameFrame.text:SetText(format(UnitName(mainFrame.unit)))
            end
        end
    )
    mainFrame.nameFrame:SetScale(1.25)
    if (mainFrame.settings == "Party Frame") then
        mainFrame.nameFrame:SetPoint("center", 0, 80)
    elseif (mainFrame.settings == "Player Frame") then
        mainFrame.nameFrame:SetPoint("center", 0, 80)
    end
    mainFrame.nameFrame:SetFrameLevel(9)
    mainFrame.nameFrame.text = mainFrame.nameFrame:CreateFontString(nil, nil, "GameFontNormalLarge")
    mainFrame.nameFrame.text:SetText(format("NAME"))
    mainFrame.nameFrame.text:SetPoint("center", 0, 0)
end

local function Update(self, elapsed)
    self.lastUpdate = self.lastUpdate + elapsed

    if self.lastTimer > 0 then
        self.lastTimer = self.lastTimer - elapsed
    end

    if (self.lastUpdate > 0.99) then
        self.lastUpdate = 0.99
    end

    while (self.lastUpdate > (1 / 144)) do
        self.lastUpdate = self.lastUpdate - 1 / 144
        self.offsety = self.offsety + self.yvel

        if self.offsety > 2 then
            self.yvel = (self.yvel) - 0.15
        elseif self.offsety < -2 then
            self.yvel = (self.yvel) + 0.15
        elseif self.offsety > -2 and self.offsety < 2 and self.yvel > -0.33 and self.yvel < 0.33 then
            self.yvel = 0
            self.offsety = 0
        elseif self.yvel ~= 0 then
            self.yvel = self.yvel * 0.94
        end
        --Low HP Animation
        if self.unitHealth <= self.unitHealthMax / 4 then
            if self.lowHealthDirection == 0 then
                self.lowHealthAlpha = self.lowHealthAlpha + 0.009
                if self.lowHealthAlpha >= 0.60 then
                    self.lowHealthDirection = 1
                end
            else
                self.lowHealthAlpha = self.lowHealthAlpha - 0.009
                if self.lowHealthAlpha <= 0.1 then
                    self.lowHealthDirection = 0
                end
            end
        else
            self.lowHealthAlpha = 0
            self.lowHealthDirection = 0
        end
        --Update frames
        for i in ipairs(self.ring_frames) do
            if self.ring_frames[i].ringtype == "lasthealth" then
                if self.lastTimer <= 0 then
                    self.ring_frames[i].alpha = self.ring_frames[i].alpha - 0.01
                elseif self.ring_frames[i].alpha > 0.5 then
                    self.ring_frames[i].alpha = self.ring_frames[i].alpha - 0.006
                end
                self.portrait.redTexture:SetAlpha(self.ring_frames[i].alpha)
            end
            self.ring_frames[i]:SetAlpha(self.ring_frames[i].alpha)
            self.ring_frames[2]:SetAlpha(self.lowHealthAlpha)
        end
    end

    self.healthFrame:ClearAllPoints()
    self.healthFrame:SetPoint("CENTER", 0, self.offsety - 0.5)
    self.powerFrame:ClearAllPoints()
    self.powerFrame:SetPoint("CENTER", 0, self.offsety - 0.5)
end

function KH_UI:New_KH2PartyUnitframe(unit, setting)
    ------------------------
    --Local Functions-------
    ------------------------

    ---------------------
    ----Frame Variables--
    ---------------------

    local f = CreateFrame("Button", "KH_UI " .. unit, UIParent, "SecureUnitButtonTemplate")
    f.settings = setting
    f.ring_table = ring_table
    f.offsety = 0
    f.posx, f.posy = 0, 0
    if (f.settings == "Player Frame") then
        f.posx, f.posy = KH_UI_Settings[f.settings].framex, KH_UI_Settings[f.settings].framey
    elseif (f.settings == "Party Frame") then
        f.posx, f.posy =
            KH_UI_Settings[f.settings].individualSettings[unit].framex,
            KH_UI_Settings[f.settings].individualSettings[unit].framey
    end
    f.width = 128
    f.height = 128
    f.yvel = 4
    f.xvel = 0
    f.unitHealthMax = 1
    f.unitPowerMax = 1
    f.unitMana = 1
    f.unitManaMax = 1
    f.unitHealth = 1
    f.lastHealth = 1
    f.damageHealth = 1
    f.ring_frames = {}
    f.lastTimer = 0
    f.lastUpdate = 0
    f.lowHealthAlpha = 0
    f.lowHealthDirection = 0
    f.scale = KH_UI_Settings[f.settings].scale
    if (f.settings == "Party Frame") then
        f.scale = f.scale / 2
    end
    f.healthMaxMult = 1

    f.Update_FrameInfo = function()
        f.scale = KH_UI_Settings[f.settings].scale
        for i in ipairs(f.ring_table) do
            if (f.settings == "Party Frame") then
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
    end

    f.Update_Health = function()
        f.unitHealth = UnitHealth(f.unit)
        f.unitHealthMax = UnitHealthMax(f.unit)
        if f.unitHealthMax > KH_UI_Settings[f.settings].healthLengthMax then
            f.healthMaxMult = 1 / (f.unitHealthMax / KH_UI_Settings[f.settings].healthLengthMax)
        else
            f.healthMaxMult = 1
        end
        for i in ipairs(f.ring_table) do
            if f.ring_frames[i].ringtype == "health" or f.ring_frames[i].ringtype == "lasthealth" then
                KH_UI:calc_ring_health(f.ring_frames[i], f.ring_table[i], f.unit, f.ring_frames[i].ringtype, f)
            end
        end
    end

    f.Update_Power = function()
        local powerType, powerToken, altR, altG, altB = UnitPowerType(f.unit)
        f.unitPower = UnitPower(f.unit, powerType)
        f.UnitPowerMax = UnitPowerMax(f.unit, powerType)
        for i in ipairs(f.ring_table) do
            if (f.ring_frames[i].ringtype == "power" or f.ring_frames[i].ringtype == "maxpower") then
                KH_UI:calc_ring_power(f.ring_frames[i], f.ring_table[i], f.unit, f.ring_frames[i].ringtype, f)
            end
        end
    end

    f.Refresh_Points = function()
    end

    f.unit = unit
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
            if (f.settings == "Player Frame") then
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

    local dropdown = _G[f:GetName() .. "DropDown"]
    local menuFunc = TargetFrameDropDown_Initialize

    if f.unit == "player" then
        menuFunc = function()
            ToggleDropDownMenu(1, nil, PlayerFrameDropDown, f, 106, 27)
        end
    end

    if (f.settings == "Party Frame") then
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
    f.manaFrame = CreateFrame("Frame", nil, f)
    f:SetWidth(f.width)
    f:SetHeight(f.height)
    f.healthFrame:SetWidth(f.width)
    f.healthFrame:SetHeight(f.height)
    f.powerFrame:SetWidth(f.width)
    f.powerFrame:SetHeight(f.height)
    f.manaFrame:SetWidth(f.width)
    f.manaFrame:SetHeight(f.height)
    f:ClearAllPoints()
    f:SetPoint("TopLeft", f.posx, f.posy)
    f.healthFrame:SetScale(f.scale)
    f.powerFrame:SetScale(f.scale)
    f.manaFrame:SetScale(f.scale)

    f:SetScript("OnUpdate", Update)

    for i in ipairs(f.ring_table) do
        f.ring_frames[i] = KH_UI:setup_rings(i, f, f.ring_table)
    end
    ----Ring Background
    f.healthFrame.ring_bg = CreateFrame("Frame", nil, f.healthFrame)
    f.healthFrame.ring_bg:SetPoint("CENTER", 0, 0)
    f.healthFrame.ring_bg.alpha = 1
    f.healthFrame.ring_bg:SetWidth(256)
    f.healthFrame.ring_bg:SetHeight(256)
    local bgtex = f.healthFrame.ring_bg:CreateTexture(nil, "BACKGROUND")
    bgtex:SetAllPoints()
    bgtex:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2Party\\UnitFrame_BG")
    --bgtex:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1)

    create_ring_pretties(f)
    KH_UI:create_portrait(f)
    f.portrait:SetScale(1.5)
    f.portrait:SetFrameLevel(0)
    f.portrait.levelFrame:SetPoint("BottomLeft", 4, 4)
    f.portrait.levelFrame:SetFrameLevel(7)
    f.portrait.stateFrame:SetFrameLevel(8)
    f.portrait.leaderFrame:SetFrameLevel(8)
    f.portrait.leaderFrame:SetPoint("TopLeft", 8, -8)
    f.portrait.masterLootFrame:SetFrameLevel(8)
    f.portrait.pvpIcon:SetFrameLevel(8)
    f.portrait.pvpIcon:SetScale(0.75)
    f.portrait.pvpIcon:SetPoint("TopLeft", -12, -42)
    f.portrait.disconnectFrame:SetFrameLevel(8)

    f:RegisterEvent("UNIT_POWER_UPDATE")
    f:RegisterEvent("PLAYER_ENTERING_WORLD")

    f:SetScript(
        "OnEvent",
        function(self, event, arg1)
            if not (event == "GROUP_ROSTER_UPDATE" or event == "UNIT_CONNECTION" or event == "UNIT_OTHER_PARTY_CHANGED") then
                local powerType, powerToken, altR, altG, altB = UnitPowerType(f.unit)
            end
        end
    )
    return f
end
