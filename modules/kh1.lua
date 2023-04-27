local ResourceColor = {
    ["COMBO"] = {
        r = 1,
        g = 0.25,
        b = 0
    },
    ["RUNES"] = {
        r = 0,
        g = 1,
        b = 1,
        multi = {
            [1] = {
                r = 1,
                g = 0,
                b = 0
            },
            [2] = {
                r = 1,
                g = 0,
                b = 0
            },
            [3] = {
                r = 0,
                g = 1,
                b = 0
            },
            [4] = {
                r = 0,
                g = 1,
                b = 0
            },
            [5] = {
                r = 0,
                g = 1,
                b = 1
            },
            [6] = {
                r = 0,
                g = 1,
                b = 1
            }
        }
    }
}
local ring_table = {
    [1] = {
        global = {
            gfx_texture = "KH1\\health_ring_part",
            gfx_slicer = "KH1\\health_slicer",
            segments_used = 3,
            start_segment = 1,
            fill_direction = 1,
            ringtype = "health"
        },
        segment = {
            color = {r = 1, g = 1, b = 1, a = 1},
            framelevel = 5,
            outer_radius = 95,
            inner_radius = 70
        }
    },
    [2] = {
        global = {
            gfx_texture = "KH1\\health_ring_part_blank",
            gfx_slicer = "slicer",
            segments_used = 3,
            start_segment = 1,
            fill_direction = 1,
            ringtype = "maxhealthbg"
        },
        segment = {
            color = {r = 24 / 255, g = 28 / 255, b = 42 / 255, a = 1},
            framelevel = 3,
            outer_radius = 95,
            inner_radius = 70
        }
    },
    [3] = {
        global = {
            gfx_texture = "KH1\\health_ring_part_blank",
            gfx_slicer = "slicer",
            segments_used = 3,
            start_segment = 1,
            fill_direction = 1,
            ringtype = "lasthealth"
        },
        segment = {
            color = {r = 227 / 255, g = 1 / 255, b = 38 / 255, a = 1},
            framelevel = 4,
            outer_radius = 95,
            inner_radius = 70
        }
    },
    [4] = {
        global = {
            gfx_texture = "KH1\\health_ring_bg_part",
            gfx_slicer = "slicer",
            segments_used = 3,
            start_segment = 1,
            fill_direction = 1,
            ringtype = "maxhealth"
        },
        segment = {
            color = {r = 0, g = 0, b = 0, a = 1},
            framelevel = 2,
            outer_radius = 99,
            inner_radius = 66
        }
    },
    [5] = {
        global = {
            gfx_texture = "KH1\\health_ring_part",
            gfx_slicer = "KH1\\health_slicer",
            segments_used = 3,
            start_segment = 1,
            fill_direction = 1,
            ringtype = "maxhealthbg"
        },
        segment = {
            color = {r = 1, g = 0, b = 0, a = 1},
            framelevel = 4,
            outer_radius = 95,
            inner_radius = 70
        }
    },
    [6] = {
        global = {
            gfx_texture = "KH1\\mana_ring_part",
            gfx_slicer = "KH1\\mana_slicer",
            segments_used = 3,
            start_segment = 1,
            fill_direction = 1,
            ringtype = "mana"
        },
        segment = {
            color = {r = 1, g = 1, b = 1, a = 1},
            framelevel = 9,
            outer_radius = 124,
            inner_radius = 99
        }
    },
    [7] = {
        global = {
            gfx_texture = "KH1\\mana_ring_part",
            gfx_slicer = "KH1\\mana_slicer",
            segments_used = 3,
            start_segment = 1,
            fill_direction = 1,
            ringtype = "lastmana"
        },
        segment = {
            color = {r = 1, g = 1, b = 1, a = 1},
            framelevel = 8,
            outer_radius = 124,
            inner_radius = 99
        }
    },
    [8] = {
        global = {
            gfx_texture = "KH1\\mana_ring_bg_part",
            gfx_slicer = "slicer",
            segments_used = 3,
            start_segment = 1,
            fill_direction = 1,
            ringtype = "maxmana"
        },
        segment = {
            color = {r = 0, g = 0, b = 0, a = 1},
            framelevel = 6,
            outer_radius = 128,
            inner_radius = 95
        }
    },
    [9] = {
        global = {
            gfx_texture = "KH1\\mana_ring_part_blank",
            gfx_slicer = "slicer",
            segments_used = 3,
            start_segment = 1,
            fill_direction = 1,
            ringtype = "maxmanabg"
        },
        segment = {
            color = {r = 24 / 255, g = 28 / 255, b = 42 / 255, a = 1},
            framelevel = 7,
            outer_radius = 124,
            inner_radius = 99
        }
    }
}

