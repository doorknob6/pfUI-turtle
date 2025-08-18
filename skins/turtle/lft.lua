-- TurtleWoW Group Finder 1.18
pfUI:RegisterSkin("Turtle Group Finder", "vanilla", function()
  if pfUI_config["disabled"] and pfUI_config["disabled"]["skin_Turtle Group Finder"] == "1" then
    return
  end

    local gf = LFTFrame

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
    end

    -- buttons
	if LFTFrameMainButton then
		StripTextures(LFTFrameMainButton, true)
		SkinButton(LFTFrameMainButton)
		LFTFrameMainButton:SetWidth(100)
	end

	if LFTFrameRefreshButton then
		StripTextures(LFTFrameRefreshButton, true)
		SkinButton(LFTFrameRefreshButton)
		LFTFrameRefreshButton:SetWidth(100)
	end

	if LFTFrameNewGroupButton then
		StripTextures(LFTFrameNewGroupButton, true)
		SkinButton(LFTFrameNewGroupButton)
		LFTFrameNewGroupButton:SetWidth(100)
		LFTFrameNewGroupButton:ClearAllPoints()
		LFTFrameNewGroupButton:SetPoint("LEFT", LFTFrameRefreshButton, "RIGHT", 15, 0)
	end

	if LFTFrameSignUpButton then
		StripTextures(LFTFrameSignUpButton, true)
		SkinButton(LFTFrameSignUpButton)
		LFTFrameSignUpButton:SetWidth(100)
		LFTFrameSignUpButton:ClearAllPoints()
		LFTFrameSignUpButton:SetPoint("LEFT", LFTFrameNewGroupButton, "RIGHT", 15, 0)
	end

  -- checkboxes
  local checkBoxSize = 18
  if LFTFrameRoleTankCheckButton then
    SkinCheckbox(LFTFrameRoleTankCheckButton, checkBoxSize)
    CreateBackdrop(LFTFrameRoleTankCheckButton, nil, true)
  end
  if LFTFrameRoleHealerCheckButton then
    SkinCheckbox(LFTFrameRoleHealerCheckButton, checkBoxSize)
    CreateBackdrop(LFTFrameRoleHealerCheckButton, nil, true)
  end
  if LFTFrameRoleDamageCheckButton then
    SkinCheckbox(LFTFrameRoleDamageCheckButton, checkBoxSize)
    CreateBackdrop(LFTFrameRoleDamageCheckButton, nil, true)
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
    queueTab:SetPoint("TOPLEFT", gf, "BOTTOMLEFT", 15, 70)
  end
  if browseTab then
    SkinTab(browseTab, 1)
    browseTab:ClearAllPoints()
    browseTab:SetPoint("LEFT", queueTab, "RIGHT", 10, 0)
  end

  -- scrollbars
  local c1, c2, c3, c4, c5, c6, c7, c8 = gf:GetChildren()
  local kids = { c1, c2, c3, c4, c5, c6, c7, c8 }
  local i = 1
  while kids[i] do
    local child = kids[i]
    if child and child.GetObjectType and child:GetObjectType() == "ScrollFrame" and child.GetName then
      local bar = _G[child:GetName() .. "ScrollBar"]
      if bar then SkinScrollbar(bar) end
    end
    i = i + 1
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

  -- search edit box
  local searchBox = _G["LFTFrameSearch"]
  if searchBox then
    StripTextures(searchBox, nil, "BACKGROUND")
    local searchIcon = _G["LFTFrameSearchIcon"]
    if searchIcon then
      searchIcon:ClearAllPoints()
      searchIcon:SetPoint("LEFT", searchBox, "LEFT", 3, -1)
    end
    searchBox:SetScript("OnEscapePressed", function() this:ClearFocus() end)
    searchBox:SetTextInsets(18, 20, 5, 5)
    searchBox:SetFontObject(GameFontNormal)
    CreateBackdrop(searchBox, nil, true)
  end


  gf.pfui_turtleGF_skinned = true

end)
