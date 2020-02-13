function KH_UI:New_PartyFrame(partyId)
    if (KH_UI_Settings["Party Frame"].style == "KH1") then
        return KH_UI:New_KH1Unitframe("party" .. partyId, "Party Frame")
    elseif (KH_UI_Settings["Party Frame"].style == "KH2") then
            return KH_UI:New_KH2Unitframe("party" .. partyId, "Party Frame")
    elseif (KH_UI_Settings["Party Frame"].style == "KH2 Party") then
        return KH_UI:New_KH2PartyUnitframe("party" .. partyId, "Party Frame")
    else
        return nil
    end
end
