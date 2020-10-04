--[[-------------------------------------------------------------------------
    rRingThing
	Copyright (c) 2009, zork
    All rights reserved.
  ---------------------------------------------------------------------------]]
---------------------
-- Var init
---------------------
-- Globals
KH_UI = CreateFrame("Frame", nil, UIParent)

-----------------------
-- CONFIG
-----------------------
KH_UI_Settings_Defaults = {
    ["Player Frame"] = {
        ringMaxHealth = 2000,
        longBarHealthLengthRate = 200,
        healthLengthMax = 5000,
        displayHealthValue = true,
        maxBars = 20,
        manaLengthRate = 100,
        manaLengthMax = 5360,
        displayManaValue = true,
        ringMaxPower = 3000,
        displayPowerValue = true,
        scale = 1,
        style = "KH2",
        enabled = true,
        blizzardEnabled = true,
        movable = true,
        framex = 50,
        framey = -40,
        orientation = "Top Left"
    },
    ["Party Frame"] = {
        ringMaxHealth = 2000,
        longBarHealthLengthRate = 200,
        healthLengthMax = 5000,
        displayHealthValue = true,
        maxBars = 20,
        manaLengthRate = 100,
        manaLengthMax = 5360,
        displayManaValue = true,
        ringMaxPower = 3000,
        displayPowerValue = true,
        scale = 0.5,
        style = "KH2 Party",
        enabled = true,
        hideNotInParty = false,
        blizzardEnabled = true,
        movable = true,
        individualSettings = {
            ["party1"] = {
                framex = 50,
                framey = -450
            },
            ["party2"] = {
                framex = 50,
                framey = -625
            },
            ["party3"] = {
                framex = 50,
                framey = -800
            },
            ["party4"] = {
                framex = 50,
                framey = -975
            }
        },
        orientation = "Bottom Left"
    },
    ["Target Frame"] = {
        ringMaxHealth = 2000,
        longBarHealthLengthRate = 100,
        healthLengthMax = 2000,
        displayHealthValue = true,
        maxBars = 20,
        manaLengthRate = 80,
        manaLengthMax = 3000,
        displayManaValue = true,
        ringMaxPower = 3000,
        displayPowerValue = true,
        scale = 1,
        style = "KH2 Target",
        enabled = true,
        blizzardEnabled = true,
        movable = true,
        framex = 260,
        framey = -40,
        orientation = "Top Left"
    },
    ["ToT Frame"] = {
        ringMaxHealth = 2000,
        longBarHealthLengthRate = 200,
        healthLengthMax = 2000,
        displayHealthValue = true,
        maxBars = 20,
        manaLengthRate = 150,
        manaLengthMax = 3000,
        displayManaValue = true,
        ringMaxPower = 3000,
        displayPowerValue = true,
        scale = 1,
        style = "Target of Target",
        enabled = true,
        blizzardEnabled = true,
        movable = true,
        framex = 260,
        framey = -80,
        orientation = "Top Left"
    }
}
if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
    KH_UI_Settings_Defaults = {
        ["Player Frame"] = {
            ringMaxHealth = 10000,
            longBarHealthLengthRate = 40,
            healthLengthMax = 25000,
            displayHealthValue = true,
            maxBars = 20,
            manaLengthRate = 100,
            manaLengthMax = 5360,
            displayManaValue = true,
            ringMaxPower = 3000,
            displayPowerValue = true,
            scale = 1,
            style = "KH2",
            enabled = true,
            blizzardEnabled = true,
            movable = true,
            framex = 50,
            framey = -40,
            orientation = "Top Left"
        },
        ["Party Frame"] = {
            ringMaxHealth = 10000,
            longBarHealthLengthRate = 40,
            healthLengthMax = 25000,
            displayHealthValue = true,
            maxBars = 20,
            manaLengthRate = 100,
            manaLengthMax = 5360,
            displayManaValue = true,
            ringMaxPower = 3000,
            displayPowerValue = true,
            scale = 1,
            style = "KH2",
            enabled = true,
            blizzardEnabled = true,
            movable = true,
            individualSettings = {
                ["party1"] = {
                    framex = 20,
                    framey = -200
                },
                ["party2"] = {
                    framex = 20,
                    framey = -325
                },
                ["party3"] = {
                    framex = 20,
                    framey = -450
                },
                ["party4"] = {
                    framex = 20,
                    framey = -575
                }
            },
            orientation = "Bottom Left"
        },
        ["Target Frame"] = {
            ringMaxHealth = 2000,
            longBarHealthLengthRate = 54,
            healthLengthMax = 4500,
            displayHealthValue = true,
            maxBars = 25,
            manaLengthRate = 81,
            manaLengthMax = 3000,
            displayManaValue = true,
            ringMaxPower = 3000,
            displayPowerValue = true,
            scale = 1,
            style = "KH2 Target",
            enabled = true,
            blizzardEnabled = true,
            movable = true,
            framex = 260,
            framey = -40,
            orientation = "Top Left"
        },
        ["ToT Frame"] = {
            ringMaxHealth = 2000,
            longBarHealthLengthRate = 200,
            healthLengthMax = 2000,
            displayHealthValue = true,
            maxBars = 20,
            manaLengthRate = 150,
            manaLengthMax = 3000,
            displayManaValue = true,
            ringMaxPower = 3000,
            displayPowerValue = true,
            scale = 1,
            style = "Target of Target",
            enabled = true,
            blizzardEnabled = true,
            movable = true,
            framex = 260,
            framey = -80,
            orientation = "Top Left"
        }
    }
end
---------------------
-- FUNCTIONS
---------------------

function KH_UI:FormatNumber(val)
    formattedVal = ""

    if val >= 1000000000 then
        formattedVal = format("%.2fb", val / 1000000000)
    elseif val >= 100000000 then
        formattedVal = format("%.0fm", val / 1000000)
    elseif val >= 10000000 then
        formattedVal = format("%.1fm", val / 1000000)
    elseif val >= 1000000 then
        formattedVal = format("%.2fm", val / 1000000)
    elseif val >= 100000 then
        formattedVal = format("%.0fk", val / 1000)
    elseif val >= 10000 then
        formattedVal = format("%.1fk", val / 1000)
    else
        formattedVal = format(val)
    end

    return formattedVal
