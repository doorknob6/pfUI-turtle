-- TurtleWoW Group Finder (new) — STEP 1 (Lua 5.0 safe)
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

    gf.pfui_turtleGF_skinned = true
	
end)
