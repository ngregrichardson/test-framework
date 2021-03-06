local json = include("json")
local H = {}

-- TESTING HELPERS

function H.IncludesMultipleTests(tests)
    for _, test in pairs(tests) do
        if not test.name then
            return false
        end
    end

    return true
end

function H.ExtractTruePlayerIndex(player)
    if player then
        for i = 0, Game():GetNumPlayers() - 1 do
            local p = Isaac.GetPlayer(i)
            if player.InitSeed == p.InitSeed then
                return i
            end
        end
    end
end

-- GENERIC HELPERS

function H.DeepCopyTable(original)
	local copy = {}
	for k, v in pairs(original) do
		if type(v) == "table" then
			v = H.DeepCopyTable(v)
		end
		copy[k] = v
	end
	return copy
end

function H.ParsePercentage(s)
    local matched = s:match("(.*)%%")
    matched = matched:gsub("%s+", "")
    if tonumber(matched) then
        return (tonumber(matched) / 100)
    end
end

function H.FindTableEntryIndexByPropertyStartsWith(t, props)
    for i = 1, #t do
        local foundAll = true
	    for key, value in pairs(props) do
	        local val = string.format("%s", t[i][key])
	        
	        if not val:match('^'..value) then
	            foundAll = false
                break
            end
        end

        if foundAll then
            return i
        end
    end
end

function H.FindTableEntryByProperty(t, props)
    local found
	for _, item in pairs(t) do
	    local foundAll = true
	    for key, value in pairs(props) do
            if item[key] ~= value then
                foundAll = false
                break
            end
        end

        if foundAll then
            found = item
            break
        end
    end

    return found
end

function H.RemoveElementFromTable(t, element)
    local indexOf

    for i, v in ipairs(t) do
        if v == element then
            indexOf = i
        end
    end

    if indexOf then
        table.remove(t, indexOf)
    end
end

function H.GetValue(val, arguments, default)
    if not val then
        return default
    end

    if type(val) == "function" then
        return val(arguments)
    else
        return val
    end
end

function H.GetPlayerIndex(arguments)
    return H.GetValue(arguments.playerIndex, arguments, PlayerType.PLAYER_ISAAC)
end

function H.GetPlayer(arguments)
    return Isaac.GetPlayer(H.GetPlayerIndex(arguments))
end

function H.SetNestedValue(t, key, value)
    if t and type(t) == "table" then
        if key:find("%.") then
            local levelKey, nextLevelKey = key:match('([^.]+)%.(.*)')
            if t[levelKey] == nil and nextLevelKey then
                t[levelKey] = {}
            end
            return H.SetNestedValue(t[levelKey], nextLevelKey, value)
        else
            t[key] = value
        end
    end
end

function H.SaveKey(key, value)
    local savedData = {}
    if TestFramework:HasData() then
        savedData = json.decode(TestFramework:LoadData())
    end
    H.SetNestedValue(savedData, key, value)
    TestFramework:SaveData(json.encode(savedData))
end

function H.IsPaused()
    return Game():IsPaused() or (ModConfigMenu and ModConfigMenu.IsVisible)
end

return H