end

function KH_UI:CreateImageFrame(width, height, parent, anchor, x, y, level, texCoord, texture)
    frame = CreateFrame("Frame", nil, parent)
    frame:SetWidth(width)
    frame:SetHeight(height)
    frame:SetFrameLevel(level)
    frame:SetPoint(anchor, x, y)
    frame.texture = frame:CreateTexture(nil, "BACKGROUND")
    frame.texture:SetAllPoints()
    frame.texture:SetTexture(texture)
    frame.texture:SetTexCoord(texCoord.x, texCoord.xw, texCoord.y, texCoord.yh)
    return frame
end

function KH_UI:CreateColorFrame(width, height, parent, anchor, x, y, level, color)
    frame = CreateFrame("Frame", nil, parent)
    frame:SetWidth(width)
    frame:SetHeight(height)
    frame:SetFrameLevel(level)
    frame:SetPoint(anchor, x, y)
    frame.texture = frame:CreateTexture(nil, "BACKGROUND")
    frame.texture:SetAllPoints()
    frame.texture:SetColorTexture(color.r, color.g, color.b, color.a)
    return frame
end

function KH_UI:CreateTextFrame(text, x, y, w, h, scale, align, parent, anchor, level, font)
    frame = CreateFrame("Frame", nil, parent)
    frame:SetWidth(w)
    frame:SetHeight(h)
    frame:SetFrameLevel(level)
    frame:SetScale(scale)
    frame:SetPoint(anchor, x, y)
    frame.text = frame:CreateFontString(nil, nil, font)
    frame.text:SetText(text)
    frame.text:SetPoint(align, 0, 0)
    return frame
end

function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local function am(text)
    DEFAULT_CHAT_FRAME:AddMessage(text)
end
local ring_count = 0
function KH_UI:cre_ring_holder(ring_config, parent)
    --am(ring_config.global.anchorframe)
    ring_count = ring_count + 1
    local f = CreateFrame("Frame", "FRAME_KH_RING_" .. ring_count, parent)
    f:SetWidth(256)
    f:SetHeight(256)
    f:SetPoint("CENTER", 0, 0)
    return f
end

