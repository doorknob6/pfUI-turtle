
pfUI:RegisterModule("turtle-customdedebuffs", "vanilla", function()
  if (pfUI_config["disabled"] and
    pfUI_config["disabled"]["turtle-customdedebuffs"]  == "1") then
    return
  end

  if (pfUI.api.libdebuff.customTurtle) then return end
  pfUI.api.HookScript = HookScript
  pfUI.api.HookScript(pfUI.api.libdebuff, "OnEvent", function()
    ---@diagnostic disable-next-line: undefined-global
    if event == "CHAT_MSG_SPELL_SELF_DAMAGE" then

      --Holy Strike is a spell but can refresh paladin judgements
      ---@diagnostic disable-next-line: undefined-global
      local spell = string.find(string.sub(arg1,6,17), "Holy Strike")
      ---@diagnostic disable-next-line: undefined-global
      if spell and arg2 then --arg2 is holy dmg when it hits, nil when it misses
        ---@diagnostic disable-next-line: undefined-global
        for seal in L["judgements"] do
          local name = UnitName("target")
          local level = UnitLevel("target")
          if name and libdebuff.objects[name] then
            if level and
              libdebuff.objects[name][level] and
              libdebuff.objects[name][level][seal] then
              libdebuff:AddEffect(name, level, seal)
            elseif libdebuff.objects[name][0] and
              libdebuff.objects[name][0][seal] then
              libdebuff:AddEffect(name, 0, seal)
            end
          end
        end
      end
    end
  end)



  pfUI.api.libdebuff.customTurtle = true
end)

