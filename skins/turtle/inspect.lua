pfUI:RegisterSkin("Inspect Turtle", "vanilla", function()
  -- skin is loaded after pfUI is booted - so check if it is disabled ourselves
  if (pfUI_config["disabled"] and
      pfUI_config["disabled"]["skin_Inspect Turtle"]  == "1") then
    return
  end
  local _, border = pfUI.api.GetBorderSize()

  pfUI.api.HookAddonOrVariable("InspectTalentsFrame", function()
    -- prevent Turtle WoW's interface script from creating the tab button when the
    -- inspect frame is shown for the first time by creating it ourselves
    if (not InspectFrameTab3) then
      CreateFrame('Button', 'InspectFrameTab3', InspectFrame, 'CharacterFrameTabButtonTemplate')
      InspectFrameTab3:SetPoint("LEFT", InspectFrameTab2, "RIGHT", border * 2 + 1, 0)
      pfUI.api.SkinTab(InspectFrameTab3)

      InspectFrameTab3:SetID(3)
      InspectFrameTab3:SetText('Talents')
      PanelTemplates_TabResize(0, InspectFrameTab3)
      PanelTemplates_SetNumTabs(InspectFrame, 3)

      InspectFrameTab3:SetScript("OnEnter", function()
        GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
        GameTooltip:SetText("Talents", 1.0, 1.0, 1.0)
      end)

      InspectFrameTab3:SetScript("OnLeave", function()
        GameTooltip:Hide()
      end)

      InspectFrameTab3:SetScript("OnClick", function()
        InspectFrameTalentsTab_OnClick()
      end)

      -- add the InspectTalentsFrame to the global INSPECTFRAME_SUBFRAMES, without
      -- overwriting the entire list
      if (INSPECTFRAME_SUBFRAMES) then
        INSPECTFRAME_SUBFRAMES[3] = "InspectTalentsFrame"
      end
    end

    pfUI.api.StripTextures(InspectTalentsFrame)

    if (TWTalentFrameTab1) then
      pfUI.api.SkinTab(TWTalentFrameTab1)
      if (TWTalentFrameScrollFrame) then
        TWTalentFrameTab1:SetPoint("TOPLEFT", TWTalentFrameScrollFrame, "TOPLEFT", 2,
          TWTalentFrameTab1:GetHeight() + 4)
      end
    end
    if (TWTalentFrameTab2) then pfUI.api.SkinTab(TWTalentFrameTab2) end
    if (TWTalentFrameTab3) then pfUI.api.SkinTab(TWTalentFrameTab3) end
    if (TWTalentFrameScrollFrame) then pfUI.api.StripTextures(TWTalentFrameScrollFrame) end
    if (TWTalentFrameScrollFrameScrollBar) then
       pfUI.api.SkinScrollbar(TWTalentFrameScrollFrameScrollBar)
    end

    for i = 1, MAX_NUM_TALENTS do
      local talent = _G["TWTalentFrameTalent" .. i]
      if talent then
        pfUI.api.StripTextures(talent)
        pfUI.api.SkinButton(talent, nil, nil, nil, _G["TWTalentFrameTalent" .. i .. "IconTexture"])

        _G["TWTalentFrameTalent" .. i .. "Rank"]:SetFont(pfUI.font_default, C.global.font_size, "OUTLINE")
      end
    end

    -- fix situation where talent frame doesn't update on unit change
    hooksecurefunc("InspectUnit", function()
      -- don't do anything when nothing inspectable is selected
      if (not UnitExists("target") or not UnitIsPlayer("target")) then
        return
      end
      -- check if talent frame is selected through the selected tab index and reopen it
      if (PanelTemplates_GetSelectedTab(InspectFrame) == 3) then
        InspectTalentsFrame:Hide()
        InspectFrameTalentsTab_OnClick()
      end
    end)
  end)
end)
