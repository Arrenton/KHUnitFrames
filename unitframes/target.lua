function KH_UI:New_TargetFrame()
    if (KH_UI_Settings["Target Frame"].style == "KH2") then
        return KH_UI:New_KH2Unitframe('target', "Target Frame")
    elseif (KH_UI_Settings["Target Frame"].style == "KH2 Party") then
        return KH_UI:New_KH2PartyUnitframe('target', "Target Frame")
    elseif (KH_UI_Settings["Target Frame"].style == "KH2 Target") then
        return KH_UI:New_KH2TargetUnitframe('target', "Target Frame")
    else
        return nil
    end
end
