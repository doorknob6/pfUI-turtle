TestApiPfUITurtle = {}

-- create or lay out a standardized test button
function TestApiPfUITurtle.CreateTestButton(name, parentFrame, buttonText, onClick)
  if not _G[name] then
    _G[name] = CreateFrame("Button", name, parentFrame)
  end
  local button = _G[name]
  button:SetWidth(175)
  button:SetHeight(25)
  button:SetText(buttonText)
  button:SetScript("OnClick", onClick)
  if pfUI then
    pfUI.api.SkinButton(button)
  end
  return button
end