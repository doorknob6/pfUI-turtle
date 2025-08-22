pfUI:RegisterModule("Turtle WoW druid moonkin autoshift", "vanilla", function ()
  if (pfUI_config["disabled"] and pfUI_config["disabled"]["Turtle WoW druid moonkin autoshift"]  == "1") then
    return
  end

  local _, myclass = UnitClass("player")
  if myclass ~= "DRUID" then return end

  local moonkinScan = CreateFrame("Frame")
  moonkinScan:RegisterEvent("PLAYER_ENTERING_WORLD")
  moonkinScan:RegisterEvent("UNIT_NAME_UPDATE")
  moonkinScan:RegisterEvent("PLAYER_TALENT_UPDATE")
  moonkinScan:RegisterEvent("CHARACTER_POINTS_CHANGED")
  moonkinScan:SetScript("OnEvent", function()
    for i = table.getn(pfUI.autoshift.shapeshifts), 1, -1 do
      if pfUI.autoshift.shapeshifts[i] == "spell_nature_forceofnature" then
        table.remove(pfUI.autoshift.shapeshifts, i)
      end
    end
    local _,_,_,_,moonkin = GetTalentInfo(1,15)
    if moonkin == 1 then
      table.insert(pfUI.autoshift.shapeshifts, "spell_nature_forceofnature")
    end
  end)
end)
