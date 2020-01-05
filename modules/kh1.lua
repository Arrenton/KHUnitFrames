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
			framelevel = 2,
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
			color = {r = 0 / 255, g = 0 / 255, b = 0 / 255, a = 1},
			framelevel = 2,
			outer_radius = 99,
			inner_radius = 66
		}
	},
	[5] = {
		global = {
			gfx_texture = "KH2\\ring_segment",
			gfx_slicer = "KH1\\health_slicer",
			segments_used = 3,
			start_segment = 1,
			fill_direction = 1,
			ringtype = "maxhealthbg"
		},
		segment = {
			color = {r = 227 / 255, g = 1 / 255, b = 38 / 255, a = 1},
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
			ringtype = "power"
		},
		segment = {
			color = {r = 1, g = 1, b = 1, a = 1},
			framelevel = 8,
			outer_radius = 124,
			inner_radius = 99
		}
	},
	[7] = {
		global = {
			gfx_texture = "KH1\\mana_ring_bg_part",
			gfx_slicer = "slicer",
			segments_used = 3,
			start_segment = 1,
			fill_direction = 1,
			ringtype = "maxpower"
		},
		segment = {
			color = {r = 0, g = 0, b = 0, a = 1},
			framelevel = 6,
			outer_radius = 128,
			inner_radius = 95
		}
	},
	[8] = {
		global = {
			gfx_texture = "KH1\\mana_ring_part_blank",
			gfx_slicer = "slicer",
			segments_used = 3,
			start_segment = 1,
			fill_direction = 1,
			ringtype = "maxpowerbg"
		},
		segment = {
			color = {r = 24 / 255, g = 28 / 255, b = 42 / 255, a = 1},
			framelevel = 7,
			outer_radius = 124,
			inner_radius = 99
		}
	},
}

local function create_infoFrames(mainFrame)
    mainFrame.nameFrame = KH_UI:CreateTextFrame("*NAME*", 0, -10, 1, 1, 1, "CENTER", mainFrame.portrait, "TOP", 25, "GameFontNormal")
end

