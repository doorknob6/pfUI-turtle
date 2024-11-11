pfUI:RegisterSkin("Looking for turtles", "vanilla", function ()
  -- skin is loaded after pfUI is booted - so check if it is disabled ourselves
  if (pfUI_config["disabled"] and
      pfUI_config["disabled"]["skin_Looking for turtles"]  == "1") then
    return
  end

  local _, border = GetBorderSize()

  -- updates a main dungeon list item if it hasn't been updated yet
  local updateMainDungeonListItem = function (name, dungeon)
    if (dungeon.isMainUpdated == true) then return end
    local frameName = "Dungeon_" .. dungeon.code
    if (not _G[frameName]) then return end
    local checkButtonName = frameName .. "_CheckButton"
    if (_G[checkButtonName]) then
      -- for some reason, when using `SkinCheckbox` or `CreateBackdrop` on these
      -- particular checkboxes, the resulting backdrop frames will always be shown in
      -- front of the checked checkbox texture
      -- therefore, a bit of a workaround is used where the normal texture is replaced
      -- directly, creating a checkbox without a border
      local br, bg, bb, ba = pfUI.api.GetStringColor(pfUI_config.appearance.border.background)
      _G[checkButtonName]:SetHighlightTexture("")
      _G[checkButtonName]:SetPushedTexture("")
      _G[checkButtonName]:GetNormalTexture():SetTexture(br, bg, bb, ba)
      _G[checkButtonName]:SetWidth(16)
      _G[checkButtonName]:SetHeight(16)
    end

    dungeon.isMainUpdated = true
  end

  -- updates main dungeon list items
  local updateMainDungeonListItems = function()
    for name, dungeon in pairs(TURTLE_DUNGEON_CODES) do
      updateMainDungeonListItem(name, dungeon)
    end
  end
  -- updates a browse dungeon list item if it hasn't been updated yet
  local updateBrowseDungeonListItem = function (name, dungeon)
    if (dungeon.isBrowseUpdated == true) then return end
    local frameName = "BrowseFrame_" .. dungeon.code
    if (not _G[frameName]) then return end
    local joinAsButtonName = frameName .. "_JoinAs"
    if (not _G[joinAsButtonName]) then return end
    StripTextures(_G[joinAsButtonName], true)
    SkinButton(_G[joinAsButtonName])
    dungeon.isBrowseUpdated = true
  end

  -- updates browse dungeon list items
  local updateBrowseDungeonListItems = function()
    for name, dungeon in pairs(TURTLE_DUNGEON_CODES) do
      updateBrowseDungeonListItem(name, dungeon)
    end
  end

  HookAddonOrVariable("LFT", function()
    StripTextures(LFTFrame, nil, "BACKGROUND")
    StripTextures(LFTFrame, nil, "ARTWORK")
    CreateBackdrop(LFTFrame, nil, nil, .75)
    CreateBackdropShadow(LFTFrame)
    LFTFrame.backdrop:SetPoint("TOPLEFT", 14, -10)
    LFTFrame.backdrop:SetPoint("BOTTOMRIGHT", -26, 72)
    LFTFrame:SetHitRectInsets(14,26,10,72)

    SkinCloseButton(LFTFrameCloseButton, LFTFrame.backdrop, -6, -6)
	
	-- LFTFrameInstancesList:SetPoint("TOPLEFT", LFTBrowse, "TOPLEFT", 25, -45)
    -- LFTFrameInstancesList:SetHeight(370)
    SkinScrollbar(LFTFrameInstancesListScrollBar)

    SkinCheckbox(RoleTank)
    SkinCheckbox(RoleHealer)
    SkinCheckbox(RoleDamage)

    SkinDropDown(LFTFrameDropDown)

    StripTextures(LFTFrameMainButton, true)
    SkinButton(LFTFrameMainButton)
    -- StripTextures(findMoreButton, true)
    -- SkinButton(findMoreButton)
    -- StripTextures(leaveQueueButton, true)
    -- SkinButton(leaveQueueButton)
	
	-- post-hook the `BrowseDungeonListFrame_Update` function to update the dungeon list
    -- items in the LFTBrowse Frame
    ---@diagnostic disable-next-line: param-type-mismatch
    hooksecurefunc("LFTFrameInstancesList_Update", updateBrowseDungeonListItems, true)

  end)



end)
