function KH_UI:New_TargetofTargetFrame()
    if (KH_UI_Settings["ToT Frame"].style == "Target of Target") then
        return KH_UI:New_KH2TargetofTargetUnitframe('targettarget', "ToT Frame")
    else
        return nil
    end
end