local function create_barProps(mainFrame)
    mainFrame.healthFrame.base = KH_UI:CreateColorFrame(33, 5, mainFrame.healthFrame, "LEFT", -35, -2, 1, {r = 0, g = 0, b = 0, a = 1})
    mainFrame.healthFrame.label = KH_UI:CreateImageFrame(44, 16, mainFrame.healthFrame, "Left", -42, -18, 2, {x = 0 / 64, xw = 43.8 / 64, y = 0 / 64, yh = 16 / 64}, "Interface\\AddOns\\KHUnitframes\\textures\\KH1\\props")
    mainFrame.manaFrame.base = KH_UI:CreateColorFrame(33, 5, mainFrame.manaFrame, "LEFT", -64, -2, 1, {r = 0, g = 0, b = 0, a = 1})
    mainFrame.manaFrame.label = KH_UI:CreateImageFrame(44, 16, mainFrame.manaFrame, "Left", -86, -18, 3, {x = 0 / 64, xw = 43.8 / 64, y = 16 / 64, yh = 32 / 64}, "Interface\\AddOns\\KHUnitframes\\textures\\KH1\\props")
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
		if self.unitHealth <= self.unitHealthMax / 4 and not UnitIsDeadOrGhost(self.unit) then
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
        for i in ipairs(self.ring_frames) do
            if self.ring_frames[i].ringtype == "lasthealth" then
				if self.lastTimer <= 0 then
					self.ring_frames[i].alpha = self.ring_frames[i].alpha - 0.01
				elseif self.ring_frames[i].alpha > 0.5 then
					self.ring_frames[i].alpha = self.ring_frames[i].alpha - 0.006
				end
				--self.healthFrame.long_bar.healthLast.texture:SetAlpha(self.ring_frames[i].alpha)
				self.portrait.redTexture:SetAlpha(self.ring_frames[i].alpha)
			end
			self.ring_frames[i]:SetAlpha(self.ring_frames[i].alpha)
			self.ring_frames[5]:SetAlpha(self.lowHealthAlpha)
		end
	end

	self.healthFrame:ClearAllPoints()
	self.healthFrame:SetPoint("CENTER", 0, self.offsety)
	self.powerFrame:ClearAllPoints()
	self.powerFrame:SetPoint("CENTER", 0, 0)
	self.manaFrame:ClearAllPoints()
	self.manaFrame:SetPoint("CENTER", 0, 0)
	--calc_health_stretch(self)
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
        if (f.settings == "Party Frame") then
            f.scale = f.scale / 2
        end
        --f.healthFrame:SetScale(f.scale)
        --f.powerFrame:SetScale(f.scale)
        --f.manaFrame:SetScale(f.scale)
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
        f.unitHealth = UnitHealth(f.unit)
        f.unitHealthMax = UnitHealthMax(f.unit)
        if f.unitHealthMax > KH_UI_Settings[f.settings].healthLengthMax then
            f.healthMaxMult = 1 / (f.unitHealthMax / KH_UI_Settings[f.settings].healthLengthMax)
        else
            f.healthMaxMult = 1
        end
        for i in ipairs(f.ring_table) do
            if f.ring_frames[i].ringtype == "health" or f.ring_frames[i].ringtype == "lasthealth" or f.ring_frames[i].ringtype == "maxhealth" or f.ring_frames[i].ringtype == "maxhealthbg" then
                KH_UI:calc_ring_health(f.ring_frames[i], f.ring_table[i], f.unit, f.ring_frames[i].ringtype, f)
            end
        end
    end

    f.Update_Power = function()
        local powerType, powerToken, altR, altG, altB = UnitPowerType(f.unit)
        local class, _, _ = UnitClass(f.unit)
        f.UnitPowerMax = UnitPowerMax(f.unit, powerType)
        for i in ipairs(f.ring_table) do
            if (f.ring_frames[i].ringtype == "power" or f.ring_frames[i].ringtype == "maxpower" or f.ring_frames[i].ringtype == "maxpowerbg") then
                KH_UI:calc_ring_power(f.ring_frames[i], f.ring_table[i], f.unit, f.ring_frames[i].ringtype, f)
            end
        end
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
        if (powerToken ~= "MANA") then
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
    f:SetPoint("TopLeft", f.posx, f.posy)

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
        bgtex:SetRotation(math.rad(180), 0.5, 0.5)
    end
    if (KH_UI_Settings[f.settings].orientation == "Top Right") then
        bgtex:SetRotation(math.rad(-90), 0.5, 0.5)
        bgtex:SetTexCoord(0, 1, 1, 0)
    end
    if (KH_UI_Settings[f.settings].orientation == "Bottom Left") then
        bgtex:SetRotation(math.rad(90), 0.5, 0.5)
        bgtex:SetTexCoord(0, 1, 1, 0)
    end

    --create_ring_pretties(f)
    --create_health_stretch(f)
    KH_UI:create_portrait(f)
    create_infoFrames(f)
    create_barProps(f)
    --[[create_mana_bar(f)
    Create_Power_Bar(f)
    Create_Resource_Counter(f)]]

    f:RegisterEvent("UNIT_POWER_UPDATE")
    f:RegisterEvent("UNIT_MANA")
    f:RegisterEvent("UNIT_MAXHEALTH")
    f:RegisterEvent("UNIT_HEALTH")
    f:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
    f:RegisterEvent("PLAYER_ENTERING_WORLD")

    f:SetScript(
        "OnEvent",
        function(self, event, arg1)
            if not (event == "GROUP_ROSTER_UPDATE" or event == "UNIT_CONNECTION" or event == "UNIT_OTHER_PARTY_CHANGED") then
            --Place holder
            end

            if arg1 == f.unit then
                if (event == "UNIT_MANA" or event == "UPDATE_SHAPESHIFT_FORM" or event == "UNIT_POWER_UPDATE" or event == "GROUP_ROSTER_UPDATE") then
                    f:Update_Power()
                elseif (event == "UNIT_MAXHEALTH" or event == "UNIT_HEALTH") then
                    f.unitHealth = UnitHealth(f.unit)
                    f.unitHealthMax = UnitHealthMax(f.unit)
                    if f.unitHealthMax > KH_UI_Settings[f.settings].healthLengthMax then
                        f.healthMaxMult = 1 / (f.unitHealthMax / KH_UI_Settings[f.settings].healthLengthMax)
                    else
                        f.healthMaxMult = 1
                    end
                end
            end
        end
    )

    f:Update_Power()

    return f
end