local function create_infoFrames(mainFrame)
    if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
        mainFrame.nameFrame = KH_UI:CreateTextFrame("*NAME*", 0, -10, 1, 1, 1, "CENTER", mainFrame.portrait, "TOP", 25, "GameFontNormal")
        mainFrame.healthFrame.healthVal = KH_UI:CreateTextFrame("??/??", 45, -8, 1, 1, 0.4, "CENTER", mainFrame.healthFrame.base, "BOTTOMLEFT", 4, "SystemFont_OutlineThick_Huge2")
        mainFrame.manaFrame.manaVal = KH_UI:CreateTextFrame("??/??", 42, -8, 1, 1, 0.4, "CENTER", mainFrame.manaFrame.base, "BOTTOMLEFT", 4, "SystemFont_OutlineThick_Huge2")
    elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
        mainFrame.nameFrame = KH_UI:CreateTextFrame("*NAME*", 0, -10, 1, 1, 1, "CENTER", mainFrame.portrait, "TOP", 25, "GameFontNormal")
        mainFrame.healthFrame.healthVal = KH_UI:CreateTextFrame("??/??", 45, 18, 1, 1, 0.4, "CENTER", mainFrame.healthFrame.base, "BOTTOMLEFT", 4, "SystemFont_OutlineThick_Huge2")
        mainFrame.manaFrame.manaVal = KH_UI:CreateTextFrame("??/??", 42, 18, 1, 1, 0.4, "CENTER", mainFrame.manaFrame.base, "BOTTOMLEFT", 4, "SystemFont_OutlineThick_Huge2")
    end
end

local function create_barProps(mainFrame)
    if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
        mainFrame.healthFrame.base = KH_UI:CreateColorFrame(33, 5, mainFrame.healthFrame, "LEFT", -35, -2, 1, {r = 0, g = 0, b = 0, a = 1})
        mainFrame.healthFrame.label = KH_UI:CreateImageFrame(49, 18, mainFrame.healthFrame, "Left", -46, -19, 2, {x = 0 / 64, xw = 43.8 / 64, y = 0 / 128, yh = 16 / 128}, "Interface\\AddOns\\KHUnitframes\\textures\\KH1\\props")
        mainFrame.manaFrame.base = KH_UI:CreateColorFrame(33, 5, mainFrame.manaFrame, "LEFT", -64, -2, 1, {r = 0, g = 0, b = 0, a = 1})
        mainFrame.manaFrame.label = KH_UI:CreateImageFrame(50, 18, mainFrame.manaFrame, "Left", -96, -19, 3, {x = 0 / 64, xw = 44.8 / 64, y = 16 / 128, yh = 32 / 128}, "Interface\\AddOns\\KHUnitframes\\textures\\KH1\\props")
    elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
        mainFrame.healthFrame.base = KH_UI:CreateColorFrame(33, 5, mainFrame.healthFrame, "RIGHT", 35, 2, 1, {r = 0, g = 0, b = 0, a = 1})
        mainFrame.healthFrame.label = KH_UI:CreateImageFrame(45, 18, mainFrame.healthFrame, "RIGHT", 46, 19, 2, {x = 0 / 64, xw = 39.5 / 64, y = 0 / 128, yh = 16 / 128}, "Interface\\AddOns\\KHUnitframes\\textures\\KH1\\props")
        mainFrame.manaFrame.base = KH_UI:CreateColorFrame(33, 5, mainFrame.manaFrame, "RIGHT", 64, 2, 1, {r = 0, g = 0, b = 0, a = 1})
        mainFrame.manaFrame.label = KH_UI:CreateImageFrame(50, 18, mainFrame.manaFrame, "RIGHT", 96, 19, 3, {x = 0 / 64, xw = 44.8 / 64, y = 16 / 128, yh = 32 / 128}, "Interface\\AddOns\\KHUnitframes\\textures\\KH1\\props")
    end
end