function KH_UI:calc_edge_position(self, value, mainFrame)
    local edge = self.texture
    if value > 0.75 then
        edge:Hide()
    else
        edge:Show()
    end
    value = 0.5 - value --values is between 0 and 1
    if (KH_UI_Settings[mainFrame.settings].orientation == "Top Left") then
        value = value + 0.5
    elseif (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") then
        value = -value
    elseif (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
        value = 0.5 - value
    end
    local radian = math.rad(value * 360)
    self:SetPoint("CENTER", edge.radius * math.cos(radian), edge.radius * math.sin(radian))
    if (KH_UI_Settings[mainFrame.settings].orientation == "Top Right") or (KH_UI_Settings[mainFrame.settings].orientation == "Bottom Left") then
        radian = radian + math.rad(180)
    end
    edge:SetRotation(radian + math.rad(90), 0.5, 0.5)
end

-- calculates the one specific ring segment
function KH_UI:calc_ring_segment(self, value)
    local t0 = self.square1
    local t1 = self.square2
    local t2 = self.slicer
    local t3 = self.fullsegment

    local direction = self.direction
    local segmentsize = self.segmentsize
    local outer_radius = self.outer_radius
    local difference = self.difference
    local inner_radius = self.inner_radius
    local ring_factor = self.ring_factor
    local ring_width = self.ring_width

    --remember to invert the value when direction is counter-clockwise
    local statusbarvalue = value
    if direction == 0 then
        statusbarvalue = 100 - statusbarvalue
    end
    if statusbarvalue == 0 then
        statusbarvalue = 1
    --am("Oh Oh")
    end

    --am(statusbarvalue)

    --angle
    local angle = statusbarvalue * 90 / 100
    local Arad = math.rad(angle)

    local Nx = 0
    local Ny = 0
    local Mx = segmentsize
    local My = segmentsize

    local Ix, Iy, Ox, Oy
    local IxCoord, IyCoord, OxCoord, OyCoord, NxCoord, NyCoord, MxCoord, MyCoord
    local sq1_c1_x, sq1_c1_y, sq1_c2_x, sq1_c2_y, sq1_c3_x, sq1_c3_y, sq1_c4_x, sq1_c4_y
    local sq2_c1_x, sq2_c1_y, sq2_c2_x, sq2_c2_y, sq2_c3_x, sq2_c3_y, sq2_c4_x, sq2_c4_y

    if direction == 1 then
        Ix = inner_radius * math.sin(Arad)
        Iy = (outer_radius - (inner_radius * math.cos(Arad))) + difference
        Ox = outer_radius * math.sin(Arad)
        Oy = (outer_radius - (outer_radius * math.cos(Arad))) + difference
        IxCoord = Ix / segmentsize
        IyCoord = Iy / segmentsize
        OxCoord = Ox / segmentsize
        OyCoord = Oy / segmentsize
        NxCoord = Nx / segmentsize
        NyCoord = Ny / segmentsize
        MxCoord = Nx / segmentsize
        MyCoord = Ny / segmentsize

        sq1_c1_x = NxCoord
        sq1_c1_y = NyCoord
        sq1_c2_x = NxCoord
        sq1_c2_y = IyCoord
        sq1_c3_x = IxCoord
        sq1_c3_y = NyCoord
        sq1_c4_x = IxCoord
        sq1_c4_y = IyCoord

        sq2_c1_x = IxCoord
        sq2_c1_y = NyCoord
        sq2_c2_x = IxCoord
        sq2_c2_y = OyCoord
        sq2_c3_x = OxCoord
        sq2_c3_y = NyCoord
        sq2_c4_x = OxCoord
        sq2_c4_y = OyCoord

        if self.field == 1 then
            t0:SetPoint("TOPLEFT", Nx, -Ny)
            t0:SetWidth(Ix)
            t0:SetHeight(Iy)
            t1:SetPoint("TOPLEFT", Ix, -Ny)
            t1:SetWidth(Ox - Ix)
            t1:SetHeight(Oy)
            t2:SetPoint("TOPLEFT", Ix, -Oy)
            t2:SetWidth(Ox - Ix)
            t2:SetHeight(Iy - Oy)
        elseif self.field == 2 then
            t0:SetPoint("TOPRIGHT", Nx, Ny)
            t0:SetWidth(Iy)
            t0:SetHeight(Ix)
            t1:SetPoint("TOPRIGHT", Ny, -Ix)
            t1:SetWidth(Oy)
            t1:SetHeight(Ox - Ix)
            t2:SetPoint("TOPRIGHT", -Oy, -Ix)
            t2:SetWidth(Iy - Oy)
            t2:SetHeight(Ox - Ix)
            t2:SetTexCoord(0, 1, 1, 1, 0, 0, 1, 0)
        elseif self.field == 3 then
            t0:SetPoint("BOTTOMRIGHT", Nx, Ny)
            t0:SetWidth(Ix)
            t0:SetHeight(Iy)
            t1:SetPoint("BOTTOMRIGHT", -Ix, Ny)
            t1:SetWidth(Ox - Ix)
            t1:SetHeight(Oy)
            t2:SetPoint("BOTTOMRIGHT", -Ix, Oy)
            t2:SetWidth(Ox - Ix)
            t2:SetHeight(Iy - Oy)
            t2:SetTexCoord(1, 1, 1, 0, 0, 1, 0, 0)
        elseif self.field == 4 then
            t0:SetPoint("BOTTOMLEFT", Nx, Ny)
            t0:SetWidth(Iy)
            t0:SetHeight(Ix)
            t1:SetPoint("BOTTOMLEFT", Ny, Ix)
            t1:SetWidth(Oy)
            t1:SetHeight(Ox - Ix)
            t2:SetPoint("BOTTOMLEFT", Oy, Ix)
            t2:SetWidth(Iy - Oy)
            t2:SetHeight(Ox - Ix)
            t2:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1)
        end
    else
        Ix = inner_radius * math.sin(Arad)
        Iy = (outer_radius - (inner_radius * math.cos(Arad))) + difference
        Ox = outer_radius * math.sin(Arad)
        Oy = (outer_radius - (outer_radius * math.cos(Arad))) + difference
        IxCoord = Ix / segmentsize
        IyCoord = Iy / segmentsize
        OxCoord = Ox / segmentsize
        OyCoord = Oy / segmentsize
        NxCoord = Nx / segmentsize
        NyCoord = Ny / segmentsize
        MxCoord = Mx / segmentsize
        MyCoord = My / segmentsize

        sq1_c1_x = IxCoord
        sq1_c1_y = IyCoord
        sq1_c2_x = IxCoord
        sq1_c2_y = MyCoord
        sq1_c3_x = MxCoord
        sq1_c3_y = IyCoord
        sq1_c4_x = MxCoord
        sq1_c4_y = MyCoord

        sq2_c1_x = OxCoord
        sq2_c1_y = OyCoord
        sq2_c2_x = OxCoord
        sq2_c2_y = IyCoord
        sq2_c3_x = MxCoord
        sq2_c3_y = OyCoord
        sq2_c4_x = MxCoord
        sq2_c4_y = IyCoord

        if self.field == 1 then
            t0:SetPoint("TOPLEFT", Ix, -Iy)
            t0:SetWidth(segmentsize - Ix)
            t0:SetHeight(segmentsize - Iy)
            t1:SetPoint("TOPLEFT", Ox, -Oy)
            t1:SetWidth(segmentsize - Ox)
            t1:SetHeight(Iy - Oy)
            t2:SetPoint("TOPLEFT", Ix, -Oy)
            t2:SetWidth(Ox - Ix)
            t2:SetHeight(Iy - Oy)
        elseif self.field == 2 then
            t0:SetPoint("TOPRIGHT", -Iy, -Ix)
            t0:SetWidth(segmentsize - Iy)
            t0:SetHeight(segmentsize - Ix)
            t1:SetPoint("TOPRIGHT", -Oy, -Ox)
            t1:SetWidth(Iy - Oy)
            t1:SetHeight(segmentsize - Ox)
            t2:SetPoint("TOPRIGHT", -Oy, -Ix)
            t2:SetWidth(Iy - Oy)
            t2:SetHeight(Ox - Ix)
            t2:SetTexCoord(0, 1, 1, 1, 0, 0, 1, 0)
        elseif self.field == 3 then
            t0:SetPoint("BOTTOMRIGHT", -Ix, Iy)
            t0:SetWidth(segmentsize - Ix)
            t0:SetHeight(segmentsize - Iy)
            t1:SetPoint("BOTTOMRIGHT", -Ox, Oy)
            t1:SetWidth(segmentsize - Ox)
            t1:SetHeight(Iy - Oy)
            t2:SetPoint("BOTTOMRIGHT", -Ix, Oy)
            t2:SetWidth(Ox - Ix)
            t2:SetHeight(Iy - Oy)
            t2:SetTexCoord(1, 1, 1, 0, 0, 1, 0, 0)
        elseif self.field == 4 then
            t0:SetPoint("BOTTOMLEFT", Iy, Ix)
            t0:SetWidth(segmentsize - Iy)
            t0:SetHeight(segmentsize - Ix)
            t1:SetPoint("BOTTOMLEFT", Oy, Ox)
            t1:SetWidth(Iy - Oy)
            t1:SetHeight(segmentsize - Ox)
            t2:SetPoint("BOTTOMLEFT", Oy, Ix)
            t2:SetWidth(Iy - Oy)
            t2:SetHeight(Ox - Ix)
            t2:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1)
        end
    end

    if self.field == 1 then
        --1,2,3,4
        t0:SetTexCoord(sq1_c1_x, sq1_c1_y, sq1_c2_x, sq1_c2_y, sq1_c3_x, sq1_c3_y, sq1_c4_x, sq1_c4_y)
        t1:SetTexCoord(sq2_c1_x, sq2_c1_y, sq2_c2_x, sq2_c2_y, sq2_c3_x, sq2_c3_y, sq2_c4_x, sq2_c4_y)
    elseif self.field == 2 then
        --2,4,1,3
        t0:SetTexCoord(sq1_c2_x, sq1_c2_y, sq1_c4_x, sq1_c4_y, sq1_c1_x, sq1_c1_y, sq1_c3_x, sq1_c3_y)
        t1:SetTexCoord(sq2_c2_x, sq2_c2_y, sq2_c4_x, sq2_c4_y, sq2_c1_x, sq2_c1_y, sq2_c3_x, sq2_c3_y)
    elseif self.field == 3 then
        --4,3,2,1
        t0:SetTexCoord(sq1_c4_x, sq1_c4_y, sq1_c3_x, sq1_c3_y, sq1_c2_x, sq1_c2_y, sq1_c1_x, sq1_c1_y)
        t1:SetTexCoord(sq2_c4_x, sq2_c4_y, sq2_c3_x, sq2_c3_y, sq2_c2_x, sq2_c2_y, sq2_c1_x, sq2_c1_y)
    elseif self.field == 4 then
        --3,1,4,2
        t0:SetTexCoord(sq1_c3_x, sq1_c3_y, sq1_c1_x, sq1_c1_y, sq1_c4_x, sq1_c4_y, sq1_c2_x, sq1_c2_y)
        t1:SetTexCoord(sq2_c3_x, sq2_c3_y, sq2_c1_x, sq2_c1_y, sq2_c4_x, sq2_c4_y, sq2_c2_x, sq2_c2_y)
    end
