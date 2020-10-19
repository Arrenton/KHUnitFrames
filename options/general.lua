function KH_UI:General_Options(panel)
	---------------------
	--General Container--
	---------------------
	panel.generalBox = CreateFrame("Frame", nil, panel)
	if not panel.generalBox.SetBackdrop then
		Mixin(panel.generalBox, BackdropTemplateMixin)
	end
	panel.generalBox:SetSize(590, 75)
	panel.generalBox:SetPoint("TOPLEFT", 16, -64)
	panel.generalBox:SetBackdrop(
		{
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 16,
			edgeSize = 16,
			insets = {left = 5, right = 5, top = 5, bottom = 5}
		}
	)
	panel.generalBox:SetBackdropColor(0, 0, 0, 0.25)
	panel.generalBox.text = panel.generalBox:CreateFontString(nil, nil, "GameFontNormal")
	panel.generalBox.text:SetText("General")
	panel.generalBox.text:SetPoint("TOP", 0, 16)
	---------------
	--Player Style-
	---------------
	panel.generalBox.playerFrameStyle =
		KH_UI:Construct_DropDownMenu(
		"Player Frame Style",
		KH_UI_Settings["Player Frame"].style,
		panel.generalBox,
		"TopLeft",
		16,
		0,
		110,
		{"KH1","KH2","KH2 Party"},
		function(value)
			KH_UI_Settings["Player Frame"].style = value
		end
	)
	panel.generalBox.playerFrameStyle.tip = "Sets the style the frame will use.\nWill require reload."

	---------------
	--Party Style-
	---------------
	panel.generalBox.partyFrameStyle =
		KH_UI:Construct_DropDownMenu(
		"Party Frame Style",
		KH_UI_Settings["Party Frame"].style,
		panel.generalBox.playerFrameStyle,
		"TopLeft",
		140,
		0,
		110,
		{"KH1","KH2","KH2 Party"},
		function(value)
			KH_UI_Settings["Party Frame"].style = value
		end
	)
	panel.generalBox.partyFrameStyle.tip = "Sets the style the frame will use.\nWill require reload."

	---------------
	--Target Style-
	---------------
	panel.generalBox.targetFrameStyle =
		KH_UI:Construct_DropDownMenu(
		"Target Frame Style",
		KH_UI_Settings["Target Frame"].style,
		panel.generalBox.partyFrameStyle,
		"TopLeft",
		140,
		0,
		110,
		{"KH Target","KH2 Target"},
		function(value)
			KH_UI_Settings["Target Frame"].style = value
		end
	)
	panel.generalBox.targetFrameStyle.tip = "Sets the style the frame will use.\nWill require reload."
end
