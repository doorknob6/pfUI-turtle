-- TurtleWoW Group Finder 1.18
pfUI:RegisterSkin("Turtle Group Finder", "vanilla", function()
  if pfUI_config["disabled"] and pfUI_config["disabled"]["skin_Turtle Group Finder"] == "1" then
    return
  end

  local gf = LFTFrame

  local rawborder, border = GetBorderSize()
  local bpad = rawborder > 1 and border - GetPerfectPixel() or GetPerfectPixel()

  -- main frame
  StripTextures(gf, nil, "BACKGROUND")
  StripTextures(gf, nil, "ARTWORK")
  CreateBackdrop(gf, nil, nil, .75)
  CreateBackdropShadow(gf)

  if gf.backdrop then
    gf.backdrop:SetPoint("TOPLEFT", 14, -10)
    gf.backdrop:SetPoint("BOTTOMRIGHT", -26, 72)
    if gf.SetHitRectInsets then
      gf:SetHitRectInsets(14, 26, 10, 72)
    end
  end

  -- dropdown
  local dropdown
  if gf.GetName then dropdown = _G[gf:GetName() .. "DropDown"] end
  if not dropdown and _G.LFTFrameDropDown then dropdown = _G.LFTFrameDropDown end
  if dropdown then
    SkinDropDown(dropdown)
    dropdown:ClearAllPoints()
    dropdown:SetPoint("TOPLEFT", LFTFrame, "TOPLEFT", 150, -120)
  end

  -- search edit box
  local searchBox = _G["LFTFrameSearch"]
  if searchBox then
    StripTextures(searchBox, nil, "BACKGROUND")
    local searchIcon = _G["LFTFrameSearchIcon"]
    if searchBox.GetName then searchIcon = _G[searchBox:GetName() .. "SearchIcon"] end
    if not searchIcon and _G.LFTFrameSearchIcon then searchIcon = _G.LFTFrameSearchIcon end
    if searchIcon then
      searchIcon:ClearAllPoints()
      searchIcon:SetPoint("LEFT", searchBox, "LEFT", 3, -1)
    end
    searchBox:SetScript("OnEscapePressed", function() this:ClearFocus() end)
    searchBox:ClearAllPoints()
    searchBox:SetPoint("TOPLEFT", LFTFrame, "TOPLEFT", 26, -121)
    searchBox:SetHeight(25)
    searchBox:SetWidth(138)
    searchBox:SetTextInsets(18, 20, 4, 4)
    searchBox:SetFontObject(GameFontNormal)
    CreateBackdrop(searchBox, nil, true)
  end

  -- instances list scroll frame and scroll bar
  local scrollFrame
  if gf.GetName then scrollFrame = _G[gf:GetName() .. "InstancesList"] end
  if not scrollFrame and _G.LFTFrameInstancesList then
    scrollFrame = _G.LFTFrameInstancesList
  end
  if (scrollFrame and
      scrollFrame.GetObjectType and
      scrollFrame:GetObjectType() == "ScrollFrame" and
      scrollFrame.GetName) then

    scrollFrame:ClearAllPoints()
    scrollFrame:SetHeight(262)
    scrollFrame:SetWidth(301)
    scrollFrame:SetPoint("LEFT", gf.backdrop, "LEFT", 8, -55)


    local bar = _G[scrollFrame:GetName() .. "ScrollBar"]
    if bar then SkinScrollbar(bar) end
  end

  -- instance entries
  if LFT_UpdateInstances then
    hooksecurefunc("LFT_UpdateInstances", function()
      if LFT_Instances then
        local index = 0
        for _ in pairs(LFT_Instances) do
          index = index + 1
          local instanceEntryFrameName = "LFTFrameInstancesListEntry" .. index
          local instanceListEntry = _G[instanceEntryFrameName]
          if instanceListEntry then
            local checkButtonName = instanceEntryFrameName .. "CheckButton"
            local checkButton = _G[checkButtonName]
            if checkButton then
              checkButton:SetNormalTexture("")
              checkButton:SetPushedTexture("")
              checkButton:SetHighlightTexture("")
              checkButton:SetWidth(18)
              checkButton:SetHeight(18)
              CreateBackdrop(checkButton, nil, true)
              checkButton:ClearAllPoints()
              checkButton:SetPoint("TOPLEFT", instanceListEntry, "TOPLEFT", 0, -1)
            end
          end
        end
      end
    end)
  end

  -- buttons
  local buttonWidth = 105
	if LFTFrameMainButton then
		StripTextures(LFTFrameMainButton, true)
		SkinButton(LFTFrameMainButton)
		LFTFrameMainButton:SetWidth(buttonWidth)
    LFTFrameMainButton:ClearAllPoints()
    LFTFrameMainButton:SetPoint("BOTTOM", gf.backdrop, "BOTTOM", 0, 5)
	end
  if LFTFrameNewGroupButton then
		StripTextures(LFTFrameNewGroupButton, true)
		SkinButton(LFTFrameNewGroupButton)
		LFTFrameNewGroupButton:SetWidth(buttonWidth)
    LFTFrameNewGroupButton:ClearAllPoints()
    LFTFrameNewGroupButton:SetPoint("BOTTOM", gf.backdrop, "BOTTOM", 0, 5)
	end
	if LFTFrameRefreshButton then
		StripTextures(LFTFrameRefreshButton, true)
		SkinButton(LFTFrameRefreshButton)
		LFTFrameRefreshButton:SetWidth(buttonWidth)
    LFTFrameRefreshButton:ClearAllPoints()
    LFTFrameRefreshButton:SetPoint(
      "RIGHT",
      LFTFrameNewGroupButton,
      "LEFT",
      -border*2 + 1,
      0
    )
	end
	if LFTFrameSignUpButton then
		StripTextures(LFTFrameSignUpButton, true)
		SkinButton(LFTFrameSignUpButton)
		LFTFrameSignUpButton:SetWidth(buttonWidth)
		LFTFrameSignUpButton:ClearAllPoints()
    LFTFrameSignUpButton:SetPoint(
      "LEFT",
      LFTFrameNewGroupButton,
      "RIGHT",
      border,
      0
    )
	end

  -- role buttons and checkboxes
  local checkBoxSize = 18

  local function SkinRoleButton(roleName, textureName)
    local roleButton
    if gf.GetName then roleButton = _G[gf:GetName() .. roleName] end
    if not roleButton then return end

    roleButton:SetHeight(36)
    roleButton:SetWidth(36)

    local roleCheckButton
    if roleButton.GetName then roleCheckButton = _G[roleButton:GetName() .. "CheckButton"] end
    if roleCheckButton then
      SkinCheckbox(roleCheckButton, checkBoxSize)
      CreateBackdrop(roleCheckButton, nil, true)
      roleCheckButton:ClearAllPoints()
      roleCheckButton:SetPoint("BOTTOMLEFT", roleButton, "BOTTOMLEFT", -8, -8)
    end

    local roleIcon
    if roleButton.GetName then roleIcon = _G[roleButton:GetName() .. "Icon"] end

    if roleIcon then
      local texturePath = "Interface\\AddOns\\pfUI-turtle\\img\\" .. textureName
      roleIcon:SetTexture(texturePath)
    end

    pfUI.api.CreateBackdrop(roleButton, nil, true)
    roleButton:SetHighlightTexture("")

    pfUI.api.SetHighlight(roleButton, 1, 1, 1)

    pfUI.api.SetAllPointsOffset(roleIcon, roleButton, 1)

    local roleBackground
    if roleButton.GetName then roleBackground = _G[roleButton:GetName() .. "Background"] end

    if roleBackground then
      roleBackground:ClearAllPoints()
      roleBackground:SetPoint("TOPLEFT", roleButton, "TOPLEFT", -24,  24)
    end
  end

  SkinRoleButton("RoleTank", "tank2")
  local roleTankButton
  if gf.GetName then roleTankButton = _G[gf:GetName() .. "RoleTank"] end
  if roleTankButton then
    roleTankButton:ClearAllPoints()
    roleTankButton:SetPoint("TOPLEFT", gf, "TOPLEFT", 83,  -61)
  end

  SkinRoleButton("RoleHealer", "healer2")
  local roleHealerButton
  if gf.GetName then roleHealerButton = _G[gf:GetName() .. "RoleHealer"] end
  if roleHealerButton and roleTankButton then
    roleHealerButton:ClearAllPoints()
    roleHealerButton:SetPoint("LEFT", roleTankButton, "RIGHT", 62,  0)
  end

  SkinRoleButton("RoleDamage", "damage2")
  local roleDamageButton
  if gf.GetName then roleDamageButton = _G[gf:GetName() .. "RoleDamage"] end
  if roleDamageButton and roleHealerButton then
    roleDamageButton:ClearAllPoints()
    roleDamageButton:SetPoint("LEFT", roleHealerButton, "RIGHT", 62,  0)
  end

  -- close button
  local lFTFrameCloseButton = GetNoNameObject(
    LFTFrame,
    "Button",
    nil,
    "UI-Panel-MinimizeButton-Up"
  )
  if lFTFrameCloseButton then
    SkinCloseButton(lFTFrameCloseButton, gf.backdrop, -6, -6)
  end

	-- tabs
  local queueTab, browseTab
  if gf.GetName then
    queueTab = _G[gf:GetName() .. "Tab1"]
    browseTab = _G[gf:GetName() .. "Tab2"]
  end
  if _G.QueueTab then queueTab = _G.QueueTab end
  if _G.BrowseTab then browseTab = _G.BrowseTab end


  if queueTab then
    SkinTab(queueTab, 1)
    queueTab:ClearAllPoints()
    queueTab:SetPoint(
      "TOPLEFT",
      gf.backdrop,
      "BOTTOMLEFT",
      bpad,
      -(border + (border == 1 and 1 or 2))
    )
  end
  if browseTab then
    SkinTab(browseTab, 1)
    browseTab:ClearAllPoints()
    browseTab:SetPoint("LEFT", queueTab, "RIGHT", border*2 + 1, 0)
  end

  -- new group frame
  if LFTNewGroupFrame then
    local ngf = LFTNewGroupFrame
    StripTextures(ngf, nil, "BACKGROUND")
    CreateBackdrop(ngf, nil, nil, .75)
    CreateBackdropShadow(ngf)

    if ngf.backdrop then
      ngf.backdrop:SetPoint("TOPLEFT", 14, -10)
      ngf.backdrop:SetPoint("BOTTOMRIGHT", -14, 2)
      if ngf.SetHitRectInsets then
        ngf:SetHitRectInsets(14, 14, 10, 2)
      end
    end

    -- title box
    local ngTitleBox = _G["LFTNewGroupTitleText"]
    local ngTitleLabel = _G["LFTNewGroupLabelTitle"]
    if ngTitleBox then
      ngTitleBox:SetScript("OnEscapePressed", function() this:ClearFocus() end)
      ngTitleBox:SetWidth(246)
      ngTitleBox:SetHeight(25)
      ngTitleBox:SetTextInsets(10, 10, 5, 5)
      ngTitleBox:SetFontObject(GameFontNormal)
      if ngTitleLabel then
        ngTitleBox:ClearAllPoints()
        ngTitleBox:SetPoint("TOPLEFT", ngTitleLabel, "BOTTOMLEFT", -2, -4)
      end
      CreateBackdrop(ngTitleBox, nil, true)
    end

    -- title box background
    local ngTitleBoxBg = _G["LFTNewGroupTitleBackground"]
    if ngTitleBoxBg then
      StripTextures(ngTitleBoxBg)
      if ngTitleLabel then
        ngTitleBoxBg:ClearAllPoints()
        ngTitleBoxBg:SetPoint("TOPLEFT", ngTitleLabel, "BOTTOMLEFT", -2, -4)
      end
    end

    -- description box background
    local ngDescriptionBoxBg = _G["LFTNewGroupDescriptionBackground"]
    local ngDescriptionLabel = _G["LFTNewGroupLabelDescription"]
    if ngDescriptionBoxBg then
      StripTextures(ngDescriptionBoxBg)
      CreateBackdrop(ngDescriptionBoxBg)
      if ngDescriptionLabel then
        ngDescriptionBoxBg:ClearAllPoints()
        ngDescriptionBoxBg:SetPoint("TOPLEFT", ngDescriptionLabel, "BOTTOMLEFT", -2, -4)
      end
    end

    -- description box
    local ngDescriptionBox = _G["LFTNewGroupDescription"]
    if ngDescriptionBox then
      local descriptionBar = _G[ngDescriptionBox:GetName() .. "ScrollBar"]
      if descriptionBar then SkinScrollbar(descriptionBar) end

      if ngDescriptionBoxBg and ngDescriptionBoxBg.backdrop then
        ngDescriptionBox:ClearAllPoints()
        ngDescriptionBox:SetPoint("TOPLEFT", ngDescriptionBoxBg.backdrop, "TOPLEFT", 4, -6)
        ngDescriptionBox:SetHeight(110)
      end
    end
    local ngDescriptionText = _G["LFTNewGroupDescriptionText"]
    if ngDescriptionText then
      ngDescriptionText:SetScript("OnEscapePressed", function() this:ClearFocus() end)
    end

    -- roles checkbutton
    local ngUseRolesButton = _G["LFTNewGroupUseRolesButton"]
    if ngUseRolesButton then
      SkinCheckbox(ngUseRolesButton, checkBoxSize)
      CreateBackdrop(ngUseRolesButton, nil, true)
      local ngUseRolesText = _G[ngUseRolesButton:GetName().."Text"]
      if ngUseRolesText then
        ngUseRolesText:ClearAllPoints()
        ngUseRolesText:SetPoint("LEFT", ngUseRolesButton.backdrop, "RIGHT", 4, 0)
      end
    end

    local function SkinRoleEditBox(editBoxName, textureName)
      local ngRoleBox = _G[editBoxName]
      if ngRoleBox then
        StripTextures(ngRoleBox, nil, "BACKGROUND")
        CreateBackdrop(ngRoleBox, nil, true)
        local ngRoleBoxIcon = _G[ngRoleBox:GetName() .. "Icon"]
        local texturePath = "Interface\\AddOns\\pfUI-turtle\\img\\" .. textureName
        if ngRoleBoxIcon then
          ngRoleBoxIcon:SetTexture(nil)
        end

        local editBoxIconFrameName = editBoxName .. "IconFrame"
        local editBoxIconFrameIconName = editBoxIconFrameName .. "Icon"
        if not _G[editBoxIconFrameName] then
          _G[editBoxIconFrameName] = CreateFrame(
            "Frame",
            editBoxIconFrameName,
            ngRoleBox
          )
          local ngRoleBoxIconFrame = _G[editBoxIconFrameName]
          ngRoleBoxIconFrame:SetHeight(32)
          ngRoleBoxIconFrame:SetWidth(32)
          _G[editBoxIconFrameIconName] = ngRoleBoxIconFrame:CreateTexture(
            editBoxIconFrameIconName,
            "OVERLAY"
          )
          local ngRoleBoxIconFrameIcon = _G[editBoxIconFrameIconName]
          ngRoleBoxIconFrameIcon:SetTexture(texturePath)
          pfUI.api.CreateBackdrop(ngRoleBoxIconFrame, nil, true)
          pfUI.api.SetAllPointsOffset(
            ngRoleBoxIconFrameIcon,
            ngRoleBoxIconFrame,
            1
          )
          ngRoleBoxIconFrame:SetPoint("LEFT", ngRoleBox, "LEFT", -24, 0)

          hooksecurefunc("LFTNewGroupUseRolesButton_OnClick", function()
            if not this:GetChecked() then
              ngRoleBoxIconFrame:SetAlpha(0.5)
              ngRoleBoxIconFrameIcon:SetDesaturated(1)
            else
              ngRoleBoxIconFrame:SetAlpha(1)
              ngRoleBoxIconFrameIcon:SetDesaturated(nil)
            end
          end)
        end
      end
    end

    -- role editboxes
    SkinRoleEditBox("LFTNewGroupTanksEditBox", "tank2")
    SkinRoleEditBox("LFTNewGroupHealersEditBox", "healer2")
    SkinRoleEditBox("LFTNewGroupDamageEditBox", "damage2")

    -- buttons
    if LFTNewGroupOkButton then
      SkinButton(LFTNewGroupOkButton)
      LFTNewGroupOkButton:ClearAllPoints()
      LFTNewGroupOkButton:SetPoint("BOTTOMRIGHT", LFTNewGroupFrame, -106, 14)
    end
    if LFTNewGroupCancelButton then
      SkinButton(LFTNewGroupCancelButton)
    end
  end


  gf.pfui_turtleGF_skinned = true

end)