end

--function that creates the textures for each segment
function KH_UI:cre_segment_textures(ring_config, self, mainFrame)
    --am(self.field)

    local direction = ring_config.global.fill_direction
    local segmentsize = 128
    local outer_radius = ring_config.segment.outer_radius
    local difference = segmentsize - outer_radius
    local inner_radius = ring_config.segment.inner_radius
    local ring_factor = outer_radius / inner_radius
    local ring_width = outer_radius - inner_radius

    self.direction = ring_config.global.fill_direction
    self.segmentsize = 128
    self.outer_radius = ring_config.segment.outer_radius
    self.difference = segmentsize - outer_radius
    self.inner_radius = ring_config.segment.inner_radius
    self.ring_factor = outer_radius / inner_radius
    self.ring_width = outer_radius - inner_radius

    self.text = self:CreateFontString(nil, nil, "SpellFont_Small")
    self.text:SetPoint("center", 0, 0)

    local t0 = self:CreateTexture(nil, "BACKGROUND")
    t0:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\" .. ring_config.global.gfx_texture)
    t0:SetVertexColor(ring_config.segment.color.r, ring_config.segment.color.g, ring_config.segment.color.b, ring_config.segment.color.a)
    t0:SetBlendMode("blend")
    t0:Hide()

    local t1 = self:CreateTexture(nil, "LOW")
    t1:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\" .. ring_config.global.gfx_texture)
    t1:SetVertexColor(ring_config.segment.color.r, ring_config.segment.color.g, ring_config.segment.color.b, ring_config.segment.color.a)
    t1:SetBlendMode("blend")
    t1:Hide()

    local t2 = self:CreateTexture(nil, "BACKGROUND")
    t2:SetVertexColor(ring_config.segment.color.r, ring_config.segment.color.g, ring_config.segment.color.b, ring_config.segment.color.a)
    t2:SetBlendMode("blend")
    if direction == 1 then
        t2:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\" .. ring_config.global.gfx_slicer .. "1")
    else
        t2:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\" .. ring_config.global.gfx_slicer .. "0")
    end
    t2:Hide()

    local t3 = self:CreateTexture(nil, "BACKGROUND")
    t3:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\" .. ring_config.global.gfx_texture)
    t3:SetVertexColor(ring_config.segment.color.r, ring_config.segment.color.g, ring_config.segment.color.b, ring_config.segment.color.a)
    t3:SetBlendMode("blend")
    t3:SetPoint("CENTER", 0, 0)
    t3:SetWidth(segmentsize)
    t3:SetHeight(segmentsize)
    if self.field == 1 then
        --no coord needed
    elseif self.field == 2 then
        t3:SetTexCoord(0, 1, 1, 1, 0, 0, 1, 0)
    elseif self.field == 3 then
        t3:SetTexCoord(1, 1, 1, 0, 0, 1, 0, 0)
    elseif self.field == 4 then
        t3:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1)
    end
    t3:Hide()

    self.square1 = t0
    self.square2 = t1
    self.slicer = t2
    self.fullsegment = t3
end

--calculate the segment number based on starting segment and direction
function KH_UI:calc_segment_num(ring_config, current, mainFrame)
    local start = ring_config.global.start_segment
    local dir = ring_config.global.fill_direction
    local id
    if dir == 0 then
        if start - current < 1 then
            id = start - current + 4
        else
            id = start - current
        end
    else
        if start + current > 4 then
            id = start + current - 4
        else
            id = start + current
        end
    end
    return id
end

--create the ring segments
function KH_UI:cre_ring_segments(ring_config, ring_object, mainFrame)
    local f = CreateFrame("Frame", nil, ring_object)
    f:SetAllPoints(ring_object)
    f:SetFrameLevel(ring_config.segment.framelevel)
    for i = 1, (ring_config.global.segments_used) do
        f[i] = CreateFrame("Frame", nil, f)
        f[i]:SetWidth(256 / 2)
        f[i]:SetHeight(256 / 2)
        f[i].id = i
        f[i].field = KH_UI:calc_segment_num(ring_config, i - 1, mainFrame)
        if f[i].field == 1 then
            f[i]:SetPoint("TOPRIGHT", 0, 0)
        elseif f[i].field == 2 then
            f[i]:SetPoint("BOTTOMRIGHT", 0, 0)
        elseif f[i].field == 3 then
            f[i]:SetPoint("BOTTOMLEFT", 0, 0)
        elseif f[i].field == 4 then
            f[i]:SetPoint("TOPLEFT", 0, 0)
        end
        KH_UI:cre_segment_textures(ring_config, f[i], mainFrame)
    end
    return f
end

