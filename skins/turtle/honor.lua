pfUI:RegisterSkin("Honor Turtle", "vanilla", function ()
  if (pfUI_config["disabled"] and
    pfUI_config["disabled"]["skin_Honor Turtle"]  == "1") then
    return
  end
  local hf = _G["HonorFrame"]
  if not hf then return end

  local rawborder, border = GetBorderSize()

  -- skin tab buttons
  local hfTabButton1 = _G[hf:GetName() .. "Tab1"]
  if hfTabButton1 then
    pfUI.api.SkinTab(hfTabButton1, 1)
  end
  local hfTabButton2 = _G[hf:GetName() .. "Tab2"]
  if hfTabButton2 then
    pfUI.api.SkinTab(hfTabButton2, 1)
    hfTabButton2:ClearAllPoints()
    hfTabButton2:SetPoint("LEFT", hfTabButton1, "RIGHT", border*2 + 1, 0)
  end

end)