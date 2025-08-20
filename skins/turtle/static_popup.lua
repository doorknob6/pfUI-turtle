pfUI:RegisterSkin("Static popups Turtle", "vanilla", function()
    -- skin is loaded after pfUI is booted - so check if it is disabled ourselves
    if (pfUI_config["disabled"] and
            pfUI_config["disabled"]["skin_Static popups Turtle"] == "1") then
        return
    end

    -- adapted for turtle wow StaticPopup2
    -- https://github.com/shagu/pfUI/blob/master/skins/blizzard/popup_dialogs.lua
    for i = 1, STATICPOPUP2_NUMDIALOGS do
        local money = _G["StaticPopup2" .. i .. "MoneyInputFrame"]
        if money then -- turtle
            SkinMoneyInputFrame(money)
        end

        local dialog = _G["StaticPopup2" .. i]
        pfUI.api.CreateBackdrop(dialog, nil, true, .75)
        pfUI.api.CreateBackdropShadow(dialog)

        pfUI.api.SkinCloseButton(_G[dialog:GetName() .. "CloseButton"], dialog, -6, -6)

        pfUI.api.SkinButton(_G[dialog:GetName() .. "Button1"])
        pfUI.api.SkinButton(_G[dialog:GetName() .. "Button2"])

        local editbox = _G[dialog:GetName() .. "EditBox"]
        editbox:DisableDrawLayer("BACKGROUND")
        pfUI.api.CreateBackdrop(editbox)
        editbox:SetHeight(18)

        local wide_editbox = _G[dialog:GetName() .. "WideEditBox"]
        wide_editbox:DisableDrawLayer("BACKGROUND")
        pfUI.api.CreateBackdrop(wide_editbox)
        wide_editbox:SetHeight(18)
        wide_editbox:ClearAllPoints()
        wide_editbox:SetPoint("BOTTOM", 0, 45)
    end
end)