local function Create_Power_Bar(mainFrame)
    if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
        mainFrame.powerFrame.base = KH_UI:CreateImageFrame(49, 18, mainFrame.powerFrame, "Left", -145, -19, 2, {x = 0 / 64, xw = 53 / 64, y = 32 / 128, yh = 48 / 128}, "Interface\\AddOns\\KHUnitframes\\textures\\KH1\\props")
        mainFrame.powerFrame.basebg = KH_UI:CreateColorFrame(50, 18, mainFrame.powerFrame.base, "LEFT", 49, 0, 1, {r = 0, g = 0, b = 0, a = 1})
        mainFrame.powerFrame.bg = KH_UI:CreateColorFrame(139, 20, mainFrame.powerFrame.base, "TOPLEFT", 0, -18, 1, {r = 0, g = 0, b = 0, a = 1})
        mainFrame.powerFrame.curvebg = KH_UI:CreateImageFrame(20, 20, mainFrame.powerFrame.bg, "TOPLEFT", 139, 0, 2, {x = 0 / 64, xw = 20 / 64, y = 49 / 128, yh = 70 / 128}, "Interface\\AddOns\\KHUnitframes\\textures\\KH1\\props")
        mainFrame.powerFrame.powerbg = KH_UI:CreateColorFrame(139, 12, mainFrame.powerFrame.bg, "TOPLEFT", 4, -4, 2, {r = 24 / 255, g = 28 / 255, b = 42 / 255, a = 1})
        mainFrame.powerFrame.power = KH_UI:CreateColorFrame(138, 12, mainFrame.powerFrame.powerbg, "TOPLEFT", 0, 0, 3, {r = 1, g = 1, b = 1, a = 1})
        mainFrame.powerFrame.powerVal = KH_UI:CreateTextFrame("??/??", 0, 0, 1, 1, 0.4, "LEFT", mainFrame.powerFrame.power, "TOPLEFT", 4, "SystemFont_OutlineThick_Huge2")
    elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
        mainFrame.powerFrame.base = KH_UI:CreateImageFrame(49, 18, mainFrame.powerFrame, "RIGHT", 145, 19, 2, {x = 0 / 64, xw = 53 / 64, y = 32 / 128, yh = 48 / 128}, "Interface\\AddOns\\KHUnitframes\\textures\\KH1\\props")
        mainFrame.powerFrame.basebg = KH_UI:CreateColorFrame(50, 18, mainFrame.powerFrame.base, "RIGHT", -49, 0, 1, {r = 0, g = 0, b = 0, a = 1})
        mainFrame.powerFrame.bg = KH_UI:CreateColorFrame(139, 20, mainFrame.powerFrame.base, "TOPRIGHT", 0, 18, 1, {r = 0, g = 0, b = 0, a = 1})
        mainFrame.powerFrame.curvebg = KH_UI:CreateImageFrame(20, 20, mainFrame.powerFrame.bg, "TOPRIGHT", -139, 0, 2, {x = 0 / 64, xw = 20 / 64, y = 49 / 128, yh = 70 / 128}, "Interface\\AddOns\\KHUnitframes\\textures\\KH1\\props")
        mainFrame.powerFrame.curvebg.texture:SetRotation(math.rad(180))
        mainFrame.powerFrame.powerbg = KH_UI:CreateColorFrame(139, 12, mainFrame.powerFrame.bg, "TOPRIGHT", -4, -5, 2, {r = 24 / 255, g = 28 / 255, b = 42 / 255, a = 1})
        mainFrame.powerFrame.power = KH_UI:CreateColorFrame(138, 12, mainFrame.powerFrame.powerbg, "TOPRIGHT", 0, 0, 3, {r = 1, g = 1, b = 1, a = 1})
        mainFrame.powerFrame.powerVal = KH_UI:CreateTextFrame("??/??", 0, 0, 1, 1, 0.4, "RIGHT", mainFrame.powerFrame.power, "TOPRIGHT", 4, "SystemFont_OutlineThick_Huge2")
    end
end