--Reconfigure ring segments
function KH_UI:update_ring_segments(mainFrame)
    local ring_config = mainFrame.ring_table
    for k in ipairs(ring_config) do
        local f = mainFrame.ring_frames[k].segments
        for i = 1, (ring_config[k].global.segments_used) do
            f[i].field = KH_UI:calc_segment_num(ring_config[k], i - 1, mainFrame)
            f[i]:ClearAllPoints()
            f[i].fullsegment:ClearAllPoints()
            f[i].fullsegment:SetPoint("CENTER", 0, 0)
            f[i].square1:ClearAllPoints()
            f[i].square2:ClearAllPoints()
            f[i].slicer:ClearAllPoints()
            if f[i].field == 1 then
                f[i]:SetPoint("TOPRIGHT", 0, 0)
                f[i].fullsegment:SetTexCoord(0, 0, 0, 1, 1, 0, 0, 0)
            elseif f[i].field == 2 then
                f[i]:SetPoint("BOTTOMRIGHT", 0, 0)
                f[i].fullsegment:SetTexCoord(0, 1, 1, 1, 0, 0, 1, 0)
            elseif f[i].field == 3 then
                f[i]:SetPoint("BOTTOMLEFT", 0, 0)
                f[i].fullsegment:SetTexCoord(1, 1, 1, 0, 0, 1, 0, 0)
            elseif f[i].field == 4 then
                f[i]:SetPoint("TOPLEFT", 0, 0)
                f[i].fullsegment:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1)
            end
            f[i].direction = ring_config[k].global.fill_direction
            if f[i].direction == 1 then
                f[i].slicer:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\" .. ring_config.global.gfx_slicer .. "1")
            else
                f[i].slicer:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\" .. ring_config.global.gfx_slicer .. "0")
            end
        end
    end
end

function KH_UI:calc_ring_health(self, ring_config, unit, type, mainFrame)
    local act, max, perc, perc_per_seg = UnitHealth(unit), UnitHealthMax(unit), (UnitHealth(unit) / UnitHealthMax(unit)) * 100, 100 / ring_config.global.segments_used
    local anz_seg, sum_radius = ring_config.global.segments_used, ring_config.global.segments_used * 90

    if type == "lasthealth" then
        if mainFrame.lastHealth > UnitHealth(unit) and mainFrame.lastHealth <= mainFrame.unitHealthMax then
            if (KH_UI_Settings[mainFrame.settings].style == "KH2") then
                mainFrame.yvel = 2
                mainFrame.offsety = 0
                self.alpha = 1.2
            elseif (KH_UI_Settings[mainFrame.settings].style == "KH1") then
                mainFrame.yvel = 0
                mainFrame.offsety = 30
                self.alpha = 1
            end
            mainFrame.lastTimer = 3
            mainFrame.damageHealth = mainFrame.lastHealth
        end
        act = mainFrame.damageHealth
        perc = (mainFrame.damageHealth / max) * 100
        mainFrame.lastHealth = UnitHealth(unit)
    end

    if (KH_UI_Settings[mainFrame.settings].style == "KH2" or KH_UI_Settings[mainFrame.settings].style == "KH1") then
        perc = (perc * mainFrame.healthMaxMult) * (max / KH_UI_Settings[mainFrame.settings].ringMaxHealth)

        if type == "maxhealth" or type == "maxhealthbg" then
            perc = (max / KH_UI_Settings[mainFrame.settings].ringMaxHealth) * 100 * mainFrame.healthMaxMult
        end
        if (type == "maxhealth" and KH_UI_Settings[mainFrame.settings].style == "KH1") then
            perc = (max / KH_UI_Settings[mainFrame.settings].ringMaxHealth) * 100 * mainFrame.healthMaxMult + 1
        end
    elseif (KH_UI_Settings[mainFrame.settings].style == "KH2 Party") then
        if type == "maxhealth" or type == "maxhealthbg" then
            perc = 100
        end
    end

    perc = round(perc, 4)

    if perc > 100 then
        perc = 100
    end
    ---------------------------------
    if perc == 0 or UnitIsDeadOrGhost(unit) == 1 then
        for i = 1, anz_seg do
            self.segments[i].square1:Hide()
            self.segments[i].square2:Hide()
            self.segments[i].slicer:Hide()
            self.segments[i].fullsegment:Hide()
        end
    elseif perc == 100 then
        for i = 1, anz_seg do
            self.segments[i].square1:Hide()
            self.segments[i].square2:Hide()
            self.segments[i].slicer:Hide()
            self.segments[i].fullsegment:Show()
        end
    else
        for i = 1, anz_seg do
            if (perc > (i * perc_per_seg)) then
                self.segments[i].square1:Hide()
                self.segments[i].square2:Hide()
                self.segments[i].slicer:Hide()
                self.segments[i].fullsegment:Show()
            elseif ((perc >= round((i - 1) * perc_per_seg, 4)) and (perc <= round(i * perc_per_seg, 4))) then
                local value = round(((perc - ((i - 1) * perc_per_seg)) / perc_per_seg) * 100, 4)
                KH_UI:calc_ring_segment(self.segments[i], value)
                self.segments[i].square1:Show()
                self.segments[i].square2:Show()
                self.segments[i].slicer:Show()
                self.segments[i].fullsegment:Hide()
            else
                self.segments[i].square1:Hide()
                self.segments[i].square2:Hide()
                self.segments[i].slicer:Hide()
                self.segments[i].fullsegment:Hide()
            end
        end
    end
end

