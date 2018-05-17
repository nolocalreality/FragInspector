local addon, FragInspector = ...

FI_Settings = FI_Settings or {}



FragInspector.context = UI.CreateContext("FragInspector")
local window = UI.CreateFrame("SimpleWindow", "FI_ConfigWindow", FragInspector.context)


window:SetVisible(false)




local function init() 
    
    window:SetVisible(false)
    window:SetHeight(600)
    window:SetWidth(600)
    window:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 800, 100)
    window:SetTitle("FragInspector")
	window:SetLayer(-1)
	window:SetAlpha(1)
    window:SetCloseButtonVisible(true)
    

    

 
    window.air1 = Library.LibFragUI.Create("air1", window, "air")
    window.air1:SetPoint("TOPLEFT", window, "TOPLEFT", 50, 90) 
    
    window.air2 = Library.LibFragUI.Create("air2", window, "air")
    window.air2:SetPoint("TOPLEFT", window.air1, "TOPRIGHT", 50, 0)     
    
    
    window.death1 = Library.LibFragUI.Create("death1", window, "death")
    window.death1:SetPoint("TOPLEFT", window.air1, "BOTTOMLEFT", 0, 20) 
    
    window.death2 = Library.LibFragUI.Create("death2", window, "death")
    window.death2:SetPoint("TOPLEFT", window.death1, "TOPRIGHT", 50, 0)     
    
    
    window.earth1 = Library.LibFragUI.Create("earth1", window, "earth")
    window.earth1:SetPoint("TOPLEFT", window.death1, "BOTTOMLEFT", 0, 20) 
    
    window.earth2 = Library.LibFragUI.Create("earth2", window, "earth")
    window.earth2:SetPoint("TOPLEFT", window.earth1, "TOPRIGHT", 50, 0) 
    
    
    window.fire1 = Library.LibFragUI.Create("fire1", window, "fire")
    window.fire1:SetPoint("TOPLEFT", window.earth1, "BOTTOMLEFT", 0, 20) 
    
    window.fire2 = Library.LibFragUI.Create("fire2", window, "fire")
    window.fire2:SetPoint("TOPLEFT", window.fire1, "TOPRIGHT", 50, 0) 
    
    
    window.life1 = Library.LibFragUI.Create("life1", window, "life")
    window.life1:SetPoint("TOPLEFT", window.fire1, "BOTTOMLEFT", 0, 20) 
    
    window.life2 = Library.LibFragUI.Create("life2", window, "life")
    window.life2:SetPoint("TOPLEFT", window.life1, "TOPRIGHT", 50, 0)    
    

    window.water1 = Library.LibFragUI.Create("water1", window, "water")
    window.water1:SetPoint("TOPLEFT", window.life1, "BOTTOMLEFT", 0, 20) 
    
    window.water2 = Library.LibFragUI.Create("water2", window, "water")
    window.water2:SetPoint("TOPLEFT", window.water1, "TOPRIGHT", 50, 0) 
    

    window.airicon = UI.CreateFrame("Texture", "FI_airI", window)   
    window.airicon:SetPoint("TOPLEFT", window.air1, "TOPRIGHT", 15, 15)
    window.airicon:SetTexture("FragInspector", "UI/attribute_air.png")
    
    window.deathicon = UI.CreateFrame("Texture", "FI_deathI", window)   
    window.deathicon:SetPoint("TOPLEFT", window.death1, "TOPRIGHT", 15, 15)
    window.deathicon:SetTexture("FragInspector", "UI/attribute_death.png")
    
    window.earthicon = UI.CreateFrame("Texture", "FI_earthI", window)   
    window.earthicon:SetPoint("TOPLEFT", window.earth1, "TOPRIGHT", 15, 15)
    window.earthicon:SetTexture("FragInspector", "UI/attribute_earth.png")    
    
    window.fireicon = UI.CreateFrame("Texture", "FI_fireI", window)   
    window.fireicon:SetPoint("TOPLEFT", window.fire1, "TOPRIGHT", 15, 15)
    window.fireicon:SetTexture("FragInspector", "UI/attribute_fire.png")    

    window.lifeicon = UI.CreateFrame("Texture", "FI_lifeI", window)   
    window.lifeicon:SetPoint("TOPLEFT", window.life1, "TOPRIGHT", 15, 15)
    window.lifeicon:SetTexture("FragInspector", "UI/attribute_life.png")    
    
    window.watericon = UI.CreateFrame("Texture", "FI_waterI", window)   
    window.watericon:SetPoint("TOPLEFT", window.water1, "TOPRIGHT", 15, 15)
    window.watericon:SetTexture("FragInspector", "UI/attribute_water.png")    

        
    
    
    
    ------ Testing-----------
    -------------------------
    window.testButton = UI.CreateFrame("RiftButton", "testButton", window)
    window.testButton:SetText("TEST")
    window.testButton:SetPoint("BOTTOMLEFT", window, "BOTTOMLEFT", 50,-50)
    
    function window.testButton.Event:LeftPress()
        

        
--        local tempFrag = Inspect.Item.Detail("seqp.f01")
--        local tempFStr =  FragInspector.CondenseStats(tempFrag)
--        tempFrag = Inspect.Item.Detail("seqp.f02")
--        tempFStr = tempFStr .. "@" .. FragInspector.CondenseStats(tempFrag)
--        print(tempFStr)
--        tempRes = FragInspector.ExpandStats(tempFStr)
--        
--         
--        window.earth1:ProcessTable(tempRes[1])
--        window.fire1:ProcessTable(tempRes[2])
        
        FragInspector.GetUsers()
    
    end
    
    -------------------------
    -------------------------

end


init()


local function showWindow()
    
    local tempFrag = Inspect.Item.Detail("seqp.f01")
    if tempFrag then
    
    end
    
    
    window:SetVisible(true)

end


table.insert(Command.Slash.Register("fi"), {showWindow, "FragInspector", "Slash command"})