local function Create_Resource_Bar(mainFrame)
    if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
        mainFrame.resourceFrame = CreateFrame("Frame", nil, mainFrame.powerFrame.bg)
        mainFrame.resourceFrame:SetSize(1, 1)
        mainFrame.resourceFrame:SetPoint("TOPLEFT", 1, 1)
        mainFrame.resourceFrame.resourcebg = KH_UI:CreateColorFrame(139, 19, mainFrame.resourceFrame, "TOPLEFT", -1, -20, 1, {r = 0, g = 0, b = 0, a = 1})
        mainFrame.resourceFrame.resourceCurveBg =
            KH_UI:CreateImageFrame(57, 19, mainFrame.resourceFrame.resourcebg, "TOPLEFT", 139, 0, 2, {x = 0 / 64, xw = 56.8 / 64, y = 68 / 128, yh = 90 / 128}, "Interface\\AddOns\\KHUnitframes\\textures\\KH1\\props")
        mainFrame.resourceFrame.resource = {}
        for i = 1, 9 do
            mainFrame.resourceFrame.resource[i] = KH_UI:CreateColorFrame(12, 12, mainFrame.resourceFrame.resourcebg, "TOPLEFT", 4 + (i - 1) * 16, -4, 3, {r = 0.5, g = 0.5, b = 0.5, a = 1})
        end
    elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
        mainFrame.resourceFrame = CreateFrame("Frame", nil, mainFrame.powerFrame.bg)
        mainFrame.resourceFrame:SetSize(1, 1)
        mainFrame.resourceFrame:SetPoint("TOPLEFT", 1, 1)
        mainFrame.resourceFrame.resourcebg = KH_UI:CreateColorFrame(139, 20, mainFrame.resourceFrame, "TOPRIGHT", 137, 19, 1, {r = 0, g = 0, b = 0, a = 1})
        mainFrame.resourceFrame.resourceCurveBg =
            KH_UI:CreateImageFrame(57, 20, mainFrame.resourceFrame.resourcebg, "TOPRIGHT", -137, 0, 2, {x = 0 / 64, xw = 56.8 / 64, y = 68 / 128, yh = 90 / 128}, "Interface\\AddOns\\KHUnitframes\\textures\\KH1\\props")
        mainFrame.resourceFrame.resourceCurveBg.texture:SetRotation(math.rad(180))
        mainFrame.resourceFrame.resource = {}
        for i = 1, 9 do
            mainFrame.resourceFrame.resource[i] = KH_UI:CreateColorFrame(12, 12, mainFrame.resourceFrame.resourcebg, "TOPRIGHT", -4 - (i - 1) * 16, -4, 3, {r = 0.5, g = 0.5, b = 0.5, a = 1})
        end
    end

    mainFrame.resourceFrame:RegisterUnitEvent("UNIT_POWER_FREQUENT", "player")
    mainFrame.resourceFrame:RegisterUnitEvent("UNIT_DISPLAYPOWER", "player")
    mainFrame.resourceFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
    mainFrame.resourceFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    mainFrame.resourceFrame.currentValue = 0
    mainFrame.resourceFrame:SetScript(
        "OnUpdate",
        function(self, elapsed)
            local _, class, _ = UnitClass(mainFrame.unit)
            if WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC and class == "DEATHKNIGHT" then
                for i in ipairs(self.resource) do
                    if (i <= 6) then
                        local start, duration, runeReady = GetRuneCooldown(i)
                        if (start == nil) then
                            start = 0
                            duration = 10;
                        end
                        local charge = math.max(math.min((GetTime() - start) / duration, 1), 0.001)
                        self.resource[i]:SetHeight(charge * 12)
                    end
                end
            end
        end
    )
    mainFrame.resourceFrame:SetScript(
        "OnEvent",
        function(self, event, arg1)
            if (mainFrame.unit == "player") then
                local resourceType = "COMBO"
                local _, class, _ = UnitClass(mainFrame.unit)
                if (class == "DEATHKNIGHT") then
                    resourceType = "RUNES"
                end
                if (resourceType == "COMBO") then
                    self.currentValue = GetComboPoints(mainFrame.unit, "target")
                elseif (resourceType == "RUNES" and WOW_PROJECT_ID ~= WOW_PROJECT_WRATH_CLASSIC) then
                    local numReady = 0
                    for runeSlot = 1, UnitPowerMax(PlayerFrame.unit, Enum.PowerType.Runes) do
                        local start, duration, runeReady = GetRuneCooldown(runeSlot)
                        if (runeReady) then
                            numReady = numReady + 1
                        end
                    end
                    self.currentValue = numReady
                end
                for i in ipairs(self.resource) do
                    if WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC and resourceType == "RUNES" then
                        if (i <= 6) then
                            self.resource[i].texture:SetVertexColor(ResourceColor[resourceType].multi[i].r, ResourceColor[resourceType].multi[i].g, ResourceColor[resourceType].multi[i].b, 1)
                        else
                            self.resource[i]:Hide()
                        end
                    else
                        self.resource[i].texture:SetVertexColor(ResourceColor[resourceType].r, ResourceColor[resourceType].g, ResourceColor[resourceType].b, 1)
                        if (self.currentValue >= i) then
                            self.resource[i]:Show()
                        else
                            self.resource[i]:Hide()
                        end
                    end
                end
                local powerType, powerToken, _, _, _ = UnitPowerType(mainFrame.unit)
                local _, class, _ = UnitClass(mainFrame.unit)
                local maxResource = 0
                if ((class == "DRUID" and powerToken == "ENERGY") or class == "ROGUE") then
                    maxResource = UnitPowerMax(PlayerFrame.unit, Enum.PowerType.ComboPoints)
                elseif (class == "DEATHKNIGHT") then
                    maxResource = UnitPowerMax(PlayerFrame.unit, Enum.PowerType.Runes)
                    if WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC then
                        maxResource = 6
                    end
                end
                if (not self:IsShown()) then
                    if (maxResource > 0) then
                        if (class == "DRUID" and powerToken == "ENERGY") then
                            self:Show()
                        elseif (class ~= "DRUID") then
                            self:Show()
                        end
                    end
                elseif (self:IsShown()) then
                    if (class == "DRUID" and powerToken ~= "ENERGY") then
                        self:Hide()
                    elseif (maxResource <= 0) then
                        self:Hide()
                    end
                end
            else
                self:Hide()
                self:UnregisterAllEvents()
            end
        end
    )
end

local function Create_Health_Bar(mainFrame)
    if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
        mainFrame.healthFrame.healthBarBack = KH_UI:CreateColorFrame(250, 25, mainFrame.healthFrame, "BOTTOMRIGHT", -64, -31, 4, {r = 24 / 255, g = 28 / 255, b = 42 / 255, a = 1})
        mainFrame.healthFrame.healthBarBg = KH_UI:CreateColorFrame(254, 33, mainFrame.healthFrame.healthBarBack, "TOPRIGHT", 0, 4, 3, {r = 0, g = 0, b = 0, a = 1})
        mainFrame.healthFrame.healthBarLowHealth = 
            KH_UI:CreateImageFrame(200, 25, mainFrame.healthFrame.healthBarBack, "TOPRIGHT", 0, 0, 5, {x = 59.5 / 64, xw = 59.5 / 64, y = 4 / 128, yh = 29 / 128}, "Interface\\AddOns\\KHUnitframes\\textures\\KH1\\props")
            mainFrame.healthFrame.healthBarLowHealth.texture:SetVertexColor(1,0,0,1);
        mainFrame.healthFrame.healthBarHealth =
            KH_UI:CreateImageFrame(200, 25, mainFrame.healthFrame.healthBarBack, "TOPRIGHT", 0, 0, 6, {x = 59.5 / 64, xw = 59.5 / 64, y = 4 / 128, yh = 29 / 128}, "Interface\\AddOns\\KHUnitframes\\textures\\KH1\\props")
        mainFrame.healthFrame.healthBarDamage = KH_UI:CreateColorFrame(220, 25, mainFrame.healthFrame.healthBarBack, "TOPRIGHT", 0, 0, 5, {r = 227 / 255, g = 1 / 255, b = 38 / 255, a = 1})
    elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
        mainFrame.healthFrame.healthBarBack = KH_UI:CreateColorFrame(250, 25, mainFrame.healthFrame, "TOPLEFT", 64, 31, 4, {r = 24 / 255, g = 28 / 255, b = 42 / 255, a = 1})
        mainFrame.healthFrame.healthBarBg = KH_UI:CreateColorFrame(254, 33, mainFrame.healthFrame.healthBarBack, "TOPLEFT", 0, 4, 3, {r = 0, g = 0, b = 0, a = 1})
        mainFrame.healthFrame.healthBarLowHealth = 
        KH_UI:CreateImageFrame(200, 25, mainFrame.healthFrame.healthBarBack, "TOPLEFT", 0, 0, 5, {x = 59.5 / 64, xw = 59.5 / 64, y = 4 / 128, yh = 29 / 128}, "Interface\\AddOns\\KHUnitframes\\textures\\KH1\\props")
        mainFrame.healthFrame.healthBarLowHealth.texture:SetVertexColor(1,0,0,1);
        mainFrame.healthFrame.healthBarLowHealth.texture:SetRotation(math.rad(180))
        mainFrame.healthFrame.healthBarHealth =
            KH_UI:CreateImageFrame(200, 25, mainFrame.healthFrame.healthBarBack, "TOPLEFT", 0, 0, 6, {x = 59.5 / 64, xw = 59.5 / 64, y = 4 / 128, yh = 29 / 128}, "Interface\\AddOns\\KHUnitframes\\textures\\KH1\\props")
        mainFrame.healthFrame.healthBarHealth.texture:SetRotation(math.rad(180))
        mainFrame.healthFrame.healthBarDamage = KH_UI:CreateColorFrame(220, 25, mainFrame.healthFrame.healthBarBack, "TOPLEFT", 0, 0, 5, {r = 227 / 255, g = 1 / 255, b = 38 / 255, a = 1})
    end
