local addon, FragInspector = ...


local btnFI_context = UI.CreateContext("btnFI_context")
btnFI_context:SetStrata("topmost")
local btnFI = UI.CreateFrame("Texture", "btnFI", btnFI_context)
local img = [[Data\UI\item_icons\fatestone_09_teal.dds]]
btnFI:SetTexture("Rift", img)



print(dX,dY)
local function ShowButtonFI()

    local dX = FI_Settings.CharLeft or 0
    local dY = FI_Settings.CharTop or 0
    
    if UI.Native.Character:GetLoaded() then 
        btnFI:SetPoint("TOPLEFT", UI.Native.Character, "TOPLEFT", 30+dX,10+dY)
        btnFI:SetLayer(UI.Native.Character:GetLayer() +1)
        btnFI:SetVisible(true)
    else
        if btnFI then btnFI:SetVisible(false) end
    end    
end    
   

local function CheckCharXY()
    if UI.Native.Character:GetLeft() ~= 0 then FI_Settings.CharLeft = UI.Native.Character:GetLeft() end
    if UI.Native.Character:GetTop() ~= 0 then FI_Settings.CharTop = UI.Native.Character:GetTop() end
    if UI.Native.Character:GetHeight() ~= 0 then FI_Settings.CharHeight = UI.Native.Character:GetHeight() end   
end

local function btnFIClick()
   CheckCharXY() 
end
    
UI.Native.Character:EventAttach(Event.UI.Native.Loaded, ShowButtonFI, "btnFI Set Location")
btnFI:EventAttach(Event.UI.Input.Mouse.Left.Click, function(self, h) btnFIClick() end, "Event.UI.Input.Mouse.Right.Click")