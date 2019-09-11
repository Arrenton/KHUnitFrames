local ring_table = {
	[1] = {
		global = {
			gfx_texture = "KH2\\ring_segment",
			segments_used = 3,
			start_segment = 1,
			fill_direction = 1,
			ringtype = "health"
		},
		segment = {
			color = {r = 34 / 255, g = 183 / 255, b = 1 / 255, a = 1},
			framelevel = 14,
			segmentsize = 128,
			outer_radius = 96,
			inner_radius = 72
		}
	},
	[2] = {
		global = {
			gfx_texture = "KH2\\ring_segment",
			segments_used = 3,
			start_segment = 1,
			fill_direction = 1,
			ringtype = "maxhealthbg"
		},
		segment = {
			color = {r = 32 / 255, g = 32 / 255, b = 31 / 255, a = 1},
			framelevel = 12,
			outer_radius = 96,
			inner_radius = 72
		}
	},
	[3] = {
		global = {
			gfx_texture = "KH2\\ring_segment",
			segments_used = 3,
			start_segment = 1,
			fill_direction = 1,
			ringtype = "lasthealth"
		},
		segment = {
			color = {r = 227 / 255, g = 1 / 255, b = 38 / 255, a = 1},
			framelevel = 13,
			outer_radius = 96,
			inner_radius = 72
		}
	},
	[4] = {
		global = {
			gfx_texture = "KH2\\background_segment",
			segments_used = 3,
			start_segment = 1,
			fill_direction = 1,
			ringtype = "maxhealth"
		},
		segment = {
			color = {r = 0 / 255, g = 0 / 255, b = 0 / 255, a = 1},
			framelevel = 11,
			outer_radius = 100,
			inner_radius = 67
		}
	},
	[5] = {
		global = {
			gfx_texture = "KH2\\power_background_segment",
			segments_used = 3,
			start_segment = 1,
			fill_direction = 1,
			ringtype = "maxpower"
		},
		segment = {
			color = {r = 0 / 255, g = 0 / 255, b = 0 / 255, a = 1},
			framelevel = 1,
			outer_radius = 118,
			inner_radius = 96
		}
	},
	[6] = {
		global = {
			gfx_texture = "KH2\\power_ring_segment",
			segments_used = 3,
			start_segment = 1,
			fill_direction = 1,
			ringtype = "maxpower"
		},
		segment = {
			color = {r = 32 / 255, g = 32 / 255, b = 31 / 255, a = 1},
			framelevel = 2,
			outer_radius = 115,
			inner_radius = 100
		}
	},
	[7] = {
		global = {
			gfx_texture = "KH2\\power_ring_segment",
			segments_used = 3,
			start_segment = 1,
			fill_direction = 1,
			ringtype = "power"
		},
		segment = {
			color = {r = 32 / 255, g = 32 / 255, b = 31 / 255, a = 1},
			framelevel = 3,
			outer_radius = 115,
			inner_radius = 100
		}
	},
	[8] = {
		global = {
			gfx_texture = "KH2\\ring_segment",
			segments_used = 3,
			start_segment = 1,
			fill_direction = 1,
			ringtype = "maxhealthbg"
		},
		segment = {
			color = {r = 227 / 255, g = 1 / 255, b = 38 / 255, a = 1},
			framelevel = 13,
			outer_radius = 96,
			inner_radius = 72
		}
	}
}