end

local function Create_Mana_Bar(mainFrame)
    if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
        mainFrame.manaFrame.manaBarBack = KH_UI:CreateColorFrame(250, 25, mainFrame.manaFrame, "BOTTOMRIGHT", -64, -60, 4, {r = 24 / 255, g = 28 / 255, b = 42 / 255, a = 1})
        mainFrame.manaFrame.manaBarBg = KH_UI:CreateColorFrame(254, 33, mainFrame.manaFrame.manaBarBack, "TOPRIGHT", 0, 4, 3, {r = 0, g = 0, b = 0, a = 1})
        mainFrame.manaFrame.manaBarMana =
            KH_UI:CreateImageFrame(200, 25, mainFrame.manaFrame.manaBarBack, "TOPRIGHT", 0, 0, 6, {x = 58.5 / 64, xw = 58.5 / 64, y = 4 / 128, yh = 29 / 128}, "Interface\\AddOns\\KHUnitframes\\textures\\KH1\\props")
    elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
        mainFrame.manaFrame.manaBarBack = KH_UI:CreateColorFrame(250, 25, mainFrame.manaFrame, "TOPLEFT", 64, 60, 4, {r = 24 / 255, g = 28 / 255, b = 42 / 255, a = 1})
        mainFrame.manaFrame.manaBarBg = KH_UI:CreateColorFrame(254, 33, mainFrame.manaFrame.manaBarBack, "TOPLEFT", 0, 4, 3, {r = 0, g = 0, b = 0, a = 1})
        mainFrame.manaFrame.manaBarMana =
            KH_UI:CreateImageFrame(200, 25, mainFrame.manaFrame.manaBarBack, "TOPLEFT", 0, 0, 6, {x = 58.5 / 64, xw = 58.5 / 64, y = 4 / 128, yh = 29 / 128}, "Interface\\AddOns\\KHUnitframes\\textures\\KH1\\props")
        mainFrame.manaFrame.manaBarMana.texture:SetRotation(math.rad(180))
    end
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
        self.yvel = self.yvel + 1
        if (self.yvel > 4) then
            if (self.offsety > 0) then
                self.offsety = -self.offsety + 2
            elseif (self.offsety < 0) then
                self.offsety = -self.offsety - 2
            end
            self.yvel = 0
        end
        --Low HP Animation
        if self.unitHealth <= self.unitHealthMax / 3.5 and not UnitIsDeadOrGhost(self.unit) then
            if self.lowHealthDirection == 0 then
                self.lowHealthAlpha = self.lowHealthAlpha + 0.009
                if self.lowHealthAlpha >= 0.40 then
                    self.lowHealthDirection = 1
                end
            else
                self.lowHealthAlpha = self.lowHealthAlpha - 0.009
                if self.lowHealthAlpha <= 0.05 then
                    self.lowHealthDirection = 0
                end
            end
        elseif self.lowHealthAlpha > 0 then
            self.lowHealthAlpha = self.lowHealthAlpha - 0.009
            if self.lowHealthAlpha <= 0 then
                self.lowHealthAlpha = 0
            end
            self.lowHealthDirection = 0
        end
        --Update frames
        self.healthFrame.healthBarLowHealth.texture:SetAlpha(math.min(math.max(self.lowHealthAlpha, 0), 1))
        for i in ipairs(self.ring_frames) do
            if self.ring_frames[i].ringtype == "lasthealth" then
                if self.lastTimer <= 0 then
                    self.ring_frames[i].alpha = self.ring_frames[i].alpha - 0.01
                elseif self.ring_frames[i].alpha > 0.5 then
                    self.ring_frames[i].alpha = self.ring_frames[i].alpha - 0.006
                end
				if (self.ring_frames[i].alpha < 0) then
					self.ring_frames[i].alpha = 0
				elseif (self.ring_frames[i].alpha > 1) then
					self.ring_frames[i].alpha = 1
				end
                self.healthFrame.healthBarDamage.texture:SetAlpha(math.min(math.max(self.ring_frames[i].alpha, 0), 1))
                self.portrait.redTexture:SetAlpha(math.min(math.max(self.ring_frames[i].alpha, 0), 1))
            end
            
            if self.ring_frames[i].ringtype == "lastmana" then
                if (self.lastManaAlpha > 0) then
                    self.lastManaAlpha = self.lastManaAlpha - 0.02
            end
                self.ring_frames[i].alpha = self.lastManaAlpha
            end
            self.ring_frames[i]:SetAlpha(math.min(math.max(self.ring_frames[i].alpha, 0), 1))
            self.ring_frames[5]:SetAlpha(math.min(math.max(self.lowHealthAlpha, 0), 1))
        end
    end

    self.healthFrame:ClearAllPoints()
    self.healthFrame:SetPoint("CENTER", 0, self.offsety)
    self.powerFrame:ClearAllPoints()
    self.powerFrame:SetPoint("CENTER", 0, self.offsety)
    self.manaFrame:ClearAllPoints()
    self.manaFrame:SetPoint("CENTER", 0, self.offsety)
