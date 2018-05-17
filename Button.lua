local addon, FragInspector = ...


local btnFI_context = UI.CreateContext("btnFI_context")
local btnFI = UI.CreateFrame("Texture", "btnFI", btnFI_context)
local img = [[Data\UI\item_icons\fatestone_09_teal.dds]]
btnFI:SetTexture("Rift", img)
btnFI_context:SetStrata("topmost")
btnFI:SetPoint("TOPLEFT", UI.Native.Character, "TOPLEFT", 30,10)
btnFI:SetVisible(false)

function btnFI.SetLocation()
    if UI.Native.Character:GetLoaded() then
        
        btnFI:SetLayer(UI.Native.Character:GetLayer() +1)
        btnFI:SetPoint("TOPLEFT", UI.Native.Character, "TOPLEFT", 30,10)
        btnFI:SetVisible(true)
    else
        btnFI:SetVisible(false)
    end

end    
    
    
UI.Native.Character:EventAttach(Event.UI.Native.Loaded, btnFI.SetLocation, "btnFI Set Location")
