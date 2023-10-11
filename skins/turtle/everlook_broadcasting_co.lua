pfUI:RegisterSkin("Everlook Broadcasting Turtle", "vanilla", function()
    -- skin is loaded after pfUI is booted - so check if it is disabled ourselves
    if (pfUI_config["disabled"] and
        pfUI_config["disabled"]["skin_Everlook Broadcasting Turtle"]  == "1") then
      return
    end

    local _, border = GetBorderSize()

    local function SetFrameFont(frame, layer, text, font)
        local fontString = GetNoNameObject(frame, "FontString", layer, text)
        if (fontString) then
            fontString:SetFont(font:GetFont())
            return true
        end
        return false
    end

    HookAddonOrVariable("EBCMinimapDropdown", function()
        StripTextures(EBCMinimapDropdown)
        CreateBackdrop(EBCMinimapDropdown, nil, nil, .75)

        if (EBCMinimapDropdownTitle) then
            SetFrameFont(EBCMinimapDropdownTitle, nil, EBC_TITLE, GameTooltipHeaderText)
        end
        if (EBCMinimapDropdownCheckButton) then
            SkinCheckbox(EBCMinimapDropdownCheckButton)
        end
        if (EBCMinimapDropdownRadio) then
            SetFrameFont(EBCMinimapDropdownRadio, nil, EBC_STATION1, GameTooltipText)
        end
        if (EBCMinimapDropdownCheckButton2) then
            SkinCheckbox(EBCMinimapDropdownCheckButton2)
        end
        if (EBCMinimapDropdownRadio2) then
            SetFrameFont(EBCMinimapDropdownRadio2, nil, EBC_STATION2, GameTooltipText)
        end
        if (EBCMinimapDropdownSlider) then
            SkinSlider(EBCMinimapDropdownSlider)
            if (EBCMinimapDropdownVolText) then
                SetFrameFont(EBCMinimapDropdownVolText, nil, EBCMinimapDropdownSlider:GetValue(), GameTooltipText)
                -- text is set at (135, 10) in this frame
                -- comes out to (143, 6)
                EBCMinimapDropdownVolText:SetPoint("BOTTOMLEFT", EBCMinimapDropdown, "BOTTOMLEFT", 8, -4)
            end
        end
        if (EBCMinimapDropdownMuteButton) then
            EBCMinimapDropdownMuteButton:SetPoint("BOTTOMRIGHT", EBCMinimapDropdown, "BOTTOMRIGHT", -15, 4)
        end
    end)
  end)
