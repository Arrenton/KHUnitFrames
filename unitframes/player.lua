function KH_UI:New_PlayerFrame()
    if (KH_UI_Settings["Player Frame"].style == "KH2") then
        return KH_UI:New_KH2Unitframe("player", "Player Frame")
    else
        return nil
    end
end