local function create_ring_pretties(mainFrame)
	------Max Edge
	mainFrame.unitHealthMax = UnitHealthMax(mainFrame.unit)
	if mainFrame.unitHealthMax > KH_UI_Settings[mainFrame.settings].healthLengthMax then
		mainFrame.healthMaxMult = 1 / (mainFrame.unitHealthMax / KH_UI_Settings[mainFrame.settings].healthLengthMax)
	else
		mainFrame.healthMaxMult = 1
	end
	mainFrame.healthFrame.edge_frame = CreateFrame("Frame", nil, mainFrame.healthFrame)
	mainFrame.healthFrame.edge_frame:SetWidth(8)
	mainFrame.healthFrame.edge_frame:SetHeight(33)
	mainFrame.healthFrame.edge_frame:SetFrameLevel(12)
	mainFrame.healthFrame.edge_frame:SetScript(
		"OnEvent",
		function(self, event, unit)
			if
				(event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_MAXHEALTH" or event == "PLAYER_ENTERING_WORLD") and
					unit == mainFrame.unit
			 then
				mainFrame.unitHealthMax = UnitHealthMax(mainFrame.unit)
				if mainFrame.unitHealthMax > KH_UI_Settings[mainFrame.settings].healthLengthMax then
					mainFrame.healthMaxMult = 1 / (mainFrame.unitHealthMax / KH_UI_Settings[mainFrame.settings].healthLengthMax)
				else
					mainFrame.healthMaxMult = 1
				end
			end
		end
	)
	mainFrame.healthFrame.edge_frame:RegisterEvent("UNIT_HEALTH_FREQUENT")
	mainFrame.healthFrame.edge_frame:RegisterEvent("UNIT_MAXHEALTH")
	mainFrame.healthFrame.edge_frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	mainFrame.healthFrame.edge_frame.texture = mainFrame.healthFrame.edge_frame:CreateTexture(nil, "BACKGROUND")
	mainFrame.healthFrame.edge_frame.texture.radius = 83
	mainFrame.healthFrame.edge_frame.texture:SetAllPoints()
	mainFrame.healthFrame.edge_frame.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2\\longbars")
	mainFrame.healthFrame.edge_frame.texture:SetTexCoord(30 / 64, 38 / 64, 1 / 64, 34 / 64)
	KH_UI:calc_edge_position(mainFrame.healthFrame.edge_frame, 0, mainFrame)
	---------Power Max EDGE
	mainFrame.powerFrame.power_edge_frame = CreateFrame("Frame", nil, mainFrame.powerFrame)
	mainFrame.powerFrame.power_edge_frame:SetWidth(8)
	mainFrame.powerFrame.power_edge_frame:SetHeight(21.5)
	mainFrame.powerFrame.power_edge_frame:SetFrameLevel(2)
	mainFrame.powerFrame.power_edge_frame.texture = mainFrame.powerFrame.power_edge_frame:CreateTexture(nil, "BACKGROUND")
	mainFrame.powerFrame.power_edge_frame.texture.radius = 107
	mainFrame.powerFrame.power_edge_frame.texture:SetAllPoints()
	mainFrame.powerFrame.power_edge_frame.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2\\longbars")
	mainFrame.powerFrame.power_edge_frame.texture:SetTexCoord(39 / 64, 46 / 64, 1 / 64, 23 / 64)
	KH_UI:calc_edge_position(mainFrame.powerFrame.power_edge_frame, 0, mainFrame)
	---------Power base edge
	mainFrame.powerFrame.power_base_frame = CreateFrame("Frame", nil, mainFrame.powerFrame)
	mainFrame.powerFrame.power_base_frame:SetWidth(8)
	mainFrame.powerFrame.power_base_frame:SetHeight(21.5)
	mainFrame.powerFrame.power_base_frame:SetFrameLevel(2)
	mainFrame.powerFrame.power_base_frame.texture = mainFrame.powerFrame.power_base_frame:CreateTexture(nil, "BACKGROUND")
	mainFrame.powerFrame.power_base_frame.texture:SetAllPoints()
	mainFrame.powerFrame.power_base_frame.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2\\longbars")
	mainFrame.powerFrame.power_base_frame.texture:SetTexCoord(39 / 64, 46 / 64, 1 / 64, 23 / 64)
	mainFrame.powerFrame.power_base_frame:SetPoint("Center", -mainFrame.powerFrame.power_edge_frame.texture.radius, 0)
	mainFrame.powerFrame.power_base_frame.texture:SetRotation(math.rad(90), 0.5, 0.5)
	if (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
		mainFrame.powerFrame.power_base_frame:SetPoint("Center", mainFrame.powerFrame.power_edge_frame.texture.radius, 0)
		mainFrame.powerFrame.power_base_frame.texture:SetRotation(math.rad(-90), 0.5, 0.5)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
		mainFrame.powerFrame.power_base_frame:SetPoint("Center", mainFrame.powerFrame.power_edge_frame.texture.radius, 0)
		mainFrame.powerFrame.power_base_frame.texture:SetRotation(math.rad(90), 0.5, 0.5)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
		mainFrame.powerFrame.power_base_frame:SetPoint("Center", -mainFrame.powerFrame.power_edge_frame.texture.radius, 0)
		mainFrame.powerFrame.power_base_frame.texture:SetRotation(math.rad(-90), 0.5, 0.5)
	end
	--------------Power Val
	mainFrame.powerFrame.power_val = CreateFrame("Frame", nil, mainFrame.powerFrame)
	mainFrame.powerFrame.power_val:SetWidth(30)
	mainFrame.powerFrame.power_val:SetHeight(10)
	mainFrame.powerFrame.power_val:SetFrameLevel(1)
	mainFrame.powerFrame.power_val:SetPoint("center", -mainFrame.powerFrame.power_edge_frame.texture.radius - 25, 5)
	if (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
		mainFrame.powerFrame.power_val:SetPoint("center", mainFrame.powerFrame.power_edge_frame.texture.radius + 25, -5)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
		mainFrame.powerFrame.power_val:SetPoint("center", mainFrame.powerFrame.power_edge_frame.texture.radius + 25, 5)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
		mainFrame.powerFrame.power_val:SetPoint("center", -mainFrame.powerFrame.power_edge_frame.texture.radius - 25, -5)
	end
	mainFrame.powerFrame.power_val.texture = mainFrame.powerFrame.power_val:CreateTexture(nil, "BACKGROUND")
	mainFrame.powerFrame.power_val.texture:SetColorTexture(0, 0, 0, 1)
	mainFrame.powerFrame.power_val.texture:SetAllPoints()
	----------------INSIDE TEXT
	mainFrame.powerFrame.power_val.inside = CreateFrame("Frame", nil, mainFrame.powerFrame.power_val)
	mainFrame.powerFrame.power_val.inside:SetWidth(27)
	mainFrame.powerFrame.power_val.inside:SetHeight(6)
	mainFrame.powerFrame.power_val.inside:SetPoint("center", 0, 0)
	mainFrame.powerFrame.power_val.inside:SetFrameLevel(2)
	mainFrame.powerFrame.power_val.inside:SetScript(
		"OnUpdate",
		function(self, event, unit)
			if KH_UI_Settings[mainFrame.settings].displayPowerValue and mainFrame.powerFrame.power_val:IsVisible() == false then
				mainFrame.powerFrame.power_val:Show()
			elseif KH_UI_Settings[mainFrame.settings].displayPowerValue == false and mainFrame.powerFrame.power_val:IsVisible() then
				mainFrame.powerFrame.power_val:Hide()
			end
			if mainFrame.unitPower ~= nil then
				mainFrame.powerFrame.power_val.inside.text:SetText(format(mainFrame.unitPower))
			end
		end
	)
	mainFrame.powerFrame.power_val.inside.text =
		mainFrame.powerFrame.power_val.inside:CreateFontString(nil, nil, "SpellFont_Small")
	mainFrame.powerFrame.power_val.inside.text:SetText(format("PP"))
	mainFrame.powerFrame.power_val.inside.text:SetPoint("left", 0, 0)
	mainFrame.powerFrame.power_val.inside.texture = mainFrame.powerFrame.power_val.inside:CreateTexture(nil, "BACKGROUND")
	mainFrame.powerFrame.power_val.inside.texture:SetColorTexture(0.15, 0.15, 0.12, 1)
	mainFrame.powerFrame.power_val.inside.texture:SetAllPoints()

	--------------------Health Value----------------INSIDE TEXT
	mainFrame.healthFrame.healthVal = CreateFrame("Frame", nil, mainFrame.healthFrame)
	mainFrame.healthFrame.healthVal:SetWidth(27)
	mainFrame.healthFrame.healthVal:SetHeight(6)
	mainFrame.healthFrame.healthVal:RegisterEvent("UNIT_HEALTH_FREQUENT")
	mainFrame.healthFrame.healthVal:RegisterEvent("PLAYER_ENTERING_WORLD")
	mainFrame.healthFrame.healthVal:SetScript(
		"OnEvent",
		function(self, event, unit)
			if KH_UI_Settings[mainFrame.settings].displayHealthValue and mainFrame.healthFrame.healthVal:IsVisible() == false then
				mainFrame.healthFrame.healthVal:Show()
			elseif KH_UI_Settings[mainFrame.settings].displayHealthValue == false and mainFrame.healthFrame.healthVal:IsVisible() then
				mainFrame.healthFrame.healthVal:Hide()
			end
			if mainFrame.unitHealth ~= nil then
				mainFrame.healthFrame.healthVal.text:SetText(format(mainFrame.unitHealth))
			end
			if
				UnitClass(mainFrame.unit) == "Shaman" or UnitClass(mainFrame.unit) == "Priest" or
					UnitClass(mainFrame.unit) == "Druid" or
					mainFrame.powerToken == "MANA"
			 then
				mainFrame.enableMana = true
			else
				mainFrame.enableMana = false
			end
		end
	)
	if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
		mainFrame.healthFrame.healthVal:SetPoint("left", -34, -10)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
		mainFrame.healthFrame.healthVal:SetPoint("right", 34, 10)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
		mainFrame.healthFrame.healthVal:SetPoint("right", 34, -10)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
		mainFrame.healthFrame.healthVal:SetPoint("left", -34, 10)
	end
	mainFrame.healthFrame.healthVal:SetFrameLevel(4)
	mainFrame.healthFrame.healthVal.text = mainFrame.healthFrame.healthVal:CreateFontString(nil, nil, "SpellFont_Small")
	mainFrame.healthFrame.healthVal.text:SetText(format("HP"))
	mainFrame.healthFrame.healthVal.text:SetPoint("center", 0, 0)

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
	if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
		if (mainFrame.settings == "Party Frame") then
			mainFrame.nameFrame:SetScale(1.5)
			mainFrame.nameFrame:SetPoint("left", -20, -20)
		elseif (mainFrame.settings == "Player Frame") then
			mainFrame.nameFrame:SetPoint("left", -20, -30)
		end
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
		if (mainFrame.settings == "Party Frame") then
			mainFrame.nameFrame:SetScale(1.5)
			mainFrame.nameFrame:SetPoint("right", 20, 20)
		elseif (mainFrame.settings == "Player Frame") then
			mainFrame.nameFrame:SetPoint("right", 20, 30)
		end
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
		if (mainFrame.settings == "Party Frame") then
			mainFrame.nameFrame:SetScale(1.5)
			mainFrame.nameFrame:SetPoint("right", 20, -20)
		elseif (mainFrame.settings == "Player Frame") then
			mainFrame.nameFrame:SetPoint("right", 20, -30)
		end
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
		if (mainFrame.settings == "Party Frame") then
			mainFrame.nameFrame:SetScale(1.5)
			mainFrame.nameFrame:SetPoint("left", -20, 20)
		elseif (mainFrame.settings == "Player Frame") then
			mainFrame.nameFrame:SetPoint("left", -20, 30)
		end
	end
	mainFrame.nameFrame:SetFrameLevel(4)
	mainFrame.nameFrame.text = mainFrame.nameFrame:CreateFontString(nil, nil, "GameFontNormal")
	mainFrame.nameFrame.text:SetText(format("NAME"))
	if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
		mainFrame.nameFrame.text:SetPoint("right", 0, 0)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
		mainFrame.nameFrame.text:SetPoint("left", 0, 0)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
		mainFrame.nameFrame.text:SetPoint("left", 0, 0)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
		mainFrame.nameFrame.text:SetPoint("right", 0, 0)
	end
end

local function create_health_stretch(mainFrame)
	mainFrame.healthFrame.long_bar = CreateFrame("Frame", nil, mainFrame.healthFrame)
	local maxHealth = mainFrame.unitHealthMax
	if maxHealth > KH_UI_Settings[mainFrame.settings].healthLengthMax then
		maxHealth = KH_UI_Settings[mainFrame.settings].healthLengthMax
	end
	mainFrame.healthFrame.long_bar.length =
		(maxHealth - KH_UI_Settings[mainFrame.settings].ringMaxHealth) /
		KH_UI_Settings[mainFrame.settings].longBarHealthLengthRate
	if mainFrame.healthFrame.long_bar.length < 0 then
		mainFrame.healthFrame.long_bar.length = 0
	end
	------BACK
	mainFrame.healthFrame.long_bar:SetSize(math.ceil(mainFrame.healthFrame.long_bar.length), 33)
	mainFrame.healthFrame.long_bar:SetFrameLevel(16)
	if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
		mainFrame.healthFrame.long_bar:SetPoint(
			"LEFT",
			-mainFrame.healthFrame.long_bar.length + 64,
			-mainFrame.healthFrame.edge_frame.texture.radius - 0
		)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
		mainFrame.healthFrame.long_bar:SetPoint("LEFT", 64, mainFrame.healthFrame.edge_frame.texture.radius - 0)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
		mainFrame.healthFrame.long_bar:SetPoint("LEFT", 64, mainFrame.healthFrame.edge_frame.texture.radius - 0)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
		mainFrame.healthFrame.long_bar:SetPoint("LEFT", 64, -mainFrame.healthFrame.edge_frame.texture.radius - 0)
	end
	mainFrame.healthFrame.long_bar.texture = mainFrame.healthFrame.long_bar:CreateTexture(nil, "BACKGROUND")
	mainFrame.healthFrame.long_bar.texture:SetAllPoints()
	mainFrame.healthFrame.long_bar.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2\\longbars")
	mainFrame.healthFrame.long_bar.texture:SetTexCoord(1 / 64, 1 / 64, 1 / 64, 34 / 64)
	------Low HP
	mainFrame.healthFrame.long_bar.lowHealth = CreateFrame("Frame", nil, mainFrame.healthFrame)
	mainFrame.healthFrame.long_bar.lowHealth:SetFrameLevel(19)
	mainFrame.healthFrame.long_bar.lowHealth.texture =
		mainFrame.healthFrame.long_bar.lowHealth:CreateTexture(nil, "BACKGROUND")
	mainFrame.healthFrame.long_bar.lowHealth.texture:SetAllPoints()
	mainFrame.healthFrame.long_bar.lowHealth.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2\\longbars")
	mainFrame.healthFrame.long_bar.lowHealth.texture:SetVertexColor(
		mainFrame.ring_table[8].segment.color.r,
		mainFrame.ring_table[8].segment.color.g,
		mainFrame.ring_table[8].segment.color.b,
		mainFrame.ring_table[8].segment.color.a
	)
	mainFrame.healthFrame.long_bar.lowHealth.texture:SetTexCoord(13 / 64, 13 / 64, 1 / 64, 25 / 64)

	------HP
	mainFrame.healthFrame.long_bar.health = CreateFrame("Frame", nil, mainFrame.healthFrame)
	mainFrame.healthFrame.long_bar.health:SetFrameLevel(20)
	mainFrame.healthFrame.long_bar.health.texture = mainFrame.healthFrame.long_bar.health:CreateTexture(nil, "BACKGROUND")
	mainFrame.healthFrame.long_bar.health.texture:SetAllPoints()
	mainFrame.healthFrame.long_bar.health.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2\\longbars")
	mainFrame.healthFrame.long_bar.health.texture:SetVertexColor(
		mainFrame.ring_table[1].segment.color.r,
		mainFrame.ring_table[1].segment.color.g,
		mainFrame.ring_table[1].segment.color.b,
		mainFrame.ring_table[1].segment.color.a
	)
	mainFrame.healthFrame.long_bar.health.texture:SetTexCoord(13 / 64, 13 / 64, 1 / 64, 25 / 64)
	------LAST HP
	mainFrame.healthFrame.long_bar.healthLast = CreateFrame("Frame", nil, mainFrame.healthFrame)
	mainFrame.healthFrame.long_bar.healthLast:SetFrameLevel(19)
	mainFrame.healthFrame.long_bar.healthLast.texture =
		mainFrame.healthFrame.long_bar.healthLast:CreateTexture(nil, "BACKGROUND")
	mainFrame.healthFrame.long_bar.healthLast.texture:SetAllPoints()
	mainFrame.healthFrame.long_bar.healthLast.texture:SetTexture(
		"Interface\\AddOns\\KHUnitframes\\textures\\KH2\\longbars"
	)
	mainFrame.healthFrame.long_bar.healthLast.texture:SetVertexColor(
		mainFrame.ring_table[3].segment.color.r,
		mainFrame.ring_table[3].segment.color.g,
		mainFrame.ring_table[3].segment.color.b,
		mainFrame.ring_table[3].segment.color.a
	)
	mainFrame.healthFrame.long_bar.healthLast.texture:SetTexCoord(13 / 64, 13 / 64, 1 / 64, 25 / 64)
	------EDGE
	mainFrame.healthFrame.long_bar.edge = CreateFrame("Frame", nil, mainFrame.healthFrame)
	mainFrame.healthFrame.long_bar.edge:SetSize(5, 33)
	mainFrame.healthFrame.long_bar.edge:SetFrameLevel(19)
	if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
		mainFrame.healthFrame.long_bar.edge:SetPoint(
			"LEFT",
			-mainFrame.healthFrame.long_bar.length + 64,
			-mainFrame.healthFrame.edge_frame.texture.radius - 0.5
		)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
		mainFrame.healthFrame.long_bar.edge:SetPoint("LEFT", 64, mainFrame.healthFrame.edge_frame.texture.radius + 0.5)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
		mainFrame.healthFrame.long_bar.edge:SetPoint(
			"LEFT",
			-mainFrame.healthFrame.long_bar.length + 64,
			mainFrame.healthFrame.edge_frame.texture.radius + 0.5
		)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
		mainFrame.healthFrame.long_bar.edge:SetPoint("LEFT", 64, -mainFrame.healthFrame.edge_frame.texture.radius - 0.5)
	end
	mainFrame.healthFrame.long_bar.edge.texture = mainFrame.healthFrame.long_bar.edge:CreateTexture(nil, "BACKGROUND")
	mainFrame.healthFrame.long_bar.edge.texture:SetAllPoints()
	mainFrame.healthFrame.long_bar.edge.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2\\longbars")
	mainFrame.healthFrame.long_bar.edge.texture:SetTexCoord(5 / 64, 10 / 64, 1 / 64, 34 / 64)
	if
		(KH_UI_Settings[mainFrame.settings].orientation == "Top Left") or
			(KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left")
	 then
		mainFrame.healthFrame.long_bar.edge.texture:SetRotation(math.rad(180))
	end
end
---------------------
-- Updates
---------------------

local function calc_mana_bar(mainFrame)
	if mainFrame.enableMana == false then
		return
	end
	local mana, maxMana, mult, backFrame, barFrame, edgeFrame =
		mainFrame.unitMana,
		mainFrame.unitManaMax,
		1,
		mainFrame.manaFrame.back,
		mainFrame.manaFrame.mana,
		mainFrame.manaFrame.edge

	if maxMana > KH_UI_Settings[mainFrame.settings].manaLengthMax then
		mult = maxMana / KH_UI_Settings[mainFrame.settings].manaLengthMax
		maxMana = KH_UI_Settings[mainFrame.settings].manaLengthMax
	else
		mult = 1
	end

	if mainFrame.unitMana ~= nil then
		mainFrame.manaFrame.manaVal.text:SetText(format(mainFrame.unitMana))
	end

	backFrame.length = (maxMana / KH_UI_Settings[mainFrame.settings].manaLengthRate)
	barFrame.length = (mana / KH_UI_Settings[mainFrame.settings].manaLengthRate / mult)

	backFrame:SetWidth(backFrame.length)
	if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
		backFrame:SetPoint("topright", -58, -0)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
		backFrame:SetPoint("topleft", 58, -0)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
		backFrame:SetPoint("topright", -58, -0)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
		backFrame:SetPoint("topleft", 58, -0)
	end

	barFrame:SetWidth(barFrame.length)
	if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
		barFrame:SetPoint("topright", -58, -5)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
		barFrame:SetPoint("topleft", 58, -5)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
		barFrame:SetPoint("topright", -58, -5)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
		barFrame:SetPoint("topleft", 58, -5)
	end

	if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
		edgeFrame:SetPoint("topright", -58 - backFrame.length, 0)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
		edgeFrame:SetPoint("topleft", 58 + backFrame.length, 0)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
		edgeFrame:SetPoint("topright", -58 - backFrame.length, 0)
	elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
		edgeFrame:SetPoint("topleft", 58 + backFrame.length, 0)
	end
end

local function calc_health_stretch(mainFrame)
	local maxHealth = mainFrame.unitHealthMax
	local health = mainFrame.unitHealth * mainFrame.healthMaxMult
	local lastHealth = mainFrame.damageHealth * mainFrame.healthMaxMult
	if maxHealth > KH_UI_Settings[mainFrame.settings].healthLengthMax then
		maxHealth = KH_UI_Settings[mainFrame.settings].healthLengthMax
	end
	mainFrame.healthFrame.long_bar.length =
		((maxHealth - KH_UI_Settings[mainFrame.settings].ringMaxHealth) /
		KH_UI_Settings[mainFrame.settings].longBarHealthLengthRate)
	mainFrame.healthFrame.long_bar.lowHealth.length =
		((maxHealth - KH_UI_Settings[mainFrame.settings].ringMaxHealth) /
		KH_UI_Settings[mainFrame.settings].longBarHealthLengthRate)
	mainFrame.healthFrame.long_bar.health.length =
		((health - KH_UI_Settings[mainFrame.settings].ringMaxHealth) /
		KH_UI_Settings[mainFrame.settings].longBarHealthLengthRate)
	mainFrame.healthFrame.long_bar.healthLast.length =
		((lastHealth - KH_UI_Settings[mainFrame.settings].ringMaxHealth) /
		KH_UI_Settings[mainFrame.settings].longBarHealthLengthRate)
	if mainFrame.healthFrame.long_bar.length <= 0 then
		mainFrame.healthFrame.long_bar:Hide()
		mainFrame.healthFrame.long_bar.edge:Hide()
	else
		mainFrame.healthFrame.long_bar:Show()
		mainFrame.healthFrame.long_bar.edge:Show()
		mainFrame.healthFrame.long_bar:SetSize(mainFrame.healthFrame.long_bar.length, 33)
		if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
			mainFrame.healthFrame.long_bar:SetPoint(
				"LEFT",
				-mainFrame.healthFrame.long_bar.length + 64,
				-mainFrame.healthFrame.edge_frame.texture.radius - 0.5
			)
			mainFrame.healthFrame.long_bar.edge:SetPoint(
				"LEFT",
				-mainFrame.healthFrame.long_bar.length + 59,
				-mainFrame.healthFrame.edge_frame.texture.radius - 0.5
			)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
			mainFrame.healthFrame.long_bar:SetPoint("Left", 64, mainFrame.healthFrame.edge_frame.texture.radius + 0.5)
			mainFrame.healthFrame.long_bar.edge:SetPoint(
				"Left",
				mainFrame.healthFrame.long_bar.length + 64,
				mainFrame.healthFrame.edge_frame.texture.radius + 0.5
			)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
			mainFrame.healthFrame.long_bar:SetPoint(
				"LEFT",
				-mainFrame.healthFrame.long_bar.length + 64,
				mainFrame.healthFrame.edge_frame.texture.radius + 0.5
			)
			mainFrame.healthFrame.long_bar.edge:SetPoint(
				"LEFT",
				-mainFrame.healthFrame.long_bar.length + 59,
				mainFrame.healthFrame.edge_frame.texture.radius + 0.5
			)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
			mainFrame.healthFrame.long_bar:SetPoint("Left", 64, -mainFrame.healthFrame.edge_frame.texture.radius - 0.5)
			mainFrame.healthFrame.long_bar.edge:SetPoint(
				"Left",
				mainFrame.healthFrame.long_bar.length + 64,
				-mainFrame.healthFrame.edge_frame.texture.radius - 0.5
			)
		end
	end
	if (mainFrame.healthFrame.long_bar.lowHealth.length > 0) then
		mainFrame.healthFrame.long_bar.lowHealth:SetSize(mainFrame.healthFrame.long_bar.lowHealth.length, 25)
		if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
			mainFrame.healthFrame.long_bar.lowHealth:SetPoint(
				"LEFT",
				-mainFrame.healthFrame.long_bar.lowHealth.length + 64,
				-mainFrame.healthFrame.edge_frame.texture.radius - 0.5
			)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
			mainFrame.healthFrame.long_bar.lowHealth:SetPoint("Left", 64, mainFrame.healthFrame.edge_frame.texture.radius + 0.5)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
			mainFrame.healthFrame.long_bar.lowHealth:SetPoint(
				"Left",
				-mainFrame.healthFrame.long_bar.lowHealth.length + 64,
				mainFrame.healthFrame.edge_frame.texture.radius + 0.5
			)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
			mainFrame.healthFrame.long_bar.lowHealth:SetPoint("Left", 64, -mainFrame.healthFrame.edge_frame.texture.radius - 0.5)
		end
		mainFrame.healthFrame.long_bar.lowHealth:Show()
		mainFrame.healthFrame.long_bar.lowHealth:SetAlpha(mainFrame.lowHealthAlpha)
	else
		mainFrame.healthFrame.long_bar.lowHealth:Hide()
	end
	if (mainFrame.healthFrame.long_bar.health.length > 0) then
		mainFrame.healthFrame.long_bar.health:SetSize(mainFrame.healthFrame.long_bar.health.length, 25)
		if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
			mainFrame.healthFrame.long_bar.health:SetPoint(
				"LEFT",
				-mainFrame.healthFrame.long_bar.health.length + 64,
				-mainFrame.healthFrame.edge_frame.texture.radius - 0.5
			)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
			mainFrame.healthFrame.long_bar.health:SetPoint("Left", 64, mainFrame.healthFrame.edge_frame.texture.radius + 0.5)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
			mainFrame.healthFrame.long_bar.health:SetPoint(
				"Left",
				-mainFrame.healthFrame.long_bar.health.length + 64,
				mainFrame.healthFrame.edge_frame.texture.radius + 0.5
			)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
			mainFrame.healthFrame.long_bar.health:SetPoint("Left", 64, -mainFrame.healthFrame.edge_frame.texture.radius - 0.5)
		end
		mainFrame.healthFrame.long_bar.health:Show()
	else
		mainFrame.healthFrame.long_bar.health:Hide()
	end
	if (mainFrame.healthFrame.long_bar.healthLast.length > 0) then
		mainFrame.healthFrame.long_bar.healthLast:SetSize(mainFrame.healthFrame.long_bar.healthLast.length, 25)
		if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
			mainFrame.healthFrame.long_bar.healthLast:SetPoint(
				"LEFT",
				-mainFrame.healthFrame.long_bar.healthLast.length + 64,
				-mainFrame.healthFrame.edge_frame.texture.radius - 0.5
			)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
			mainFrame.healthFrame.long_bar.healthLast:SetPoint("LEFT", 64, mainFrame.healthFrame.edge_frame.texture.radius + 0.5)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
			mainFrame.healthFrame.long_bar.healthLast:SetPoint(
				"LEFT",
				-mainFrame.healthFrame.long_bar.healthLast.length + 64,
				mainFrame.healthFrame.edge_frame.texture.radius + 0.5
			)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
			mainFrame.healthFrame.long_bar.healthLast:SetPoint(
				"LEFT",
				64,
				-mainFrame.healthFrame.edge_frame.texture.radius - 0.5
			)
		end
		mainFrame.healthFrame.long_bar.healthLast:Show()
	else
		mainFrame.healthFrame.long_bar.healthLast:Hide()
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
				self.healthFrame.long_bar.healthLast.texture:SetAlpha(self.ring_frames[i].alpha)
				self.portrait.redTexture:SetAlpha(self.ring_frames[i].alpha)
			end
			self.ring_frames[i]:SetAlpha(self.ring_frames[i].alpha)
			self.ring_frames[8]:SetAlpha(self.lowHealthAlpha)
		end
	end

	self.healthFrame:ClearAllPoints()
	self.healthFrame:SetPoint("CENTER", 0, self.offsety - 0.5)
	self.powerFrame:ClearAllPoints()
	self.powerFrame:SetPoint("CENTER", 0, self.offsety - 0.5)
	self.manaFrame:ClearAllPoints()
	self.manaFrame:SetPoint("CENTER", 0, self.offsety - 0.5)
	--self.unitHealthMax = 2500;
	KH_UI:calc_edge_position(
		self.healthFrame.edge_frame,
		round(self.unitHealthMax / KH_UI_Settings[self.settings].ringMaxHealth * 0.75 * self.healthMaxMult, 4),
		self
	)
	KH_UI:calc_edge_position(
		self.powerFrame.power_edge_frame,
		round(self.unitPowerMax / KH_UI_Settings[self.settings].ringMaxPower * 0.75, 4),
		self
	)
	calc_health_stretch(self)
end

function KH_UI:New_KH2Unitframe(unit, setting)
	------------------------
	--Local Functions-------
	------------------------
	local function create_mana_bar(mainFrame)
		---------BASE
		mainFrame.manaFrame.base = CreateFrame("Frame", nil, mainFrame.manaFrame)
		mainFrame.manaFrame.base:SetWidth(58)
		mainFrame.manaFrame.base:SetHeight(24)
		mainFrame.manaFrame.base:SetFrameLevel(25)
		mainFrame.manaFrame.base.texture = mainFrame.manaFrame.base:CreateTexture(nil, "BACKGROUND")
		mainFrame.manaFrame.base.texture:SetAllPoints()
		mainFrame.manaFrame.base.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2\\longbars")
		if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
			mainFrame.manaFrame.base:SetPoint("bottom", -35, -16)
			mainFrame.manaFrame.base.texture:SetTexCoord(0.25 / 64, 57.75 / 64, 35 / 64, 58 / 64)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
			mainFrame.manaFrame.base:SetPoint("top", 35, 17)
			mainFrame.manaFrame.base.texture:SetTexCoord(4.25 / 64, 61.75 / 64, 35 / 64, 58 / 64)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
			mainFrame.manaFrame.base:SetPoint("top", -35, 17)
			mainFrame.manaFrame.base.texture:SetTexCoord(0.25 / 64, 57.75 / 64, 35 / 64, 58 / 64)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
			mainFrame.manaFrame.base:SetPoint("bottom", 35, -16)
			mainFrame.manaFrame.base.texture:SetTexCoord(4.25 / 64, 61.75 / 64, 35 / 64, 58 / 64)
		end
		---------BASE EDGE
		mainFrame.manaFrame.baseEdge = CreateFrame("Frame", nil, mainFrame.manaFrame.base)
		mainFrame.manaFrame.baseEdge:SetWidth(5)
		mainFrame.manaFrame.baseEdge:SetHeight(24)
		mainFrame.manaFrame.baseEdge:SetFrameLevel(25)
		mainFrame.manaFrame.baseEdge.texture = mainFrame.manaFrame.baseEdge:CreateTexture(nil, "BACKGROUND")
		mainFrame.manaFrame.baseEdge.texture:SetAllPoints()
		mainFrame.manaFrame.baseEdge.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2\\longbars")
		if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
			mainFrame.manaFrame.baseEdge:SetPoint("topright", 5, 0)
			mainFrame.manaFrame.baseEdge.texture:SetTexCoord(57.5 / 64, 61.5 / 64, 1.25 / 64, 23 / 64)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
			mainFrame.manaFrame.baseEdge:SetPoint("topleft", -5, 0)
			mainFrame.manaFrame.baseEdge.texture:SetTexCoord(50.5 / 64, 55.5 / 64, 1.25 / 64, 23 / 64)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
			mainFrame.manaFrame.baseEdge:SetPoint("topright", 5, 0)
			mainFrame.manaFrame.baseEdge.texture:SetTexCoord(57.5 / 64, 61.5 / 64, 1.25 / 64, 23 / 64)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
			mainFrame.manaFrame.baseEdge:SetPoint("topleft", -5, 0)
			mainFrame.manaFrame.baseEdge.texture:SetTexCoord(50.5 / 64, 55.5 / 64, 1.25 / 64, 23 / 64)
		end
		---------BACK BAR
		mainFrame.manaFrame.back = CreateFrame("Frame", nil, mainFrame.manaFrame.base)
		mainFrame.manaFrame.back.length = 0
		mainFrame.manaFrame.back:SetWidth(305)
		mainFrame.manaFrame.back:SetHeight(24)
		mainFrame.manaFrame.back:SetFrameLevel(26)
		mainFrame.manaFrame.back:SetScript(
			"OnEvent",
			function(self, event, unit)
				if
					((event == "UNIT_POWER_UPDATE" or event == "UNIT_DISPLAYPOWER" or event == "UNIT_MAXPOWER") and
						unit == mainFrame.unit) or
						event == "PLAYER_ENTERING_WORLD"
				 then
					mainFrame.unitManaMax = UnitPowerMax(mainFrame.unit, 0)
					calc_mana_bar(mainFrame)
				end
			end
		)
		mainFrame.manaFrame.back:RegisterEvent("UNIT_POWER_UPDATE")
		mainFrame.manaFrame.back:RegisterEvent("UNIT_DISPLAYPOWER")
		mainFrame.manaFrame.back:RegisterEvent("UNIT_MAXPOWER")
		mainFrame.manaFrame.back:RegisterEvent("PLAYER_ENTERING_WORLD")
		mainFrame.manaFrame.back.texture = mainFrame.manaFrame.back:CreateTexture(nil, "BACKGROUND")
		mainFrame.manaFrame.back.texture:SetAllPoints()
		mainFrame.manaFrame.back.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2\\longbars")
		mainFrame.manaFrame.back.texture:SetTexCoord(23 / 64, 24 / 64, 1.25 / 64, 24.5 / 64)
		---------MANA
		mainFrame.manaFrame.mana = CreateFrame("Frame", nil, mainFrame.manaFrame.base)
		mainFrame.manaFrame.mana.length = 0
		mainFrame.manaFrame.mana.lastUpdate = 0
		mainFrame.manaFrame.mana:SetWidth(305)
		mainFrame.manaFrame.mana:SetHeight(14.1)
		mainFrame.manaFrame.mana:SetFrameLevel(27)
		mainFrame.manaFrame.mana:SetScript(
			"OnUpdate",
			function(self, elapsed)
				self.lastUpdate = self.lastUpdate + elapsed
				if (self.lastUpdate >= 0.05) then
					self.lastUpdate = self.lastUpdate - 0.05
					mainFrame.unitMana = UnitPower(mainFrame.unit, 0)
					calc_mana_bar(mainFrame)
				end
			end
		)
		mainFrame.manaFrame.mana.texture = mainFrame.manaFrame.mana:CreateTexture(nil, "BACKGROUND")
		mainFrame.manaFrame.mana.texture:SetAllPoints()
		mainFrame.manaFrame.mana.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2\\longbars")
		mainFrame.manaFrame.mana.texture:SetTexCoord(27 / 64, 27 / 64, 6.25 / 64, 19.5 / 64)
		---------EDGE
		mainFrame.manaFrame.edge = CreateFrame("Frame", nil, mainFrame.manaFrame.base)
		mainFrame.manaFrame.edge:SetWidth(5)
		mainFrame.manaFrame.edge:SetHeight(24)
		mainFrame.manaFrame.edge:SetFrameLevel(26)
		mainFrame.manaFrame.edge.texture = mainFrame.manaFrame.edge:CreateTexture(nil, "BACKGROUND")
		mainFrame.manaFrame.edge.texture:SetAllPoints()
		mainFrame.manaFrame.edge.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2\\longbars")

		if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
			mainFrame.manaFrame.edge.texture:SetTexCoord(16.25 / 64, 20.75 / 64, 1.25 / 64, 24.5 / 64)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
			mainFrame.manaFrame.edge.texture:SetTexCoord(44.25 / 64, 48.75 / 64, 1.25 / 64, 24.5 / 64)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
			mainFrame.manaFrame.edge.texture:SetTexCoord(16.25 / 64, 20.75 / 64, 1.25 / 64, 24.5 / 64)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
			mainFrame.manaFrame.edge.texture:SetTexCoord(44.25 / 64, 48.75 / 64, 1.25 / 64, 24.5 / 64)
		end
		--------------------Mana Value----------------INSIDE TEXT
		mainFrame.manaFrame.manaVal = CreateFrame("Frame", nil, mainFrame.manaFrame.base)
		mainFrame.manaFrame.manaVal:SetWidth(27)
		mainFrame.manaFrame.manaVal:SetHeight(6)
		mainFrame.manaFrame.manaVal:RegisterEvent("UNIT_POWER_UPDATE")
		mainFrame.manaFrame.manaVal:RegisterEvent("PLAYER_ENTERING_WORLD")
		mainFrame.manaFrame.manaVal:SetScript(
			"OnEvent",
			function(self, event, unit)
				if KH_UI_Settings[mainFrame.settings].displayManaValue and mainFrame.manaFrame.manaVal:IsVisible() == false then
					mainFrame.manaFrame.manaVal:Show()
				elseif KH_UI_Settings[mainFrame.settings].displayManaValue == false and mainFrame.manaFrame.manaVal:IsVisible() then
					mainFrame.manaFrame.manaVal:Hide()
				end
			end
		)
		if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
			mainFrame.manaFrame.manaVal:SetPoint("topleft", -25, 5)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
			mainFrame.manaFrame.manaVal:SetPoint("bottomright", 25, -5)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
			mainFrame.manaFrame.manaVal:SetPoint("topright", 25, 5)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
			mainFrame.manaFrame.manaVal:SetPoint("bottomleft", -25, -5)
		end
		mainFrame.manaFrame.manaVal:SetFrameLevel(27)
		mainFrame.manaFrame.manaVal.text = mainFrame.manaFrame.manaVal:CreateFontString(nil, nil, "SpellFont_Small")
		mainFrame.manaFrame.manaVal.text:SetText(format("MP"))
		if (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Right") then
			mainFrame.manaFrame.manaVal.text:SetPoint("right", 0, 0)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
			mainFrame.manaFrame.manaVal.text:SetPoint("left", 0, 0)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
			mainFrame.manaFrame.manaVal.text:SetPoint("left", 0, 0)
		elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
			mainFrame.manaFrame.manaVal.text:SetPoint("right", 0, 0)
		end
	end

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
		f.healthFrame:SetScale(f.scale)
		f.powerFrame:SetScale(f.scale)
		f.manaFrame:SetScale(f.scale)
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
			if
				f.ring_frames[i].ringtype == "health" or f.ring_frames[i].ringtype == "lasthealth" or
					f.ring_frames[i].ringtype == "maxhealth" or
					f.ring_frames[i].ringtype == "maxhealthbg"
			 then
				KH_UI:calc_ring_health(f.ring_frames[i], f.ring_table[i], f.unit, f.ring_frames[i].ringtype, f)
			end
		end
	end

	f.Update_Power = function()
		local powerType, powerToken, altR, altG, altB = UnitPowerType(f.unit)
		f.UnitPowerMax = UnitPowerMax(f.unit, powerType)
		for i in ipairs(f.ring_table) do
			if (f.ring_frames[i].ringtype == "power" or f.ring_frames[i].ringtype == "maxpower") then
				KH_UI:calc_ring_power(f.ring_frames[i], f.ring_table[i], f.unit, f.ring_frames[i].ringtype, f)
			end
		end
		if
			(UnitClass(f.unit) == "Shaman" or UnitClass(f.unit) == "Priest" or UnitClass(f.unit) == "Druid" or
				f.powerToken == "MANA")
		 then
			f.enableMana = true
			f.manaFrame:Show()
		else
			f.enableMana = false
			f.manaFrame:Hide()
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
	if
		UnitClass(f.unit) == "Shaman" or UnitClass(f.unit) == "Priest" or UnitClass(f.unit) == "Druid" or
			f.powerToken == "MANA"
	 then
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
	bgtex:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\KH2\\ring_bg")
	bgtex:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1)
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

	create_ring_pretties(f)
	create_health_stretch(f)
	KH_UI:create_portrait(f)
	create_mana_bar(f)

	f:RegisterEvent("UNIT_POWER_UPDATE")
	f:RegisterEvent("UNIT_MANA")
	f:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	f:RegisterEvent("PLAYER_ENTERING_WORLD")

	f:SetScript(
		"OnEvent",
		function(self, event, arg1)
			if not (event == "GROUP_ROSTER_UPDATE" or event == "UNIT_CONNECTION" or event == "UNIT_OTHER_PARTY_CHANGED") then
			--Place holder
			end

			local powerType, powerToken, altR, altG, altB = UnitPowerType(f.unit)
			if (powerToken == "MANA") then
				f.powerFrame:Hide()
				return
			else
				f.powerFrame:Show()
			end

			if (f.unit == "player") then
				if
					(UnitClass(f.unit) == "Shaman" or UnitClass(f.unit) == "Priest" or UnitClass(f.unit) == "Druid" or
						f.powerToken == "MANA")
				 then
					f.enableMana = true
					f.manaFrame:Show()
				else
					f.enableMana = false
					f.manaFrame:Hide()
				end
			else
				if (f.powerToken == "MANA") then
					f.enableMana = true
					f.manaFrame:Show()
				else
					f.enableMana = false
					f.manaFrame:Hide()
				end
			end
		end
	)

	if f.enableMana == false then
		f.manaFrame:Hide()
	end

	return f
end
