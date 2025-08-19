pfUI:RegisterSkin("Character Frame Turtle", "vanilla", function()
  -- skin is loaded after pfUI is booted - so check if it is disabled ourselves
  if (pfUI_config["disabled"] and
    pfUI_config["disabled"]["skin_Character Frame Turtle"]  == "1") then
    return
  end

  -- skin player title dropdown menu
  if PaperDollFrameTitlesDropdown and pfUI.skin["Character"] and pfUI_config["disabled"]["skin_Character"] ~= "1" then
    CharacterLevelText:SetPoint("TOP", CharacterNameText, "BOTTOM", 0, -2)
    pfUI.api.SkinDropDown(PaperDollFrameTitlesDropdown)
    PaperDollFrameTitlesDropdown:SetPoint("TOP", CharacterGuildText, "BOTTOM", 0, -2)
    CharacterTitleText:SetPoint("LEFT", PaperDollFrameTitlesDropdown.backdrop, "LEFT", 6, 2)
    CharacterResistanceFrame:SetPoint("TOP", PaperDollFrameTitlesDropdown, "BOTTOM", 0, 0)
  end
end)