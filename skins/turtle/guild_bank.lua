pfUI:RegisterSkin("Guild Bank Turtle", "vanilla", function()
    -- skin is loaded after pfUI is booted - so check if it is disabled ourselves
    if (pfUI_config["disabled"] and
            pfUI_config["disabled"]["skin_Guild Bank Turtle"] == "1") then
        return
    end
    local rawborder, border = GetBorderSize()
    local bpad = rawborder > 1 and border - GetPerfectPixel() or GetPerfectPixel()

    -- no global values available, so we copy them locally
    local MAX_TABS = 5
    local MAX_SLOTS = 98

    -- Updates item slot backdrop border color
    local function UpdateSlotsBorderColor()
        for i = 1, MAX_SLOTS do
            local slot = _G["GuildBankFrameItem" .. i]
            if (not slot) then
                return
            end
            if (slot.itemID) then
                local _, _, itemRarity, _, _, _, _, _, _ = GetItemInfo(slot.itemID);
                if (itemRarity and
                        itemRarity > (
                            tonumber(pfUI_config["appearance"]["bags"]["borderlimit"]) or
                            1
                        )) then
                    slot.backdrop:SetBackdropBorderColor(GetItemQualityColor(itemRarity))
                else
                    slot.backdrop:SetBackdropBorderColor(pfUI.cache.er,
                        pfUI.cache.eg,
                        pfUI.cache.eb,
                        pfUI.cache.ea)
                end
            else
                slot.backdrop:SetBackdropBorderColor(pfUI.cache.er,
                    pfUI.cache.eg,
                    pfUI.cache.eb,
                    pfUI.cache.ea)
            end
        end
    end

    -- update item slot borders on tab frame change
    HookAddonOrVariable("GuildBankFrameTab_OnClick", function()
        hooksecurefunc("GuildBankFrameTab_OnClick", function()
                UpdateSlotsBorderColor()
            end,
            true)
    end)

    HookAddonOrVariable("GuildBankFrame", function()
        local GuildBank = CreateFrame("Frame")
        GuildBank.prefix = "TW_GUILDBANK"

        -- update item slot borders on item change events
        GuildBank:SetScript("OnEvent", function()
            if (event) then
                if (event == "CHAT_MSG_ADDON" and arg1 == GuildBank.prefix) then
                    if (string.find(message, "GDeposit:", 1, true) or
                            string.find(message, "GMoveItem:", 1, true) or
                            string.find(message, "GSwapItem:", 1, true) or
                            string.find(message, "GSplitItem:", 1, true) or
                            string.find(message, "GWithdraw:", 1, true) or
                            string.find(message, "GPartialWithdraw:", 1, true) or
                            string.find(message, "GDestroy:", 1, true) or
                            string.find(message, "GPartialDestroy:", 1, true)) then
                        QueueFunction(UpdateSlotsBorderColor)
                    end
                end
            end
        end)

        StripTextures(GuildBankFrame)
        CreateBackdrop(GuildBankFrame, nil, nil, .75)

        if (GuildBankFrameCloseButton) then
            SkinCloseButton(GuildBankFrameCloseButton, GuildBankFrame.backdrop, -6, -6)
        end

        -- item slot reskin
        if (GuildBankFrameSlots) then
            StripTextures(GuildBankFrameSlots)

            for i = 1, MAX_SLOTS do
                if (_G["GuildBankFrameItem" .. i]) then
                    StripTextures(_G["GuildBankFrameItem" .. i], false)
                    CreateBackdrop(_G["GuildBankFrameItem" .. i])
                    SetAllPointsOffset(_G["GuildBankFrameItem" .. i].backdrop,
                        _G["GuildBankFrameItem" .. i],
                        0)
                    HandleIcon(_G["GuildBankFrameItem" .. i].backdrop,
                        _G["GuildBankFrameItem" .. i .. "IconTexture"])
                end
            end
        end

        if (GuildBankFrameDepositButton) then
            StripTextures(GuildBankFrameDepositButton, true)
            SkinButton(GuildBankFrameDepositButton)
        end

        if (GuildBankFrameFrameWithdrawButton) then
            StripTextures(GuildBankFrameFrameWithdrawButton, true)
            SkinButton(GuildBankFrameFrameWithdrawButton)
            GuildBankFrameFrameWithdrawButton:SetPoint("RIGHT",
                GuildBankFrameDepositButton,
                "LEFT",
                -2 * border,
                0)
        end

        for i = 1, MAX_TABS do
            local tab = _G["GuildBankFrameTab" .. i]
            if (tab) then
                StripTextures(tab, false)
                CreateBackdrop(tab)
                SetAllPointsOffset(tab.backdrop, tab, 0)
                HandleIcon(tab.backdrop, tab:GetNormalTexture())
                HandleIcon(tab.backdrop, tab:GetPushedTexture())

                if (i == 1) then
                    tab:SetPoint("TOPLEFT",
                        GuildBankFrame.backdrop,
                        "TOPRIGHT",
                        (border + (border == 1 and 1 or 2)),
                        0)
                else
                    local previousTab = _G["GuildBankFrameTab" .. i - 1]
                    if (previousTab) then
                        tab:SetPoint("TOP",
                            previousTab,
                            "BOTTOM",
                            0,
                            -2 * border + 1)
                    end
                end
            end
        end

        if (GuildBankFrameBottomTab1) then
            SkinTab(GuildBankFrameBottomTab1)
            GuildBankFrameBottomTab1:SetPoint("TOPLEFT",
                GuildBankFrame.backdrop,
                "BOTTOMLEFT",
                bpad,
                -(border + (border == 1 and 1 or 2)))
        end
        if (GuildBankFrameBottomTab2) then
            SkinTab(GuildBankFrameBottomTab2)
            GuildBankFrameBottomTab2:SetPoint("LEFT",
                GuildBankFrameBottomTab1,
                "RIGHT",
                border * 2 + 1,
                0)
        end
        if (GuildBankFrameBottomTab3) then
            SkinTab(GuildBankFrameBottomTab3)
            GuildBankFrameBottomTab3:SetPoint("LEFT",
                GuildBankFrameBottomTab2,
                "RIGHT",
                border * 2 + 1,
                0)
        end

        if (GuildBankFrameTabSettings) then
            StripTextures(GuildBankFrameTabSettings)
            CreateBackdrop(GuildBankFrameTabSettings, nil, nil, .75)
            GuildBankFrameTabSettings:ClearAllPoints()
            GuildBankFrameTabSettings:SetPoint("TOPLEFT",
                GuildBankFrame.backdrop,
                "TOPRIGHT",
                (border + (border == 1 and 1 or 2)),
                -bpad)
            if (GuildBankFrameTabSettingsTabNameEditBox) then
                StripTextures(GuildBankFrameTabSettingsTabNameEditBox)
                GuildBankFrameTabSettingsTabNameEditBox:SetTextInsets(5, 5, 5, 5)
                GuildBankFrameTabSettingsTabNameEditBox:SetFontObject(GameFontNormal)
                CreateBackdrop(GuildBankFrameTabSettingsTabNameEditBox, nil, true)
                GuildBankFrameTabSettingsTabNameEditBox:SetWidth(211)
            end
            if (GuildBankFrameTabSettingsAccessDropdown) then
                SkinDropDown(GuildBankFrameTabSettingsAccessDropdown)
                GuildBankFrameTabSettingsAccessDropdown:SetWidth(125)
                if (GuildBankFrameTabSettingsAccessDropdown.button) then
                    GuildBankFrameTabSettingsAccessDropdown.button:SetScript("OnEnter",
                        GuildBankFrameTabSettingsAccessDropdown:GetScript("OnEnter"))
                end
            end
            if (GuildBankFrameTabSettingsWithdrawalsDropdown) then
                SkinDropDown(GuildBankFrameTabSettingsWithdrawalsDropdown)
                GuildBankFrameTabSettingsWithdrawalsDropdown:SetWidth(125)
                if (GuildBankFrameTabSettingsWithdrawalsDropdown.button) then
                    GuildBankFrameTabSettingsWithdrawalsDropdown.button:SetScript("OnEnter",
                        GuildBankFrameTabSettingsWithdrawalsDropdown:GetScript("OnEnter"))
                end
            end

            if (GuildBankFrameTabSettingsScrollFrame) then
                StripTextures(GuildBankFrameTabSettingsScrollFrame)
                CreateBackdrop(GuildBankFrameTabSettingsScrollFrame, nil, true)
                SkinScrollbar(GuildBankFrameTabSettingsScrollFrameScrollBar)
                GuildBankFrameTabSettingsScrollFrame:ClearAllPoints()
                GuildBankFrameTabSettingsScrollFrame:SetPoint("TOPLEFT",
                    GuildBankFrameTabSettings,
                    "TOPLEFT",
                    10,
                    -110)
                GuildBankFrameTabSettingsScrollFrame:SetWidth(211 - 6 -
                    GuildBankFrameTabSettingsScrollFrameScrollBar:GetWidth())
            end

            if (GuildBankFrameTabSettingsCloseButton) then
                SkinCloseButton(GuildBankFrameTabSettingsCloseButton)
            end

            if (GuildBankFrameTabSettingsSaveButton) then
                StripTextures(GuildBankFrameTabSettingsSaveButton, true)
                SkinButton(GuildBankFrameTabSettingsSaveButton)
                GuildBankFrameTabSettingsSaveButton:SetWidth(105 - border)
                GuildBankFrameTabSettingsSaveButton:ClearAllPoints()
                GuildBankFrameTabSettingsSaveButton:SetPoint("BOTTOMLEFT",
                    GuildBankFrameTabSettings,
                    "BOTTOMLEFT",
                    10,
                    10)
            end
            if (GuildBankFrameTabSettingsCancelButton) then
                StripTextures(GuildBankFrameTabSettingsCancelButton, true)
                SkinButton(GuildBankFrameTabSettingsCancelButton)

                GuildBankFrameTabSettingsCancelButton:SetWidth(105 - border)
                GuildBankFrameTabSettingsCancelButton:ClearAllPoints()
                GuildBankFrameTabSettingsCancelButton:SetPoint("LEFT",
                    GuildBankFrameTabSettingsSaveButton,
                    "RIGHT",
                    (border + (border == 1 and 1 or 2)),
                    0)
            end
        end

        if (GuildBankFrameStackSplitFrame) then
            StripTextures(GuildBankFrameStackSplitFrame)
            GuildBankFrameStackSplitFrame:SetHeight(76)
            GuildBankFrameStackSplitFrame:SetWidth(162)
            CreateBackdrop(GuildBankFrameStackSplitFrame, nil, nil, .75)
            CreateBackdropShadow(GuildBankFrameStackSplitFrame)
            if (GuildBankFrameStackSplitFrameLeftButton) then
                GuildBankFrameStackSplitFrameLeftButton:ClearAllPoints()
                GuildBankFrameStackSplitFrameLeftButton:SetPoint("BOTTOMRIGHT",
                    GuildBankFrameStackSplitFrame,
                    "CENTER",
                    -50,
                    8)
            end
            if (GuildBankFrameStackSplitFrameRightButton) then
                GuildBankFrameStackSplitFrameRightButton:ClearAllPoints()
                GuildBankFrameStackSplitFrameRightButton:SetPoint("BOTTOMLEFT",
                    GuildBankFrameStackSplitFrame,
                    "CENTER",
                    50,
                    8)
            end
            if (GuildBankFrameStackSplitFrameSplitText) then
                GuildBankFrameStackSplitFrameSplitText:ClearAllPoints()
                GuildBankFrameStackSplitFrameSplitText:SetPoint("BOTTOM",
                    GuildBankFrameStackSplitFrame,
                    "CENTER",
                    0,
                    10)
            end
            if (GuildBankFrameStackSplitFrameOkayButton) then
                SkinButton(GuildBankFrameStackSplitFrameOkayButton)
                GuildBankFrameStackSplitFrameOkayButton:ClearAllPoints()
                GuildBankFrameStackSplitFrameOkayButton:SetPoint("TOPRIGHT",
                    GuildBankFrameStackSplitFrame,
                    "CENTER",
                    -3,
                    -2)
            end
            if (GuildBankFrameStackSplitFrameCancelButton) then
                SkinButton(GuildBankFrameStackSplitFrameCancelButton)
                GuildBankFrameStackSplitFrameCancelButton:ClearAllPoints()
                GuildBankFrameStackSplitFrameCancelButton:SetPoint("TOPLEFT",
                    GuildBankFrameStackSplitFrame,
                    "CENTER",
                    3,
                    -2)
            end
        end
    end)
end)
