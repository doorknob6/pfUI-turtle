-- create the main test frame
local frameName = "pfUITurtleTestArenaFrame"

if not _G[frameName] then
  _G[frameName] = CreateFrame("Frame", frameName, UIParent)
end
local testFrame = _G[frameName]

testFrame:ClearAllPoints()
testFrame:SetPoint("CENTER", 0, 0)
testFrame:SetMovable(true)
testFrame:RegisterForDrag("LeftButton")
testFrame:SetWidth(185)
testFrame:SetHeight(240)
testFrame:Hide()

testFrame:SetScript(
  "OnShow",
  function()
    CharacterFrame:Show()
    ToggleCharacter("HonorFrame")
    HonorFrame:Hide()
    ArenaFrame:Show()
  end
)

if pfUI then
  pfUI.api.CreateBackdrop(testFrame, nil, nil, 0.75)
  pfUI.api.CreateBackdropShadow(testFrame)

  -- close button
  local closeButtonName = frameName .. "CloseButton"
  local function closeTestArenaFrame()
    if _G[frameName] and _G[frameName]:IsShown() then
      _G[frameName]:Hide()
    end
  end
  local closeButton = TestApiPfUITurtle.CreateTestButton(
    closeButtonName,
    testFrame,
    "Close Frame",
    closeTestArenaFrame
  )
  closeButton:SetPoint("TOPLEFT", testFrame.backdrop, "TOPLEFT", 5, -5)

  -- test main frame button
  local buttonName1 = frameName .. "TestButton1"
  local function testArenaMainFrame()
    local function testArenaTeamFrame(no, isCaptain)
      local teamFrameName = "ArenaFrameTeam" .. no

      _G[teamFrameName .. "Text"]:Hide()
      local teamFrame = _G[teamFrameName]
      teamFrame:SetAlpha(1)
      teamFrame.active = true

      local detailsFrameName = teamFrameName .. "Details"
      local detailsFrame = _G[detailsFrameName]
      detailsFrame:Show()

      local detailsTeamName = _G[detailsFrameName .. "Name"]
      detailsTeamName:SetText("Arena Team " .. no)

      local rating = math.random(3000)

      local seasonRank = math.random(1000)
      local seasonGames = math.random(3000)
      local seasonWins = math.random(seasonGames)

      local weekRank = 0
      local weekGames = math.random(300)
      if weekGames > seasonGames then
        weekGames = math.random(seasonGames)
      end
      local weekWins = math.random(weekGames)

      _G[detailsFrameName .. "Rating"]:SetText(rating)
      _G[detailsFrameName .. "WeekRank"]:SetText(weekRank)
      _G[detailsFrameName .. "WeekGames"]:SetText(weekGames)
      _G[detailsFrameName .. "WeekWins"]:SetText(weekWins)
      _G[detailsFrameName .. "WeekLoss"]:SetText(weekGames - weekWins)
      _G[detailsFrameName .. "SeasonRank"]:SetText(seasonRank)
      _G[detailsFrameName .. "SeasonGames"]:SetText(seasonGames)
      _G[detailsFrameName .. "SeasonWins"]:SetText(seasonWins)
      _G[detailsFrameName .. "SeasonLoss"]:SetText(seasonGames - seasonWins)

      local detailsDisbandButton = _G[detailsFrameName .. "DisbandButton"]
      if isCaptain then
        detailsDisbandButton:Show()
        detailsTeamName:SetPoint("TOPLEFT", detailsFrame, 38, -16)
      else
        detailsDisbandButton:Hide()
        detailsTeamName:SetPoint("TOPLEFT", detailsFrame, 18, -16)
      end
    end


    testArenaTeamFrame(1, false)
    testArenaTeamFrame(2, true)
    testArenaTeamFrame(3, false)
  end
  local button1 = TestApiPfUITurtle.CreateTestButton(
    buttonName1,
    testFrame,
    "Test Arena Main Frame",
    testArenaMainFrame
  )
  button1:SetPoint("TOPLEFT", closeButton, "BOTTOMLEFT", 0, -5)

  -- test details frame button
  local buttonName2 = frameName .. "TestButton2"
  local function testArenaDetailsFrame()
    ArenaFrameDetailsFrame:Show()
    ArenaFrameDetailsFrameMember1:Show()
    ArenaFrameDetailsFrameMember1Name:SetText("Doorknob")
    ArenaFrameDetailsFrameMember1CaptainIcon:Show()
    for i = 2, 5 do
      local name = "ArenaFrameDetailsFrameMember" .. i
      _G[name]:Show()
      _G[name .. "Name"]:SetText("Test" .. i)
    end
  end
  local button2 = TestApiPfUITurtle.CreateTestButton(
    buttonName2,
    testFrame,
    "Test Arena Details Frame",
    testArenaDetailsFrame
  )
  button2:SetPoint("TOPLEFT", button1, "BOTTOMLEFT", 0, -5)
end