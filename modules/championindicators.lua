pfUI:RegisterModule("Turtle WoW priest champion buff indicators", "vanilla", function ()
  if (pfUI_config["disabled"] and pfUI_config["disabled"]["Turtle WoW priest champion buff indicators"]  == "1") then
    return
  end

  local _, myclass = UnitClass("player")
  if myclass ~= "PRIEST" then return end

  local championBuffs = {
    -- Champion's Bond
    "interface\\icons\\spell_holy_championsbond",
    -- Champion's Grace
    "interface\\icons\\spell_holy_championsgrace",
    -- Empower Champion
    "interface\\icons\\spell_holy_empowerchampion",
    -- Proclaim Champion
    "interface\\icons\\spell_holy_proclaimchampion_02"
  }

  local turtleHookSet = false


  local championScan = CreateFrame("Frame")
  championScan:RegisterEvent("PLAYER_ENTERING_WORLD")
  championScan:RegisterEvent("UNIT_NAME_UPDATE")
  championScan:RegisterEvent("PLAYER_TALENT_UPDATE")
  championScan:RegisterEvent("CHARACTER_POINTS_CHANGED")
  championScan:SetScript("OnEvent", function()
    local _,_,_,_,champion = GetTalentInfo(2,16)
    -- only set the hook if champion talent is selected and the method hasn't been hooked
    if champion == 1 and not turtleHookSet then
	    -- Hook the pfUI.uf.RefreshUnit method, the pfUI.uf.SetupBuffIndicators method doesn't
      -- run if any indicators have already been set.
      hooksecurefunc(pfUI.uf, "RefreshUnit", function(pfUIuf, unit, component)
        if not unit.label then return end

        if not unit.config then
          return
        end

        if unit.turtle_champion_indicators_hooked and champion == 1 then
          return
        end

        if unit.turtle_champion_indicators_unhooked and champion == 0 then
          return
        end

        if unit.config.buff_indicator == "1" then
          if not unit.indicators then
            unit.indicators = {}
          end
          if unit.config.show_buffs == "1" then

            for _, buff in pairs(championBuffs) do
              local i = 0
              local foundBuff = 0
              for _, value in pairs(unit.indicators) do
                i = i + 1
                if value == buff then
                  foundBuff = 1
                  -- drop the indicator if the talent has been deselected
                  if champion ~= 1 then
                    table.remove(unit.indicators, i)
                    i = i - 1
                    unit.turtle_champion_indicators_unhooked = true
                  end
                  break
                end
              end
              if foundBuff == 0 then
                if champion == 1 then
                  table.insert(unit.indicators, buff)
                  unit.turtle_champion_indicators_hooked = true
                end
              end
            end

            pfUIuf:RefreshUnit(unit, component)
          end
        end
      end)
      turtleHookSet = true
    end
  end)
end)