function KH_UI:calc_ring_power(self, ring_config, unit, type, mainFrame)
    local powerType, powerToken, altR, altG, altB = UnitPowerType(unit)
    if type == "mana" or type == "lastmana" or type == "maxmana" or type == "maxmanabg" then
        powerType = 0
        powerToken = "MANA"
    end
    local act, max, perc, perc_per_seg = UnitPower(unit, powerType), UnitPowerMax(unit, powerType), (UnitPower(unit, powerType) / UnitPowerMax(unit, powerType)) * 100, 100 / ring_config.global.segments_used
    local anz_seg, sum_radius = ring_config.global.segments_used, ring_config.global.segments_used * 90
    local info, r, g, b = PowerBarColor[powerToken], 1, 0, 0

    if (info) then
        --The PowerBarColor takes priority
        r, g, b = info.r * 0.75, info.g * 0.75, info.b * 0.75
    elseif (not altR) then
        -- Couldn't find a power token entry. Default to indexing by power type or just mana if  we don't have that either.
        info = PowerBarColor[powerType] or PowerBarColor["MANA"]
        r, g, b = info.r * 0.75, info.g * 0.75, info.b * 0.75
    else
        r, g, b = altR * 0.75, altG * 0.75, altB * 0.75
    end

    if type == "lastmana" then
        if (KH_UI_Settings[mainFrame.settings].style == "KH1") then
            if mainFrame.lastMana > act then
                mainFrame.lastManaAlpha = 1
                mainFrame.fadeMana = mainFrame.lastMana
            end
        end
        mainFrame.lastMana = act
        act = mainFrame.fadeMana
        perc = (mainFrame.fadeMana / max) * 100
    end

    if (KH_UI_Settings[mainFrame.settings].style == "KH1") then
        perc = perc * (max / KH_UI_Settings[mainFrame.settings].ringMaxPower)
    end

    if type == "maxpower" or type == "maxmana" then
        if (KH_UI_Settings[mainFrame.settings].style == "KH1") then
            perc = (max / KH_UI_Settings[mainFrame.settings].ringMaxPower) * 100 + 0.78
        elseif (KH_UI_Settings[mainFrame.settings].style == "KH2 Party") then
            perc = 100
        end
    elseif type == "maxpowerbg" or type == "maxmanabg" then
        if (KH_UI_Settings[mainFrame.settings].style == "KH1") then
            perc = (max / KH_UI_Settings[mainFrame.settings].ringMaxPower) * 100
        elseif (KH_UI_Settings[mainFrame.settings].style == "KH2 Party") then
            perc = 100
        end
    elseif (type == "power" or type == "mana" or type == "lastmana") then
        if (KH_UI_Settings[mainFrame.settings].style ~= "KH1") then
            for i = 1, anz_seg do
                self.segments[i].square1:SetVertexColor(r, g, b, 1)
                self.segments[i].square2:SetVertexColor(r, g, b, 1)
                self.segments[i].slicer:SetVertexColor(r, g, b, 1)
                self.segments[i].fullsegment:SetVertexColor(r, g, b, 1)
            end
        end
    end

    perc = round(perc, 4)

    if perc > 100 then
        perc = 100
    end

    if perc == 0 or UnitIsDeadOrGhost(unit) == 1 then
        for i = 1, anz_seg do
            self.segments[i].square1:Hide()
            self.segments[i].square2:Hide()
            self.segments[i].slicer:Hide()
            self.segments[i].fullsegment:Hide()
        end
    elseif perc == 100 then
        for i = 1, anz_seg do
            self.segments[i].square1:Hide()
            self.segments[i].square2:Hide()
            self.segments[i].slicer:Hide()
            self.segments[i].fullsegment:Show()
        end
    else
        for i = 1, anz_seg do
            if (perc > (i * perc_per_seg)) then
                self.segments[i].square1:Hide()
                self.segments[i].square2:Hide()
                self.segments[i].slicer:Hide()
                self.segments[i].fullsegment:Show()
            elseif ((perc >= round((i - 1) * perc_per_seg, 4)) and (perc <= round(i * perc_per_seg, 4))) then
                local value = round(((perc - ((i - 1) * perc_per_seg)) / perc_per_seg) * 100, 4)
                KH_UI:calc_ring_segment(self.segments[i], value)
                self.segments[i].square1:Show()
                self.segments[i].square2:Show()
                self.segments[i].slicer:Show()
                self.segments[i].fullsegment:Hide()
            else
                self.segments[i].square1:Hide()
                self.segments[i].square2:Hide()
                self.segments[i].slicer:Hide()
                self.segments[i].fullsegment:Hide()
            end
        end
    end
end

