function KH_UI:New_PlayerFrame()
    if (KH_UI_Settings["Player Frame"].style == "KH2") then
        return KH_UI:New_KH2Unitframe("player", "Player Frame")
    elseif (KH_UI_Settings["Player Frame"].style == "KH2 Party") then
        return KH_UI:New_KH2PartyUnitframe("player", "Player Frame")
    else
        return nil
    end
end
