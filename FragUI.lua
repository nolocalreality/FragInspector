local addon, FragInspector = ...

if not Library then Library = {} end
if not Library.LibFragUI then Library.LibFragUI = {} end


local icon = {
    air = [[Data\UI\item_icons\fatestone_09_grey.dds]],
    death = [[Data\UI\item_icons\fatestone_09_purple.dds]],
    earth = [[Data\UI\item_icons\fatestone_09_peach.dds]],
    fire = [[Data\UI\item_icons\fatestone_08_red.dds]],
    life = [[Data\UI\item_icons\fatestone_09_green.dds]],
    water = [[Data\UI\item_icons\fatestone_09_blue.dds]],
}

local rarityIcon = {
    [2] = "UI/icon_border.png",
    [3] = "UI/icon_border_uncommon.dds",
    [4] = "UI/icon_border_rare.dds",
    [5] = "UI/icon_border_epic.dds",
    [6] = "UI/icon_border_relic.dds",  
}

local titles = {
    Aggressive = "powerAttack",
    Calculating = "powerSpell",
    Elusive = "dodge",
    Enlightened = "intelligence",
    Impenetrable = "guard",
    Mighty = "strength",
    Nimble = "dexterity",
    Precise = "critSpell",
    Punishing = "critPower",
    Sagacious = "wisdom",
    Stalwart = "endurance",
    Unassailable = "block",
    Unerring = "critAttack",
    Vital = "maxHealth",
}

local tt_context = UI.CreateContext("FragUI_ToolTip")
tt_context:SetStrata("topmost")
local toolTip = UI.CreateFrame("ExtendedTooltip", "FragUI_Tooltip", tt_context)

toolTip:SetFontSize(14)


function Library.LibFragUI.Create(name, parent, element)

    local FragUI = UI.CreateFrame("Frame", name, parent)
    FragUI.RarityFrame = UI.CreateFrame("Texture", name .. "RarityFrame", FragUI)
    FragUI.Item = UI.CreateFrame("Texture", name .. "Item", FragUI)
    FragUI.Highlight = UI.CreateFrame("Texture", name .. "Highlight", FragUI)
    FragUI:SetHeight(48)
    FragUI:SetWidth(48)
    
    FragUI.Item:SetAllPoints(FragUI)
    FragUI.Highlight:SetPoint("TOPLEFT", FragUI, "TOPLEFT", -8 ,-8)
    FragUI.RarityFrame:SetPoint("TOPLEFT", FragUI, "TOPLEFT", -8 ,-8)
    FragUI.RarityFrame:SetHeight(64)
    
    FragUI.Highlight:SetLayer(FragUI:GetLayer() + 3)
    FragUI.RarityFrame:SetLayer(FragUI:GetLayer() + 2)
    FragUI.Item:SetLayer(FragUI:GetLayer() +1)
    
    FragUI.Highlight:SetTexture("FragInspector", "UI/icon_border_(over)_fill.png")
    FragUI.Highlight:SetVisible(false)
    
    FragUI.element = element
    if icon[element] then
        FragUI.Item:SetTexture("Rift", icon[element])
    end

    FragUI.mainStat = "unknown"
    FragUI.level = 0
    FragUI.rarity = 2
    
    FragUI.stats = {
        dexterity = 0,
        intelligence = 0,
        strength = 0,
        wisdom = 0,
        critAttack = 0,
        critSpell = 0,
        critPower = 0,
        powerAttack = 0,
        powerSpell = 0,
        endurance = 0,
        maxHealth = 0,
        block = 0,
        dodge = 0,
        guard = 0,       
    }
    
    function FragUI.SetStats(self, statTable)
       for k in pairs(FragUI.stats) do
            if statTable[k] then 
                FragUI.stats[k] = statTable[k]
            else
                FragUI.stats[k] = 0
            end        
        end
        
    end
    
    
    function FragUI.SetMainStat(self, mainStat)
        FragUI.mainStat = mainStat    
    end
    
    function FragUI.SetLevel(self, level)
        FragUI.level = level    
    end
    
    
    function FragUI.SetRarity(self, rare)
        rare = tonumber(rare)
        if rarityIcon[rare] then 
            self.RarityFrame:SetTexture("FragInspector", rarityIcon[rare])
            self.RarityFrame:SetVisible(true)
        else
            self.RarityFrame:SetVisible(false)
        end  
        self.rarity = rare
    end
    
    function FragUI.ProcessTable(self, fragTable)
        
        local fragName
        
        if fragTable.name then
            fragName = string.split(fragTable.name)
            FragUI:SetMainStat(titles[fragName[1]]) 
        end
        
        if fragTable.mainStat then
            FragUI:SetMainStat(fragTable.mainStat)    
            
        end
        
        FragUI:SetLevel(fragTable.infusionLevel)
    
        FragUI:SetStats(fragTable.stats)
        
        FragUI:SetRarity(fragTable.rarity or 2)
        
    end
    
    
    function FragUI.SetToolTipText(self)
        local tempText = ""
        local mainStatText = ""
        local statText = ""
        
        if self.stats[self.mainStat] then
           mainStatText = Utilities:prettyStatName(self.mainStat) .. " +" ..  self.stats[self.mainStat]
        

            for k,v in pairs(self.stats) do
               if k ~= self.mainStat and v ~= 0 then
                    if statText ~= "" then  --not the first entry
                        statText = statText .. "\n"
                    end
                    statText = statText .. Utilities:prettyStatName(k) .. " +" .. v
                end

            end


            tempText = Utilities:colorByRarity("Level " .. self.level, self.rarity) .. "\n" 
            tempText = tempText .. Utilities:colorByRarity(mainStatText, self.rarity) .. "\n"
            tempText = tempText .. statText
        else 
            tempText = "No fragment equipped"
        end
        
        return tempText
    end 
    
    function FragUI.MouseIn(self)
        self.Highlight:SetVisible(true)
        toolTip:Show(self.Highlight, self:SetToolTipText(), "BOTTOMCENTER", 0,0)
    end

    function FragUI.MouseOut(self)
        self.Highlight:SetVisible(false)
        toolTip:Hide(self.Highlight)
    end
    
    function FragUI.Reset(self)
        for k,v in pairs(FragUI.stats) do
            v = 0
        end
    
        FragUI:SetMainStat("unknown")
        FragUI:SetRarity(2)
        FragUI:SetLevel(0)
    
    end

    FragUI:EventAttach(Event.UI.Input.Mouse.Cursor.In, function(self, h) FragUI.MouseIn(self) end, "FragUIMouseIn")
    FragUI:EventAttach(Event.UI.Input.Mouse.Cursor.Out, function(self, h) FragUI.MouseOut(self) end, "FragUIMouseOut")
    
    return FragUI
    
end