function KH_UI:setup_rings(id, mainFrame, ring_table)
    local ring_config = ring_table[id]
    local ring_object

    local parent = mainFrame
    if ring_config.global.ringtype == "health" or ring_config.global.ringtype == "lasthealth" or ring_config.global.ringtype == "maxhealth" or ring_config.global.ringtype == "maxhealthbg" then
        parent = mainFrame.healthFrame
    end

    if
        (ring_config.global.ringtype == "power" or ring_config.global.ringtype == "maxpower" or ring_config.global.ringtype == "maxpowerbg" or ring_config.global.ringtype == "mana" or ring_config.global.ringtype == "maxmana" or
            ring_config.global.ringtype == "maxmanabg")
     then
        if (KH_UI_Settings[mainFrame.settings].style == "KH1") then
            parent = mainFrame.manaFrame
        elseif (KH_UI_Settings[mainFrame.settings].style == "KH2 Party") then
            parent = mainFrame.powerFrame
        end
    end

    ring_object = KH_UI:cre_ring_holder(ring_config, parent)
    ring_object.alpha = 1
    ring_object.parent = parent
    ring_object.lastUpdate = 0
    ring_object.ringtype = ring_config.global.ringtype

    ring_object.segments = KH_UI:cre_ring_segments(ring_config, ring_object, mainFrame)

    --[[if ring_config.global.ringtype == "health" or ring_config.global.ringtype == "lasthealth" or ring_config.global.ringtype == "maxhealth" or ring_config.global.ringtype == "maxhealthbg" and not KH_UI_Settings[mainFrame.settings].style == "KH1" then
        ring_object:SetScript(
            "OnEvent",
            function(self, event, unit)
                if ((event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_MAXHEALTH") and unit == mainFrame.unit) or event == "PLAYER_ENTERING_WORLD" then
                    KH_UI:calc_ring_health(ring_object, ring_config, mainFrame.unit, ring_config.global.ringtype, mainFrame)
                end
            end
        )
        ring_object:RegisterEvent("UNIT_HEALTH_FREQUENT")
        ring_object:RegisterEvent("UNIT_MAXHEALTH")
        ring_object:RegisterEvent("PLAYER_ENTERING_WORLD")
    end]]
    --[[if (ring_config.global.ringtype == "maxpower" or ring_config.global.ringtype == "maxpowerbg" or ring_config.global.ringtype == "maxmana" or ring_config.global.ringtype == "maxmanabg") then
        ring_object:SetScript(
            "OnEvent",
            function(self, event, unit)
                if ((event == "UNIT_POWER_UPDATE" or event == "UNIT_DISPLAYPOWER" or event == "UNIT_MANA") and unit == ring_config.global.unit) or event == "PLAYER_ENTERING_WORLD" then
                    KH_UI:calc_ring_power(ring_object, ring_config, mainFrame.unit, ring_config.global.ringtype, mainFrame)
                end
            end
        )
        ring_object:RegisterEvent("UNIT_MANA")
        ring_object:RegisterEvent("UNIT_POWER_UPDATE")
        ring_object:RegisterEvent("UNIT_DISPLAYPOWER")
        ring_object:RegisterEvent("PLAYER_ENTERING_WORLD")
    end
    if (ring_config.global.ringtype == "power" or ring_config.global.ringtype == "mana") then
        ring_object:SetScript(
            "OnUpdate",
            function(self, elapsed)
                self.lastUpdate = self.lastUpdate + elapsed
                if (self.lastUpdate >= 0.05) then
                    self.lastUpdate = self.lastUpdate - 0.05
                    KH_UI:calc_ring_power(ring_object, ring_config, mainFrame.unit, ring_config.global.ringtype, mainFrame)
                end
            end
        )
    end]]
    return ring_object
end

function KH_UI:create_portrait(mainFrame)
    mainFrame.portrait = CreateFrame("Frame", nil, mainFrame.healthFrame)
    mainFrame.portrait:RegisterUnitEvent("UNIT_PORTRAIT_UPDATE", mainFrame.unit)
    mainFrame.portrait:RegisterEvent("UNIT_LEVEL")
    mainFrame.portrait:RegisterEvent("PLAYER_ENTERING_WORLD")
    mainFrame.portrait:RegisterEvent("PLAYER_ENTER_COMBAT")
    mainFrame.portrait:RegisterEvent("PLAYER_LEAVE_COMBAT")
    mainFrame.portrait:RegisterEvent("PLAYER_REGEN_DISABLED")
    mainFrame.portrait:RegisterEvent("PLAYER_REGEN_ENABLED")
    mainFrame.portrait:RegisterEvent("PLAYER_UPDATE_RESTING")
    mainFrame.portrait:RegisterEvent("GROUP_ROSTER_UPDATE")
    mainFrame.portrait:RegisterEvent("PARTY_LEADER_CHANGED")
    mainFrame.portrait:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")
    mainFrame.portrait:RegisterEvent("UNIT_FLAGS")
    mainFrame.portrait:RegisterEvent("UNIT_PHASE")
    mainFrame.portrait:RegisterEvent("UNIT_FACTION")
    mainFrame.portrait:RegisterEvent("UNIT_CONNECTION")
    mainFrame.portrait.Texture = mainFrame.portrait:CreateTexture("$parent_Texture", "BACKGROUND")
    mainFrame.portrait.redTexture = mainFrame.portrait:CreateTexture("$parent_Texture", "BACKGROUND")
    mainFrame.portrait.Texture:SetAllPoints()
    mainFrame.portrait.redTexture:SetAllPoints()
    SetPortraitTexture(mainFrame.portrait.Texture, mainFrame.unit)
    SetPortraitTexture(mainFrame.portrait.redTexture, mainFrame.unit)
    mainFrame.portrait:SetScript(
        "OnEvent",
        function(self, event)
            SetPortraitTexture(self.Texture, mainFrame.unit)
            SetPortraitTexture(self.redTexture, mainFrame.unit)
            if (event ~= "PLAYER_ENTER_COMBAT" and event ~= "PLAYER_REGEN_DISABLED" and not UnitAffectingCombat("player")) then
                mainFrame.Update_FrameInfo()
            end
            if mainFrame.unit == "player" then
                if (UnitIsGroupLeader("player")) then
                    mainFrame.portrait.leaderFrame:Show()
                else
                    mainFrame.portrait.leaderFrame:Hide()
                end

                if (IsResting()) then
                    mainFrame.portrait.stateFrame:Show()
                    mainFrame.portrait.levelFrame.text:Hide()
                    mainFrame.portrait.stateFrame.texture:SetTexCoord(0, 0.5, 0, 0.421875)
                elseif (UnitAffectingCombat(mainFrame.unit)) then
                    mainFrame.portrait.stateFrame:Show()
                    mainFrame.portrait.levelFrame.text:Hide()
                    mainFrame.portrait.stateFrame.texture:SetTexCoord(0.51, 1.0, 0, 0.49)
                else
                    mainFrame.portrait.stateFrame:Hide()
                    mainFrame.portrait.levelFrame.text:Show()
                end
            end
            for id = 1, 4, 1 do
                if mainFrame.unit == "party" .. id then
                    if (UnitIsGroupLeader("party" .. id)) then
                        mainFrame.portrait.leaderFrame:Show()
                    else
                        mainFrame.portrait.leaderFrame:Hide()
                    end

                    if (UnitAffectingCombat(mainFrame.unit)) then
                        mainFrame.portrait.stateFrame:Show()
                        mainFrame.portrait.levelFrame.text:Hide()
                        mainFrame.portrait.stateFrame.texture:SetTexCoord(0.5, 1.0, 0, 0.5)
                    else
                        mainFrame.portrait.stateFrame:Hide()
                        mainFrame.portrait.levelFrame.text:Show()
                    end
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
                -----------Handle Connected--------------
                if (not UnitIsConnected(mainFrame.unit)) then
                    -- Handle disconnected state
                    SetDesaturation(mainFrame.portrait.Texture, true)
                    mainFrame.portrait.disconnectFrame:Show()
                    --_G[selfName .. "PetFrame"]:Hide()
                    return
                else
                    SetDesaturation(mainFrame.portrait.Texture, false)
                    mainFrame.portrait.disconnectFrame:Hide()
                end
            end

            local frame = PlayerFrame
            if mainFrame.unit == "target" then
                frame = TargetFrame
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
    mainFrame.portrait:SetSize(100, 100)
    mainFrame.portrait:SetPoint("CENTER", 0, 0)
    mainFrame.portrait:SetFrameLevel(4)
    mainFrame.portrait.redTexture:SetVertexColor(1, 0, 0, 1)
    -------------------
    --Level------------
    -------------------
    mainFrame.portrait.levelFrame = CreateFrame("Frame", nil, mainFrame.portrait)
    mainFrame.portrait.levelFrame:SetSize(32, 32)
    mainFrame.portrait.levelFrame:SetPoint("BottomLeft", -4, -4)
    mainFrame.portrait.levelFrame.texture = mainFrame.portrait.levelFrame:CreateTexture(nil, "BACKGROUND")
    mainFrame.portrait.levelFrame.texture:SetPoint("CENTER", 16, 16)
    mainFrame.portrait.levelFrame.texture:SetAllPoints()
    mainFrame.portrait.levelFrame.texture:SetTexture("Interface\\AddOns\\KHUnitframes\\textures\\levelRing")
    mainFrame.portrait.levelFrame.text = mainFrame.portrait.levelFrame:CreateFontString(nil, nil, "GameNormalNumberFont")
    mainFrame.portrait.levelFrame.text:SetText("??")
    mainFrame.portrait.levelFrame.text:SetScale(1.2)
    mainFrame.portrait.levelFrame.text:SetVertexColor(1.0, 0.82, 0.0, 1.0)
    mainFrame.portrait.levelFrame.text:SetPoint("Center", 0, 0)
    mainFrame.portrait.levelFrame:SetScript(
        "OnEvent",
        function()
            local level = UnitLevel(mainFrame.unit)
            mainFrame.portrait.levelFrame.text:SetText(level)
        end
    )
    mainFrame.portrait.levelFrame:RegisterEvent("UNIT_LEVEL")
    mainFrame.portrait.levelFrame:RegisterEvent("UNIT_HEALTH")
    mainFrame.portrait.levelFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    --------------------
    --State-------------
    --------------------
    mainFrame.portrait.stateFrame = KH_UI:CreateImageFrame(32, 32, mainFrame.portrait.levelFrame, "CENTER", 1, 0, 6, {x = 0, xw = 1, y = 0, yh = 1}, "Interface\\CharacterFrame\\UI-StateIcon")
    --------------------
    --Party Leader------
    --------------------
    mainFrame.portrait.leaderFrame = KH_UI:CreateImageFrame(18, 18, mainFrame.portrait, "TopLeft", 16, 10, 6, {x = 0, xw = 1, y = 0, yh = 1}, "Interface\\GROUPFRAME\\UI-Group-LeaderIcon")
    --------------------
    --Master Loot------
    --------------------
    mainFrame.portrait.masterLootFrame = KH_UI:CreateImageFrame(18, 18, mainFrame.portrait, "TopLeft", 64, 10, 6, {x = 0, xw = 1, y = 0, yh = 1}, "Interface\\GroupFrame\\UI-Group-MasterLooter")
    --------------------
    --PvP Icon----------
    --------------------
    mainFrame.portrait.pvpIcon = KH_UI:CreateImageFrame(64, 64, mainFrame.portrait, "TopLeft", -16, -28, 6, {x = 0, xw = 1, y = 0, yh = 1}, "Interface\\TargetingFrame\\UI-PVP-HORDE")

    -----------------------------
    --Disconnected Icon----------
    -----------------------------
    mainFrame.portrait.disconnectFrame = KH_UI:CreateImageFrame(100, 100, mainFrame.portrait, "left", 0, 0, 6, {x = 0, xw = 1, y = 0, yh = 1}, "Interface\\CharacterFrame\\Disconnect-Icon")
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

---------------------
-- CALL
---------------------
KH_UI:RegisterEvent("PLAYER_LOGIN")
KH_UI:RegisterEvent("ADDON_LOADED")
KH_UI:RegisterEvent("GROUP_ROSTER_UPDATE")
KH_UI:RegisterEvent("UNIT_CONNECTION")
KH_UI:RegisterEvent("UNIT_HEALTH")
KH_UI:RegisterEvent("UNIT_TARGET")
KH_UI:RegisterEvent("UNIT_OTHER_PARTY_CHANGED")
KH_UI:RegisterEvent("VARIABLES_LOADED")
KH_UI:RegisterEvent("PLAYER_REGEN_ENABLED")

KH_UI:SetScript(
    "OnEvent",
    function(self, event, arg1)
        if (event == "PLAYER_LOGIN") then
            if KH_UI_Settings == nil then
                KH_UI_Settings = KH_UI_Settings_Defaults
            end

            for i in pairs(KH_UI_Settings_Defaults) do
                if KH_UI_Settings[i] == nil then
                    KH_UI_Settings[i] = KH_UI_Settings_Defaults[i]
                end
                for k, v in pairs(KH_UI_Settings_Defaults[i]) do
                    if KH_UI_Settings[i][k] == nil then
                        KH_UI_Settings[i][k] = v
                    end
                end
            end
            KH_UI.playerFrame = KH_UI:New_PlayerFrame()
            KH_UI.targetFrame = KH_UI:New_TargetFrame()
            KH_UI.targettargetFrame = KH_UI:New_TargetofTargetFrame()
            KH_UI.partyFrame = {}
            for i = 1, 4, 1 do
                KH_UI.partyFrame[i] = KH_UI:New_PartyFrame(i)
                if (KH_UI_Settings["Party Frame"].hideNotInParty) then
                    RegisterStateDriver(KH_UI.partyFrame[i], "visibility", "[@raid1, exists]hide;[@party" .. i .. ",exists]show;hide")
                end
            end
            KH_UI:UnregisterEvent("PLAYER_LOGIN")
        elseif (event == "ADDON_LOADED") then
            KH_UI:Set_BlizzardFrames()
            KH_UI:UnregisterEvent("ADDON_LOADED")
        elseif (event == "GROUP_ROSTER_UPDATE" or event == "UNIT_CONNECTION" or event == "UNIT_OTHER_PARTY_CHANGED" or event == "PLAYER_REGEN_ENABLED") then
            KH_UI:Set_BlizzardFrames()
        else
            KH_UI:Set_BlizzardFrames()
        end
    end
)
