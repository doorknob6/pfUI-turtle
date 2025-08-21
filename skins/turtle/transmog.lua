-- TurtleWoW Transmog UI
pfUI:RegisterSkin("Turtle Transmog UI", "vanilla", function()
  if pfUI_config["disabled"] and pfUI_config["disabled"]["skin_Turtle Transmog UI"] == "1" then
    return
  end

  local rawborder, border = pfUI.api.GetBorderSize()
  local bpad = rawborder > 1 and border - pfUI.api.GetPerfectPixel() or pfUI.api.GetPerfectPixel()

  local transmogFrameName = "TransmogFrame"
  local tf = _G[transmogFrameName]
  if tf then
    pfUI.api.StripTextures(tf)
    pfUI.api.CreateBackdrop(tf, nil, nil, 0.75)
    pfUI.api.CreateBackdropShadow(tf)

    -- hide vendor portrait
    local tfPortrait = _G[transmogFrameName .. "Portrait"]
    if tfPortrait then
        tfPortrait:Hide()
    end

    -- close button
    local tfCloseButton = _G[transmogFrameName .. "CloseButton"]
    if tfCloseButton then
        pfUI.api.SkinCloseButton(tfCloseButton, tf.backdrop, -6, -6)
    end

    -- search box
    local tfSearchBoxName = transmogFrameName .. "Search"
    local tfSearchBox = _G[tfSearchBoxName]
    if tfSearchBox then
      pfUI.api.StripTextures(tfSearchBox, nil, "BACKGROUND")
      local searchIcon = _G[tfSearchBoxName .. "Icon"]
      if tfSearchBox.GetName then searchIcon = _G[tfSearchBox:GetName() .. "SearchIcon"] end
      if not searchIcon and _G.TransmogFrameSearchIcon then searchIcon = _G.TransmogFrameSearchIcon end
      if searchIcon then
        searchIcon:ClearAllPoints()
        searchIcon:SetPoint("LEFT", tfSearchBox, "LEFT", 3, -1)
      end
      tfSearchBox:SetHeight(25)
      tfSearchBox:SetScript("OnEscapePressed", function() this:ClearFocus() end)
      pfUI.api.CreateBackdrop(tfSearchBox, nil, true)
    end

    -- outfits dropdown
    local tfOutfitsName = transmogFrameName .. "Outfits"
    local tfOutfits = _G[tfOutfitsName]
    if tfOutfits then
        pfUI.api.SkinDropDown(tfOutfits)
    end

    -- save outfit button
    local tfSaveOutfitName = transmogFrameName .. "SaveOutfit"
    local tfSaveOutfit = _G[tfSaveOutfitName]
    if tfSaveOutfit then
        pfUI.api.SkinButton(tfSaveOutfit)
    end

    -- delete outfit button
    local tfDeleteOutfitName = transmogFrameName .. "DeleteOutfit"
    local tfDeleteOutfit = _G[tfDeleteOutfitName]
    if tfDeleteOutfit then
      pfUI.api.SkinButton(tfDeleteOutfit, 1, 0.25, 0.25)

      tfDeleteOutfit:SetWidth(15)
      tfDeleteOutfit:SetHeight(15)
      tfDeleteOutfit:SetHitRectInsets(0, 0, 0, 0)

      tfDeleteOutfit.texture = tfDeleteOutfit:CreateTexture(
        "pfUITurtleDisbandArenaTeam"
      )
      local texturePath = "Interface\\AddOns\\pfUI-turtle\\img\\cancel"
      tfDeleteOutfit.texture:SetTexture(texturePath)
      tfDeleteOutfit.texture:ClearAllPoints()
      tfDeleteOutfit.texture:SetAllPoints(tfDeleteOutfit)
      tfDeleteOutfit.texture:SetVertexColor(1,.25,.25,1)

      if tfSaveOutfit then
        tfDeleteOutfit:ClearAllPoints()
        tfDeleteOutfit:SetPoint(
          "LEFT",
          tfSaveOutfit,
          "Right",
          bpad,
          0
        )
      end
    end

    -- drop race background
    local tfRaceBackgroundName = transmogFrameName .. "RaceBackground"
    local tfRaceBackground = _G[tfRaceBackgroundName]
    if tfRaceBackground then
        tfRaceBackground:Hide()
    end

    -- skin apply button
    local tfApplyButtonName = transmogFrameName .. "ApplyButton"
    local tfApplyButton = _G[tfApplyButtonName]
    if tfApplyButton then
        pfUI.api.SkinButton(tfApplyButton)
    end

    -- skin items and sets tab buttons button
    local tfItemsButtonName = transmogFrameName .. "ItemsButton"
    local tfItemsButton = _G[tfItemsButtonName]
    if tfItemsButton then
        pfUI.api.SkinTab(tfItemsButton)
        tfItemsButton:SetNormalTexture("")
        tfItemsButton:SetHighlightTexture("")
        tfItemsButton:SetPushedTexture("")
    end
    local tfSetsButtonName = transmogFrameName .. "SetsButton"
    local tfSetsButton = _G[tfSetsButtonName]
    if tfSetsButton then
      pfUI.api.SkinTab(tfSetsButton)
      tfSetsButton:SetNormalTexture("")
      tfSetsButton:SetHighlightTexture("")
      tfSetsButton:SetPushedTexture("")
      if tfItemsButton then
        tfSetsButton:ClearAllPoints()
        tfSetsButton:SetPoint("LEFT", tfItemsButton, "RIGHT", border*2 + 1, 0)
      end

    end

    -- also hook the switch tab function as the textures are set again on every tab switch
    hooksecurefunc("Transmog_SwitchTab", function()
      tfItemsButton:SetNormalTexture("")
      tfItemsButton:SetHighlightTexture("")
      tfItemsButton:SetPushedTexture("")
      tfSetsButton:SetNormalTexture("")
      tfSetsButton:SetHighlightTexture("")
      tfSetsButton:SetPushedTexture("")
    end)

    -- hide textures for a single item or set button.
    -- Uses the type of normal texture set by the turtle wow lua methods to determine
    -- if the item button should be highlighted or not.
    local function hideButtonTextures(button)
      if not button then return end
      local normalTexture = button:GetNormalTexture()
      if normalTexture then
        local normalTextureName = normalTexture:GetTexture()
        if normalTextureName then
          if string.find(normalTextureName, "item_bg_selected", 1) and button.LockHighlight and not button.locked then
            button:LockHighlight()
          end
          if string.find(normalTextureName, "item_bg_normal", 1) and button.UnlockHighlight then
            button:UnlockHighlight()
          end
        end
      end

      button:SetNormalTexture("")
      button:SetHighlightTexture("")
      button:SetPushedTexture("")
      button:SetDisabledTexture("")
    end

    -- hide all item and set button textures
    local function hideAllButtonTextures()
      local i = 1
      local button = _G["TransmogLook" .. i .. "Button"]
      while button do
        hideButtonTextures(button)
        i = i + 1
        button = _G["TransmogLook" .. i .. "Button"]
      end
    end

    -- Skin the item and sets look buttons
    -- Hook the tooltip function as one method to create the look buttons is local only
    -- and the tooltip function is called from both the local and global method.
    -- We have to remove the textures every time as multiple local methods reset the textures.
    -- Hooking this function also allows for highlights to be reset - as the hooked method
    -- overwrites "OnEnter" and "OnLeave" scripts.
    hooksecurefunc("AddButtonOnEnterTextTooltip", function(frame, text, ext, error, anchor, x, y)
      local frameName = frame:GetName()
      if not frameName then return end
      if not string.find(frameName, "TransmogLook", 1) then return end
      hideButtonTextures(frame)

      pfUI.api.CreateBackdrop(frame)
      frame.locked = false

      -- Have to set this to false as the scripts keep being overwritten, so the
      -- SetHighlight method has to be run every time.
      frame.pfEnterLeave = false
      pfUI.api.SetHighlight(frame, 1, 1, 1)
      frame.LockHighlight = function()
        frame.backdrop:SetBackdropBorderColor(1,1,1,1)
        frame.locked = true
      end

      frame.UnlockHighlight = function()
        frame.backdrop:SetBackdropBorderColor(
          pfUI.api.GetStringColor(pfUI_config.appearance.border.color)
        )
        frame.locked = false
      end

      frame:SetHeight(120 - (2 * border + 1))
      frame:SetWidth(90 - (2 * border + 1))

      local modelFrameName = string.gsub(frameName, "Button", "ItemModel")
      local modelFrame = _G[modelFrameName]
      if modelFrame then
        pfUI.api.SetAllPointsOffset(modelFrame, frame, 0)
      end
    end)

    -- hook the Transmog_Try function as it sets the normal texture
    hooksecurefunc("Transmog_Try", function(itemId, slotName, newReset)
      hideAllButtonTextures()
    end)

    -- skin the forward and backward buttons
    local arrowButtonSize = 15
    local tfLeftArrowName = transmogFrameName .. "LeftArrow"
    local tfLeftArrow = _G[tfLeftArrowName]
    if tfLeftArrow then
        pfUI.api.SkinArrowButton(tfLeftArrow, "left", arrowButtonSize)
    end

    local tfRightArrowName = transmogFrameName .. "RightArrow"
    local tfRightArrow = _G[tfRightArrowName]
    if tfRightArrow then
        pfUI.api.SkinArrowButton(tfRightArrow, "right", arrowButtonSize)
    end

    -- item slots

    -- This global function has to be hooked to properly set item slot button
    -- highlighting, as the Turtle WoW implementation overwrites the item slot button
    -- "OnEnter" and "OnLeave" scripts.
    hooksecurefunc("AddButtonOnEnterTooltipFashion", function(frame, itemLink, TransmogText, revert)
      if not frame then return end

      -- Have to set this to false as the scripts keep being overwritten, so the
      -- SetHighlight method has to be run every time.
      frame.pfEnterLeave = false
      pfUI.api.SetHighlight(frame, 1, 1, 1)
    end)

    local function skinItemSlotButton(itemSlotName)
      -- skin item slot button
      local itemSlot = _G[itemSlotName]
      local itemSlotIconTextureName = itemSlotName .. "ItemIcon"
      local itemSlotIcon = _G[itemSlotIconTextureName]
      if itemSlot and itemSlotIcon then
        local iS = itemSlot
        iS:SetNormalTexture("")
        iS:SetHighlightTexture("")
        iS:SetPushedTexture("")
        iS:SetDisabledTexture("")

        pfUI.api.CreateBackdrop(iS)

        pfUI.api.SetAllPointsOffset(itemSlotIcon, iS, 2)
        itemSlotIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

        iS.LockHighlight = function()
          iS.backdrop:SetBackdropBorderColor(1,1,1,1)
          iS.locked = true
        end

        iS.UnlockHighlight = function()
          iS.backdrop:SetBackdropBorderColor(
            pfUI.api.GetStringColor(pfUI_config.appearance.border.color)
          )
          iS.locked = false
        end
      end

      -- move animation to fit the button
      local autoCastName = itemSlotName .. "AutoCast"
      local autoCast = _G[autoCastName]
      if itemSlot and autoCast then
        autoCast:ClearAllPoints()
        autoCast:SetPoint("TOPLEFT", itemSlot, "TOPLEFT", -1, 1)
        autoCast:SetPoint("BOTTOMRIGHT", itemSlot, "BOTTOMRIGHT", 2, -2)
      end

      -- hide normal borders
      local borderNormalName = itemSlotName .. "Border"
      local borderNormal = _G[borderNormalName]
      if borderNormal then
        borderNormal:SetTexture("")
      end

      -- hide selected border
      local borderSelectedName = itemSlotName .. "BorderSelected"
      local borderSelected = _G[borderSelectedName]
      if borderSelected then
        borderSelected:SetTexture("")
      end

      -- create a new frame to lock the item slot highlight upon show and hide it when
      -- hidden. Set it to override the [ItemSlot]BorderSelected global variable to be
      -- shown and hidden at the correct times.
      if itemSlot then
        local f = itemSlot
        local b = CreateFrame("Frame", nil, f)

        f.highlighter = b
        b.highlightee = f

        if not f.HookScript then f.HookScript = HookScript end
        local show, hide = f:GetScript("OnShow"), f:GetScript("OnLeave")

        local function onShow()
          if this.highlightee and this.highlightee.LockHighlight then
            this.highlightee:LockHighlight()
          end
        end

        if show then
          b:HookScript("OnShow", onShow)
        else
          b:SetScript("OnShow", onShow)
        end

        local function onHide()
          if this.highlightee and this.highlightee.UnlockHighlight then
            this.highlightee:UnlockHighlight()
          end
        end

        if hide then
          b:HookScript("OnHide", onHide)
        else
          b:SetScript("OnHide", onHide)
        end


        _G[borderSelectedName] = f.highlighter
      end

      -- hide full border
      local borderFullName = itemSlotName .. "BorderFull"
      local borderFull = _G[borderFullName]
      if borderFull then
        borderFull:SetTexture("")
      end

      -- hide hi border
      local borderHiName = itemSlotName .. "BorderHi"
      local borderHi = _G[borderHiName]
      if borderHi then
        borderHi:SetTexture("")
      end

      -- hide highlight border
      local borderHighlightName = itemSlotName .. "BorderHighlight"
      local borderHighlight = _G[borderHighlightName]
      if borderHighlight then
        borderHighlight:SetTexture("")
      end

      -- move no equip texture
      local noEquipName = itemSlotName .. "NoEquip"
      local noEquip = _G[noEquipName]
      if itemSlot and noEquip then
        pfUI.api.SetAllPointsOffset(noEquip, itemSlot, 2)
      end
    end

    skinItemSlotButton("HeadSlot")
    skinItemSlotButton("ShoulderSlot")
    skinItemSlotButton("BackSlot")
    skinItemSlotButton("ChestSlot")
    skinItemSlotButton("ShirtSlot")
    skinItemSlotButton("TabardSlot")
    skinItemSlotButton("WristSlot")
    skinItemSlotButton("HandsSlot")
    skinItemSlotButton("WaistSlot")
    skinItemSlotButton("LegsSlot")
    skinItemSlotButton("FeetSlot")
    skinItemSlotButton("MainHandSlot")
    skinItemSlotButton("SecondaryHandSlot")
    skinItemSlotButton("RangedSlot")
  end
end)