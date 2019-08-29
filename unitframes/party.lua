function KH_UI:New_PartyFrame(partyId)
    if (KH_UI_Settings["Party Frame"].style == "KH2") then
        return KH_UI:New_KH2Unitframe("party" .. partyId, "Party Frame")
    else
        return nil
    end
end
