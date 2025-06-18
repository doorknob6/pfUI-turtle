local function UpdateMoonkinIcon()
  if not pfUI or not pfUI.autoshift then return end

  -- Remove Moonkin icon if already set by pfUI
  local list = pfUI.autoshift.shapeshifts
  for i = table.getn(list), 1, -1 do
    if list[i] == "spell_nature_forceofnature" then
      table.remove(list, i)
    end
  end

  -- Add Moonkin icon if talent 15 is active
  local _, class = UnitClass("player")
  if class == "DRUID" then
    local _, _, _, _, moonkin = GetTalentInfo(1, 15)
    if moonkin == 1 then
      table.insert(list, "spell_nature_forceofnature")
    end
  end
end

local moonkin_scan_update = CreateFrame("Frame")
moonkin_scan_update:RegisterEvent("PLAYER_LOGIN")
moonkin_scan_update:RegisterEvent("PLAYER_TALENT_UPDATE")
moonkin_scan_update:RegisterEvent("CHARACTER_POINTS_CHANGED")
moonkin_scan_update:SetScript("OnEvent", UpdateMoonkinIcon)