pfUI:RegisterSkin("Arena Turtle", "vanilla", function ()
  if (pfUI_config["disabled"] and
    pfUI_config["disabled"]["skin_Arena Turtle"]  == "1") then
    return
  end
  local arenaFrameName = "ArenaFrame"
  local af = _G[arenaFrameName]
  if not af then return end

  local rawborder, border = pfUI.api.GetBorderSize()

  pfUI.api.StripTextures(af)

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

  -- skin team frames
  local function skinArenaTeamFrame(no)
    local teamFrameName = arenaFrameName .. "Team" .. no
    local teamFrame = _G[teamFrameName]
    if not teamFrame then return end

    pfUI.api.StripTextures(teamFrame)
    pfUI.api.CreateBackdrop(teamFrame)
    pfUI.api.SetHighlight(teamFrame, 1, 1, 1)

    local highlight = _G[teamFrameName .. "Highlight"]
    if highlight then
        highlight:SetBackdrop(nil)
    end

    local detailsFrameName = teamFrameName .. "Details"
    local detailsFrame = _G[detailsFrameName]
    if not detailsFrame then return end

    local detailsTeamNameName = detailsFrameName .. "Name"
    local detailsTeamName = _G[detailsTeamNameName]

    local detailsDisbandButton = _G[detailsFrameName .. "DisbandButton"]
    if detailsDisbandButton then
      pfUI.api.SkinButton(detailsDisbandButton, 1, 0.25, 0.25)

      detailsDisbandButton:SetWidth(15)
      detailsDisbandButton:SetHeight(15)

      detailsDisbandButton.texture = detailsDisbandButton:CreateTexture(
        "pfUITurtleDisbandArenaTeam"
      )
      local texturePath = "Interface\\AddOns\\pfUI-turtle\\img\\cancel"
      detailsDisbandButton.texture:SetTexture(texturePath)
      detailsDisbandButton.texture:ClearAllPoints()
      detailsDisbandButton.texture:SetAllPoints(detailsDisbandButton)
      detailsDisbandButton.texture:SetVertexColor(1,.25,.25,1)
      if detailsTeamName then
        detailsDisbandButton:ClearAllPoints()
        detailsDisbandButton:SetPoint("RIGHT", detailsTeamName, "LEFT", -5, 0)
      end

    end
  end

  skinArenaTeamFrame(1)
  skinArenaTeamFrame(2)
  skinArenaTeamFrame(3)

  -- skin details frame
  local detailsFrameName = arenaFrameName .. "DetailsFrame"
  local detailsFrame = _G[detailsFrameName]
  if detailsFrame then
    pfUI.api.StripTextures(detailsFrame)
    pfUI.api.CreateBackdrop(detailsFrame, nil, nil, 0.75)
    pfUI.api.CreateBackdropShadow(detailsFrame)

    detailsFrame:ClearAllPoints()
    detailsFrame:SetPoint(
      "TOPLEFT",
      CharacterFrame.backdrop,
      "TOPRIGHT",
      border + (border == 1 and 1 or 2),
      -28
    )

    local detailsCloseButton = _G[detailsFrameName .. "CloseButton"]
    if detailsCloseButton then
      pfUI.api.SkinCloseButton(detailsCloseButton, detailsFrame, -6, -6)
    end

    local detailsButton = _G[detailsFrameName .. "Button"]
    if detailsButton then
      pfUI.api.SkinButton(detailsButton)
    end

    local function skinMemberFrame(no)
      local memberFrameName = detailsFrameName .. "Member" .. no
      local kickButtonName = memberFrameName .. "KickButton"
      local kickButton = _G[kickButtonName]
      if kickButton then
        pfUI.api.SkinButton(kickButton, 1, 0.25, 0.25)

        kickButton:SetWidth(15)
        kickButton:SetHeight(15)

        kickButton.texture = kickButton:CreateTexture(
          "pfUITurtleDisbandArenaTeam"
        )
        local texturePath = "Interface\\AddOns\\pfUI-turtle\\img\\cancel"
        kickButton.texture:SetTexture(texturePath)
        kickButton.texture:ClearAllPoints()
        kickButton.texture:SetAllPoints(kickButton)
        kickButton.texture:SetVertexColor(1,.25,.25,1)

        -- local memberName = _G[memberFrameName .. "Name"]
        -- if memberName then
        --   kickButton:ClearAllPoints()
        --   kickButton:SetPoint("LEFT", memberName, "LEFT", 142, 0)
        -- end

      end
    end

    for i = 1, 5 do
      skinMemberFrame(i)
    end
  end
end)