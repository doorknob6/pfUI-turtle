pfUI:RegisterSkin("Arena Turtle", "vanilla", function ()
  if (pfUI_config["disabled"] and
    pfUI_config["disabled"]["skin_Arena Turtle"]  == "1") then
    return
  end
  local af = _G["ArenaFrame"]
  if not af then return end

  local rawborder, border = pfUI.api.GetBorderSize()

  pfUI.api.StripTextures(af)
  local hfTabButton1 = _G["HonorFrameTab1"]


  -- skin tab buttons
  local afTabButton1 = _G[af:GetName() .. "Tab1"]
  if afTabButton1 then
    pfUI.api.SkinTab(afTabButton1, 1)
    local hfTabButton1 = _G["HonorFrameTab1"]
    if hfTabButton1 then
        afTabButton1:ClearAllPoints()
        afTabButton1:SetPoint("TOPLEFT", hfTabButton1, "TOPLEFT", 0, 0)
    end
  end
  local afTabButton2 = _G[af:GetName() .. "Tab2"]
  if afTabButton2 then
    pfUI.api.SkinTab(afTabButton2, 1)
    afTabButton2:SetPoint("LEFT", afTabButton1, "RIGHT", border*2 + 1, 0)
  end

end)