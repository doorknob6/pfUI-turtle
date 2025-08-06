local moonkin_scan = CreateFrame("Frame")
moonkin_scan:RegisterEvent("PLAYER_ENTERING_WORLD")
moonkin_scan:RegisterEvent("UNIT_NAME_UPDATE")
moonkin_scan:RegisterEvent("PLAYER_TALENT_UPDATE")
moonkin_scan:RegisterEvent("CHARACTER_POINTS_CHANGED")
moonkin_scan:SetScript("OnEvent", function()
if class == "DRUID" then
  for i = table.getn(pfUI.autoshift.shapeshifts), 1, -1 do
	if pfUI.autoshift.shapeshifts[i] == "spell_nature_forceofnature" then
	  pfUI.autoshift.shapeshifts.remove(list, i)
	end
  end
  local _,_,_,_,moonkin = GetTalentInfo(1,15)
  if moonkin == 1 then
	table.insert(pfUI.autoshift.shapeshifts, "spell_nature_forceofnature")
	moonkin_scan:UnregisterAllEvents()
  end
else
  moonkin_scan:UnregisterAllEvents()
end
end)
