local addon, FragInspector = ...

local Userlist = {}

--- mainStat    3 chars                     1
--- affinity    1   (element)               4
--- level       2                           5
--- rarity      1                           7
--- each stat   '#' +3 + (up to)4           8
--- separator   "@"

 
-- takes a fragment table from inspect.item.detail
function FragInspector.CondenseStats(frag)
    
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
        powerAttack = "Agg",
        powerSpell = "Cal",
        dodge = "Elu",
        intelligence = "Enl",
        guard = "Imp",
        strength = "Mig",
        dexterity = "Nim",
        critSpell = "Pre",
        critPower = "Pun",
        wisdom = "Sag",
        endurance = "Sta",
        block = "Una",
        critAttack = "Une",
        maxHealth = "Vit",
    }
    
    
    local fragStr = string.sub(frag.name, 1,3)  -- get first 3 letters of name (leads to main stat)
    
    fragStr = fragStr .. frag.fragmentAffinity
    
    if frag.infusionLevel > 9 then
        fragStr = fragStr .. frag.infusionLevel 
    else
        fragStr = fragStr .. "0" .. frag.infusionLevel  -- leading 0
    end
    
    if frag.rarity then
        fragStr = fragStr .. Utilities.Rarity[frag.rarity] or "2"
    else
        fragStr = fragStr .. "2"
    end
    
    for k,v in pairs(frag.stats) do
        fragStr = fragStr .. "#" .. titles[k] .. v 
        
    end
    
    return fragStr
    
end



function FragInspector.ExpandStats(fragStr)
   
    local fragResult = {}
    
    local titles = {
        Agg = "powerAttack",
        Cal = "powerSpell",
        Elu = "dodge",
        Enl = "intelligence",
        Imp = "guard",
        Mig = "strength",
        Nim = "dexterity",
        Pre = "critSpell",
        Pun = "critPower",
        Sag = "wisdom",
        Sta = "endurance",
        Una = "block",
        Une = "critAttack",
        Vit = "maxHealth",
        }
    
    local elements = {
        [1] = false,
        [2] = false,
        [3] = false,
        [5] = false,
        [6] = false,
        [7] = false
    }
    
   
    local fragmentAffinity = {
        [1] = "Earth",
        [2] = "Air",
        [3] = "Fire",
    
        [5] = "Water",
        [6] = "Life",   
        [7] = "Death"
    }
    
    
    
    local fragArray = string.split(fragStr, "@")
    local fragTable = {}
    
    
    
    for i =1, #fragArray do
        
        if string.len(fragArray[i]) < 11  then break end
        
        fragResult[i] = {}
        
        fragTable = string.split(fragArray[i], "#")
        
        fragResult[i].mainStat = titles[string.sub(fragTable[1], 1, 3)]   
        fragResult[i].fragmentAffinity = string.sub(fragTable[1], 4, 4)
        fragResult[i].infusionLevel = tonumber(string.sub(fragTable[1], 5, 6)) or 0
        fragResult[i].rarity = string.sub(fragTable[1], 7, 7)

        fragResult[i].stats = {}
        for j = 2, #fragTable do
            fragResult[i].stats[titles[string.sub(fragTable[j], 1, 3)]] = string.sub(fragTable[j], 4, -1)      
        end
        
--        print("ms=" .. fragResult[i].mainStat .. ",  fA=" ..  fragResult[i].fragmentAffinity .. ", iL=" .. fragResult[i].infusionLevel ..  ", r=" .. fragResult[i].rarity)
--        
--        for k,v in pairs(fragResult[i].stats) do
--            print(k .. "= " .. v)    
--        end
        

        
        
    end
    
    return fragResult
    
end


function FragInspector.GetUsers()
	local message = "Discovering"
	
	Command.Message.Broadcast("guild", nil, "FragInspector", message, function(failure, message) end)
	Command.Message.Broadcast("yell", nil, "FragInspector", message, function(failure, message) end)
end

function FragInspector.AddUser(user)
    if Userlist[user] then return end
    
    Userlist[user] = true
    RefreshUserList()

    print("found user: ".. user)
end

function RefreshUserList()
    
    
end


function FragInspector.MessageHandler(handle, from, type, channel, identifier, data)

    if identifier ~= "FragInspector" then return end
	if from == Inspect.Unit.Detail("player").name then return end
    
    if data == "Discovering" then
        Command.Message.Send(from, "FragInspector", "Available", function(failure, message) end)
    elseif data == "Available" then
        FragInspector.AddUser(from)
    
    end
    
end


Command.Event.Attach(Event.Message.Receive, FragInspector.MessageHandler, "FI_MessageHandler")

Command.Message.Accept(nil, "FragInspector")

