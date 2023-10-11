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
    StripTextures(LFTMain, nil, "BACKGROUND")
    StripTextures(LFTMain, nil, "ARTWORK")
    CreateBackdrop(LFTMain, nil, nil, .75)
    CreateBackdropShadow(LFTMain)
    LFTMain.backdrop:SetPoint("TOPLEFT", 14, -10)
    LFTMain.backdrop:SetPoint("BOTTOMRIGHT", -26, 72)
    LFTMain:SetHitRectInsets(14,26,10,72)

    SkinCloseButton(LFTMainCloseButton, LFTMain.backdrop, -6, -6)

    SkinCheckbox(RoleTank)
    SkinCheckbox(RoleHealer)
    SkinCheckbox(RoleDamage)

    SkinDropDown(LFTTypeSelect)

    -- post-hook the `DungeonListFrame_Update` function to update the dungeon list items
    -- in the LFTMain Frame
    ---@diagnostic disable-next-line: param-type-mismatch
    hooksecurefunc("DungeonListFrame_Update", updateMainDungeonListItems, true)

    SkinScrollbar(DungeonListScrollFrameScrollBar)

    StripTextures(findGroupButton, true)
    SkinButton(findGroupButton)
    StripTextures(findMoreButton, true)
    SkinButton(findMoreButton)
    StripTextures(leaveQueueButton, true)
    SkinButton(leaveQueueButton)

    -- replace the dungeons tab button
    LFTDungeonsButtonReplacement = CreateFrame("Button",
      "LFTDungeonsButtonReplacement",
      LFTlft,
      "UIPanelButtonTemplate")
    SkinButton(LFTDungeonsButtonReplacement)
    LFTDungeonsButtonReplacement:SetWidth(LFTDungeonsButton:GetWidth())
    LFTDungeonsButtonReplacement:SetHeight(LFTDungeonsButton:GetHeight())
    LFTDungeonsButton:Disable()
    LFTDungeonsButton:Hide()
    LFTDungeonsButtonReplacement:SetText(LFTMainDungeonsText:GetText())
    LFTMainDungeonsText:Hide()
    LFTBrowseDungeonsText:Hide()
    LFTDungeonsButtonReplacement:SetPoint("TOPLEFT",
      LFTMain.backdrop,
      "BOTTOMLEFT",
      0,
      -(border + (border == 1 and 1 or 2)))

    LFTDungeonsButtonReplacement:SetScript("OnShow", function()
      if (LFTMain:IsVisible()) then
        ---@diagnostic disable-next-line: undefined-global
        this:Disable()
      end
    end)

    LFTDungeonsButtonReplacement:SetScript("OnClick", function()
      lft_switch_tab(1)
      ---@diagnostic disable-next-line: undefined-global
      this:Disable()
      LFTBrowseButtonReplacement:Enable()
    end)

    StripTextures(LFTBrowse, nil, "BACKGROUND")
    StripTextures(LFTBrowse, nil, "ARTWORK")
    CreateBackdrop(LFTBrowse, nil, nil, .75)
    CreateBackdropShadow(LFTBrowse)
    LFTBrowse.backdrop:SetPoint("TOPLEFT", 14, -10)
    LFTBrowse.backdrop:SetPoint("BOTTOMRIGHT", -26, 72)
    LFTBrowse:SetHitRectInsets(14,26,10,72)

    SkinCloseButton(LFTBrowseCloseButton, LFTBrowse.backdrop, -6, -6)

    BrowseDungeonListScrollFrame:SetPoint("TOPLEFT", LFTBrowse, "TOPLEFT", 25, -45)
    BrowseDungeonListScrollFrame:SetHeight(370)
    SkinScrollbar(BrowseDungeonListScrollFrameScrollBar)

    -- replace the browse tab button
    LFTBrowseButtonReplacement = CreateFrame("Button",
      "LFTBrowseButtonReplacement",
      LFTlft,
      "UIPanelButtonTemplate")
    SkinButton(LFTBrowseButtonReplacement)
    LFTBrowseButtonReplacement:SetWidth(LFTBrowseButton:GetWidth())
    LFTBrowseButtonReplacement:SetHeight(LFTBrowseButton:GetHeight())
    LFTBrowseButton:Disable()
    LFTBrowseButton:Hide()
    LFTBrowseButtonReplacement:SetText(LFTMainBrowseText:GetText())
    LFTMainBrowseText:Hide()
    LFTBrowseBrowseText:Hide()
    LFTBrowseButtonReplacement:SetPoint("TOPLEFT",
      LFTDungeonsButtonReplacement,
      "TOPRIGHT",
      (border + (border == 1 and 1 or 2)),
      0)

    LFTBrowseButtonReplacement:SetScript("OnShow", function()
      if (LFTBrowse:IsVisible()) then
        ---@diagnostic disable-next-line: undefined-global
        this:Enable()
      end
    end)

    LFTBrowseButtonReplacement:SetScript("OnClick", function()
      lft_switch_tab(2)
      ---@diagnostic disable-next-line: undefined-global
      this:Disable()
      LFTDungeonsButtonReplacement:Enable()
    end)

    -- post-hook the `BrowseDungeonListFrame_Update` function to update the dungeon list
    -- items in the LFTBrowse Frame
    ---@diagnostic disable-next-line: param-type-mismatch
    hooksecurefunc("BrowseDungeonListFrame_Update", updateBrowseDungeonListItems, true)

  end)



end)