end

function KH_UI:New_KH1Unitframe(unit, setting)
    local f = CreateFrame("Button", "KH_UI " .. unit, UIParent, "SecureUnitButtonTemplate")
    f.settings = setting
    f.ring_table = ring_table
    f.offsety = 30
    f.posx, f.posy = 0, 0
    if (f.settings == "Player Frame") then
        f.posx, f.posy = KH_UI_Settings[f.settings].framex, KH_UI_Settings[f.settings].framey
    elseif (f.settings == "Party Frame") then
        f.posx, f.posy = KH_UI_Settings[f.settings].individualSettings[unit].framex, KH_UI_Settings[f.settings].individualSettings[unit].framey
    end
    f.width = 128
    f.height = 128
    f.yvel = 0
    f.xvel = 0
    f.unitHealthMax = 1
    f.unitPower = 1
    f.unitPowerMax = 1
    f.unitMana = 1
    f.lastMana = 1
    f.fadeMana = 1
    f.unitManaMax = 1
    f.unitHealth = 1
    f.lastHealth = 1
    f.damageHealth = 1
    f.ring_frames = {}
    f.lastTimer = 0
    f.lastUpdate = 0
    f.lastManaAlpha = 0
    f.lowHealthAlpha = 0
    f.lowHealthDirection = 0
    f.scale = KH_UI_Settings[f.settings].scale
    f.healthMaxMult = 1
    f.manaMaxMult = 1

    f.Update_FrameInfo = function()
        for i in ipairs(f.ring_table) do
            if (KH_UI_Settings[f.settings].orientation == "Bottom Right") then
                f.ring_table[i].global.start_segment = 4
                f.ring_table[i].global.fill_direction = 1
            elseif (KH_UI_Settings[f.settings].orientation == "Top Left") then
                f.ring_table[i].global.start_segment = 2
                f.ring_table[i].global.fill_direction = 1
            elseif (KH_UI_Settings[f.settings].orientation == "Top Right") then
                f.ring_table[i].global.start_segment = 3
                f.ring_table[i].global.fill_direction = 0
            elseif (KH_UI_Settings[f.settings].orientation == "Bottom Left") then
                f.ring_table[i].global.start_segment = 1
                f.ring_table[i].global.fill_direction = 0
            end
        end
        f:SetMovable(KH_UI_Settings[f.settings].movable)
        if (f.settings == "Party Frame") then
            f.nameFrame:SetScale(1.75)
        end
        f.nameFrame.text:SetText(UnitName(f.unit))
        if (KH_UI_Settings[f.settings].movable) then
            f:RegisterForDrag("LeftButton")
        else
            --f:RegisterForDrag(nil)
        end
        f.Update_Health(true)
        f.Update_Power(true)
    end

    f.Update_Health = function()
        f.unitHealth = UnitHealth(f.unit)
        f.unitHealthMax = UnitHealthMax(f.unit)
        if f.unitHealthMax > KH_UI_Settings[f.settings].healthLengthMax then
            f.healthMaxMult = 1 / (f.unitHealthMax / KH_UI_Settings[f.settings].healthLengthMax)
        else
            f.healthMaxMult = 1
        end
        --Force update ring
        for i in ipairs(f.ring_table) do
            if f.ring_frames[i].ringtype == "health" or f.ring_frames[i].ringtype == "lasthealth" or f.ring_frames[i].ringtype == "maxhealth" or f.ring_frames[i].ringtype == "maxhealthbg" then
                KH_UI:calc_ring_health(f.ring_frames[i], f.ring_table[i], f.unit, f.ring_frames[i].ringtype, f)
            end
        end
        --Set bar length
        local length = (f.unitHealthMax * f.healthMaxMult - KH_UI_Settings[f.settings].ringMaxHealth) * KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000
        if (length >= 0) then
            f.healthFrame.healthBarBg:SetWidth(length + 4)
            f.healthFrame.healthBarBack:SetWidth(length)
            f.healthFrame.healthBarLowHealth:SetWidth(length)
        else
            f.healthFrame.healthBarBg:SetWidth(0.00001)
            f.healthFrame.healthBarBack:SetWidth(0.00001)
            f.healthFrame.healthBarLowHealth:SetWidth(0.00001)
        end
        length = (f.unitHealth * f.healthMaxMult - KH_UI_Settings[f.settings].ringMaxHealth) * KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000
        if (length >= 0) then
            f.healthFrame.healthBarHealth:SetWidth(length)
        else
            f.healthFrame.healthBarHealth:SetWidth(0.00001)
        end
        length = (f.damageHealth * f.healthMaxMult - KH_UI_Settings[f.settings].ringMaxHealth) * KH_UI_Settings[f.settings].longBarHealthLengthRate / 1000
        if (length >= 0) then
            f.healthFrame.healthBarDamage:SetWidth(length)
        else
            f.healthFrame.healthBarDamage:SetWidth(0.00001)
        end
        --Set Text
        if f.unitHealth ~= nil then
            f.healthFrame.healthVal.text:SetText(format(f.unitHealth))
        end
        if KH_UI_Settings[f.settings].displayHealthValue and f.healthFrame.healthVal:IsVisible() == false then
            f.healthFrame.healthVal:Show()
        elseif KH_UI_Settings[f.settings].displayHealthValue == false and f.healthFrame.healthVal:IsVisible() then
            f.healthFrame.healthVal:Hide()
        end
    end

    f.Update_Power = function()
        local powerType, powerToken, altR, altG, altB = UnitPowerType(f.unit)
        local class, _, _ = UnitClass(f.unit)
        f.unitMana = UnitPower(f.unit, 0)
        f.unitManaMax = UnitPowerMax(f.unit, 0)
        f.unitPower = UnitPower(f.unit, powerType)
        f.unitPowerMax = UnitPowerMax(f.unit, powerType)
        if f.unitManaMax > KH_UI_Settings[f.settings].manaLengthMax then
            f.manaMaxMult = 1 / (f.unitManaMax / KH_UI_Settings[f.settings].manaLengthMax)
        else
            f.manaMaxMult = 1
        end
        for i in ipairs(f.ring_table) do
            if
                (f.ring_frames[i].ringtype == "power" or f.ring_frames[i].ringtype == "maxpower" or f.ring_frames[i].ringtype == "maxpowerbg" or f.ring_frames[i].ringtype == "mana" or f.ring_frames[i].ringtype == "lastmana" or f.ring_frames[i].ringtype == "maxmana" or
                    f.ring_frames[i].ringtype == "maxmanabg")
             then
                KH_UI:calc_ring_power(f.ring_frames[i], f.ring_table[i], f.unit, f.ring_frames[i].ringtype, f)
            end
        end
        if f.unitMana ~= nil then
            f.manaFrame.manaVal.text:SetText(format(f.unitMana))
        end
        if f.unitPower ~= nil then
            f.powerFrame.powerVal.text:SetText(format(f.unitPower))
        end
        if KH_UI_Settings[f.settings].displayPowerValue and f.powerFrame.powerVal:IsVisible() == false then
            f.powerFrame.powerVal:Show()
        elseif KH_UI_Settings[f.settings].displayPowerValue == false and f.powerFrame.powerVal:IsVisible() then
            f.powerFrame.powerVal:Hide()
        end
        if KH_UI_Settings[f.settings].displayManaValue and f.manaFrame.manaVal:IsVisible() == false then
            f.manaFrame.manaVal:Show()
        elseif KH_UI_Settings[f.settings].displayManaValue == false and f.manaFrame.manaVal:IsVisible() then
            f.manaFrame.manaVal:Hide()
        end
        --Set Mana Bar
        local length = (f.unitManaMax * f.manaMaxMult - KH_UI_Settings[f.settings].ringMaxPower) * KH_UI_Settings[f.settings].manaLengthRate / 1000
        if (length >= 0) then
            f.manaFrame.manaBarBg:SetWidth(length + 4)
            f.manaFrame.manaBarBack:SetWidth(length)
        else
            f.manaFrame.manaBarBg:SetWidth(0.00001)
            f.manaFrame.manaBarBack:SetWidth(0.00001)
        end
        length = (f.unitMana * f.manaMaxMult - KH_UI_Settings[f.settings].ringMaxPower) * KH_UI_Settings[f.settings].manaLengthRate / 1000
        if (length >= 0) then
            f.manaFrame.manaBarMana:SetWidth(length)
        else
            f.manaFrame.manaBarMana:SetWidth(0.00001)
        end
        --Set Power Bar
        if (f.unitPowerMax ~= nil) then
            local length = 138 * (f.unitPower / f.unitPowerMax)
            if (length > 0) then
                f.powerFrame.power:SetWidth(length)
            else
                f.powerFrame.power:SetWidth(0.0001)
            end
        end
        --Set power color
        local info, r, g, b = PowerBarColor[powerToken], 0, 0, 0
        if (info) then
            r = info.r
            g = info.g
            b = info.b
        elseif (altR) then
            r = altR
            g = altG
            b = altB
        else
            r = 1
            g = 1
            b = 1
        end
        f.powerFrame.base.texture:SetVertexColor(r, g, b, 1)
        f.powerFrame.power.texture:SetVertexColor(r * 0.5, g * 0.5, b * 0.5, 1)
        if (f.unit == "player") then
            if (class == "Shaman" or class == "Priest" or class == "Druid" or powerToken == "MANA") then
                f.enableMana = true
                f.manaFrame:Show()
            else
                f.enableMana = false
                f.manaFrame:Hide()
            end
        else
            if (powerToken == "MANA") then
                f.enableMana = true
                f.manaFrame:Show()
            else
                f.enableMana = false
                f.manaFrame:Hide()
            end
        end
        if (powerToken == "MANA") then
            f.powerFrame:Hide()
        else
            f.powerFrame:Show()
        end
    end

    f.Refresh_Points = function()
        f.healthFrame.long_bar:ClearAllPoints()
        f.healthFrame.long_bar.health:ClearAllPoints()
        f.healthFrame.long_bar.healthLast:ClearAllPoints()
        f.healthFrame.long_bar.edge:ClearAllPoints()
    end

    f.unit = unit
    f.enableMana = false
    _, f.powerToken = UnitPowerType(f.unit)
    if UnitClass(f.unit) == "Shaman" or UnitClass(f.unit) == "Priest" or UnitClass(f.unit) == "Druid" or f.powerToken == "MANA" then
        f.enableMana = true
    end
    f:EnableMouse(true)
    f:RegisterForClicks("AnyUp")
    f:SetClampedToScreen(true)
    f:SetMovable(KH_UI_Settings[f.settings].movable)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript(
        "OnDragStop",
        function()
            local _, _, _, xOfs, yOfs = f:GetPoint(1)
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
            f:ClearAllPoints()
            f:SetPoint("TOPLEFT", f.posx, f.posy)
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
    f.manaFrame = CreateFrame("Frame", nil, f)
    f:SetWidth(f.width)
    f:SetHeight(f.height)
    f:SetScale(f.scale)
    f.healthFrame:SetWidth(f.width)
    f.healthFrame:SetHeight(f.height)
    f.powerFrame:SetWidth(f.width)
    f.powerFrame:SetHeight(f.height)
    f.manaFrame:SetWidth(f.width)
    f.manaFrame:SetHeight(f.height)
    f:ClearAllPoints()
    f:SetPoint("TOPLEFT", f.posx, f.posy)

    f:SetScript("OnUpdate", Update)

    for i in ipairs(f.ring_table) do
        if (KH_UI_Settings[f.settings].orientation == "Bottom Right") then
            f.ring_table[i].global.start_segment = 4
            f.ring_table[i].global.fill_direction = 1
        elseif (KH_UI_Settings[f.settings].orientation == "Top Left") then
            f.ring_table[i].global.start_segment = 2
            f.ring_table[i].global.fill_direction = 1
        elseif (KH_UI_Settings[f.settings].orientation == "Top Right") then
            f.ring_table[i].global.start_segment = 3
            f.ring_table[i].global.fill_direction = 0
        elseif (KH_UI_Settings[f.settings].orientation == "Bottom Left") then
            f.ring_table[i].global.start_segment = 1
            f.ring_table[i].global.fill_direction = 0
        end
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
    bgtex:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH1\\ring_bg")
    if (KH_UI_Settings[f.settings].orientation == "Top Left") then
        bgtex:SetRotation(math.rad(180))
    end
    if (KH_UI_Settings[f.settings].orientation == "Top Right") then
        bgtex:SetRotation(math.rad(-90))
        bgtex:SetTexCoord(0, 1, 1, 0)
    end
    if (KH_UI_Settings[f.settings].orientation == "Bottom Left") then
        bgtex:SetRotation(math.rad(90))
        bgtex:SetTexCoord(0, 1, 1, 0)
    end

    KH_UI:create_portrait(f)
    create_barProps(f)
    create_infoFrames(f)
    Create_Power_Bar(f)
    Create_Resource_Bar(f)
    Create_Health_Bar(f)
    Create_Mana_Bar(f)

    f:RegisterEvent("UNIT_POWER_FREQUENT")
    f:RegisterEvent("UNIT_MANA")
    f:RegisterEvent("UNIT_MAXHEALTH")
	if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
		f:RegisterEvent("UNIT_HEALTH")
	else
		f:RegisterEvent("UNIT_HEALTH_FREQUENT")
	end
    f:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
    f:RegisterEvent("PLAYER_ENTERING_WORLD")

    f:SetScript(
        "OnEvent",
        function(self, event, arg1)
            if not (event == "GROUP_ROSTER_UPDATE" or event == "UNIT_CONNECTION" or event == "UNIT_OTHER_PARTY_CHANGED") then
            --Place holder
            end

            if arg1 == f.unit then
                if (event == "UNIT_MANA" or event == "UPDATE_SHAPESHIFT_FORM" or event == "UNIT_POWER_FREQUENT" or event == "GROUP_ROSTER_UPDATE") then
                    f:Update_Power()
                elseif (event == "UNIT_MAXHEALTH" or event == "UNIT_HEALTH" or event == "UNIT_HEALTH_FREQUENT") then
                    f:Update_Health()
                end
            end
        end
    )

    return f
end
