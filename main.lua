TestingMod = RegisterMod("Testing Framework", 1)
local font = Font()
font:Load("font/terminus.fnt")

function table.deepCopy(original)
	local copy = {}
	for k, v in pairs(original) do
		if type(v) == "table" then
			v = table.deepCopy(v)
		end
		copy[k] = v
	end
	return copy
end

function table.isArray(t)
    local i = 0
    for _ in pairs(t) do
        i = i + 1
        if t[i] == nil then return false end
    end
    return true
end

function string.toPercentage(s)
    local matched = s:match("(.*)%%")
    matched = matched:gsub("%s+", "")
    if tonumber(matched) then
        return (tonumber(matched) / 100)
    end
end

local function FindEntryByProperties(t, props)
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

local function RemoveElement(t, element)
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

local registeredTests = {}

Test = {}

TestActions = {
    MOVE_RIGHT = "moveRight",
    MOVE_LEFT = "moveLeft",
    MOVE_UP = "moveUp",
    MOVE_DOWN = "moveDown",
    SHOOT_RIGHT = "shootRight",
    SHOOT_LEFT = "shootLeft",
    SHOOT_UP = "shootUp",
    SHOOT_DOWN = "shootDown",
    USE_CARD = "useCard",
    USE_PILL = "usePill",
    USE_BOMB = "useBomb",
    USE_ITEM = "useItem",
    DROP_POCKET_ITEM = "dropPocketItem",
    DROP_TRINKET = "dropTrinket",
    RUN_COMMAND = "runCommand",
    GIVE_CARD = "giveCard",
    GIVE_ITEM = "giveItem",
    GIVE_PILL = "givePill",
    GIVE_TRINKET = "giveTrinket",
    WAIT_FOR_KEY = "waitForKey",
    ENABLE_DEBUG_FLAG = "enableDebugFlag",
    DISABLE_DEBUG_FLAG = "disableDebugFlag",
    EXECUTE_LUA = "executeLua",
    RESTART = "restart",
    SPAWN = "spawn",
    WAIT_FOR_SECONDS = "waitForSeconds",
    WAIT_FOR_FRAMES = "waitForFrames",
    REPEAT = "repeat",
    SWAP_PILL_CARDS = "swapPillCards",
    SWAP_ACTIVE_ITEMS = "swapActiveItems",
    SWAP_SUB_PLAYERS = "swapSubPlayers",
    SWAP = "swap",
    TELEPORT_TO_POSITION = "teleportToPosition"
}

local function IncludesMultipleTests(tests)
    for _, test in pairs(tests) do
        if not test.name then
            return false
        end
    end

    return true
end

function Test.RegisterTest(name, tests)
    registeredTests[name] = tests

    return tests
end

function Test.RegisterTests(name, tests, awaitStep)
    local finalSteps = {}

    for index, test in pairs(tests) do
        local results

        if IncludesMultipleTests(test.steps) then
            results = Test.RegisterTests(test.name, test.steps, awaitStep)
        else
            results = Test.RegisterTest(test.name, test.steps)
        end

        if results then
            for _, newStep in pairs(results) do
                table.insert(finalSteps, newStep)
            end
        end

        if index < #tests then
            table.insert(finalSteps, awaitStep or { action = TestActions.WAIT_FOR_KEY, arguments = { key = Keyboard.KEY_ENTER } })
        end
    end

    Test.RegisterTest(name, finalSteps)

    return finalSteps
end

local initialDelayConfig = {
    frames = 0,
    next = nil
}

local shouldActions = {}

local delayConfig = table.deepCopy(initialDelayConfig)

local GetAsyncOrDelay = function(arguments, value)
    if arguments.async then
        return 0
    else
        return value
    end
end

-- INSTRUCTIONS

local stop = function()
    shouldActions = {}
    delayConfig = table.deepCopy(initialDelayConfig)
end

local delay = function(value, callback, inFrames)
    if inFrames then
        delayConfig.frames = value or 0
    else
        delayConfig.frames = (value or 0) * 30
    end
    if callback then
        delayConfig.next = callback
    else
        delayConfig.next = stop
    end
end

local waitForSeconds = function(arguments, next)
    delay(arguments.seconds, next)
end

local waitForFrames = function(arguments, next)
    delay(arguments.frames, next, true)
end

local moveLeft = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.MOVE_LEFT,
        speed = arguments.speed or 1,
        frames = arguments.seconds * 30,
        playerIndex = arguments.playerIndex or 0
    })
    delay(GetAsyncOrDelay(arguments, arguments.seconds), next)
end

local moveRight = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.MOVE_RIGHT,
        speed = arguments.speed or 1,
        frames = arguments.seconds * 30,
        playerIndex = arguments.playerIndex or 0
    })
    delay(GetAsyncOrDelay(arguments, arguments.seconds), next)
end

local moveUp = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.MOVE_UP,
        speed = arguments.speed or 1,
        frames = arguments.seconds * 30,
        playerIndex = arguments.playerIndex or 0
    })
    delay(GetAsyncOrDelay(arguments, arguments.seconds), next)
end

local moveDown = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.MOVE_DOWN,
        speed = arguments.speed or 1,
        frames = arguments.seconds * 30,
        playerIndex = arguments.playerIndex or 0
    })
    delay(GetAsyncOrDelay(arguments, arguments.seconds), next)
end

local shootLeft = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.SHOOT_LEFT,
        frames = arguments.seconds * 30,
        playerIndex = arguments.playerIndex or 0
    })
    delay(GetAsyncOrDelay(arguments, arguments.seconds), next)
end

local shootRight = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.SHOOT_RIGHT,
        frames = arguments.seconds * 30,
        playerIndex = arguments.playerIndex or 0
    })
    delay(GetAsyncOrDelay(arguments, arguments.seconds), next)
end

local shootUp = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.SHOOT_UP,
        frames = arguments.seconds * 30,
        playerIndex = arguments.playerIndex or 0
    })
    delay(GetAsyncOrDelay(arguments, arguments.seconds), next)
end

local shootDown = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.SHOOT_DOWN,
        frames = arguments.seconds * 30,
        playerIndex = arguments.playerIndex or 0
    })
    delay(GetAsyncOrDelay(arguments, arguments.seconds), next)
end

local runCommand = function(arguments, next)
    local result = Isaac.ExecuteCommand(arguments.command)
    delay(0, next)
    return result
end

local giveCard = function(arguments, next)
    local player = Isaac.GetPlayer(arguments.playerIndex or 0)

    player:AddCard(arguments.id)
    delay(0, next)
end

local givePill = function(arguments, next)
    local player = Isaac.GetPlayer(arguments.playerIndex or 0)

    player:AddPill(arguments.color)
    delay(0, next)
end

local giveItem = function(arguments, next)
    local player = Isaac.GetPlayer(arguments.playerIndex or 0)

    player:AddCollectible(arguments.id)
    delay(0, next)
end

local giveTrinket = function(arguments, next)
    local player = Isaac.GetPlayer(arguments.playerIndex or 0)

    player:AddTrinket(arguments.id)
    delay(0, next)
end

local useCard = function(arguments, next)
    local player = Isaac.GetPlayer(arguments.playerIndex or 0)

    local cardId

    if arguments.id then
        cardId = arguments.id
    else
        local card = player:GetCard(arguments.slot or 0)
        if card ~= 0 then
            cardId = card
        end
    end

    if cardId then
        player:UseCard(cardId)

        for i = (arguments.slot or 0), 3 do
            player:SetCard(i, player:GetCard(i + 1))
        end

        delay(GetAsyncOrDelay(arguments, 13), next, true)
    else
        delay(0, next)
    end
end

local usePill = function(arguments, next)
    local player = Isaac.GetPlayer(arguments.playerIndex or 0)

    local pillId
    local pillColor

    if arguments.id then
        pillId = arguments.id
        pillColor = arguments.color or 0
    else
        local pill = player:GetPill(arguments.slot or 0)
        if pill ~= 0 then
            pillColor = pill
            pillId = Game():GetItemPool():GetPillEffect(pillColor, player)
        end
    end

    if pillId then
        player:UsePill(pillId, pillColor or 0)

        for i = (arguments.slot or 0), 3 do
            player:SetPill(i, player:GetPill(i + 1))
        end

        delay(GetAsyncOrDelay(arguments, 13), next, true)
    else
        delay(0, next)
    end
end

local useBomb = function(arguments, next)
    local player = Isaac.GetPlayer(arguments.playerIndex or 0)

    if arguments.force or player:GetNumBombs() > 0 then
        player:FireBomb(player.Position, Vector.Zero, player)
        player:AddBombs(-1)
    end

    delay(GetAsyncOrDelay(arguments, 60), next, true)
end

local useItem = function(arguments, next)
    local player = Isaac.GetPlayer(arguments.playerIndex or 0)

    local itemId
    local itemSlot

    if arguments.id then
        itemId = arguments.id
    else
        local item = player:GetActiveItem(arguments.slot or 0)
        if item ~= 0 then
            itemId = item
            itemSlot = arguments.slot or 0
        end
    end

    if itemId and (arguments.force or not itemSlot or not player:NeedsCharge(itemSlot)) then
        player:UseActiveItem(itemId, 0, itemSlot or -1)
        
        if itemSlot then
            player:DischargeActiveItem(itemSlot)
        end

        delay(GetAsyncOrDelay(arguments, 18), next, true)
    else
        delay(0, next)
    end
end

local dropPocketItem = function(arguments, next)
    local player = Isaac.GetPlayer(arguments.playerIndex or 0)

    player:DropPocketItem(arguments.slot or 0, player.Position)
    delay(0, next)
end

local dropTrinket = function(arguments, next)
    local player = Isaac.GetPlayer(arguments.playerIndex or 0)

    player:DropTrinket(player.Position)
    delay(0, next)
end

local waitForKey = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.WAIT_FOR_KEY,
        key = arguments.key or Keyboard.KEY_ENTER
    })
    delay(0, next)
end

local toggleDebugFlag = function(debugFlag)
    return Isaac.ExecuteCommand("debug "..debugFlag)
end

local isDebugFlagEnabled = function(debugFlag)
    local result = toggleDebugFlag(debugFlag)
    local isEnabled = result:lower():find("disabled")

    toggleDebugFlag(debugFlag)
    return isEnabled
end

local enableDebugFlag = function(arguments, next)
    if not isDebugFlagEnabled(arguments.flag) then
        toggleDebugFlag(arguments.flag)
    end
    delay(0, next)
end

local disableDebugFlag = function(arguments, next)
    if isDebugFlagEnabled(arguments.flag) then
        toggleDebugFlag(arguments.flag)
    end
    delay(0, next)
end

local executeLua = function(arguments, next)
    if arguments.code then
        arguments.command = "lua "..arguments.code
        local result = runCommand(arguments, next)
        if result and result ~= "" then
            print(result)
        end
    end
end

local restart = function(arguments, next)
    if arguments.id then
        arguments.command = "restart "..arguments.id
    else
        arguments.command = "restart"
    end

    if not arguments.seed then
        runCommand(arguments, next)
    else
        runCommand({ command = arguments.command }, function()
            runCommand({ command = "seed "..arguments.seed }, next)
        end)
    end
end

local spawn = function(arguments, next)
    Isaac.Spawn(arguments.type, arguments.variant or 0, arguments.subType or 0, arguments.position or Game():GetRoom():GetCenterPos(), arguments.velocity or Vector.Zero, arguments.spawner)

    delay(0, next)
end

local repeatStep = function(arguments, next)
    delay(0, next)
end

local swapPillCards = function(arguments, next)
    local player = Isaac.GetPlayer(arguments.playerIndex or 0)

    local cards = {}

    for i = 0, 3 do
        local card = player:GetCard(i)

        if card and card ~= 0 then
            table.insert(cards, card)
        end
    end

    for slot, card in pairs(cards) do
        local newSlot = slot + 1

        if newSlot > #cards then
            newSlot = 1
        end

        player:SetCard(newSlot - 1, card)
    end

    delay(0, next)
end

local swapActiveItems = function(arguments, next)
    local player = Isaac.GetPlayer(arguments.playerIndex or 0)

    player:SwapActiveItems()

    delay(0, next)
end

local swap = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.SWAP,
        playerIndex = arguments.playerIndex or 0
    })
    delay(0, next)
end

local swapSubPlayers = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.SWAP_SUB_PLAYERS,
        playerIndex = arguments.playerIndex or 0
    })
    delay(0, next)
end

local teleportToPosition = function(arguments, next)
    local player = Isaac.GetPlayer(arguments.playerIndex or 0)

    local bottomRight = Game():GetRoom():GetBottomRightPos()

    local position = Vector.Zero

    if type(arguments.x) == "number" then
        position.X = arguments.x
    elseif type(arguments.x) == "string" then
        local percentage = arguments.x:toPercentage()

        if percentage then
            position.X = bottomRight.X * percentage
        end
    end

    if type(arguments.y) == "number" then
        position.Y = arguments.y
    elseif type(arguments.y) == "string" then
        local percentage = arguments.y:toPercentage()

        if percentage then
            position.Y = bottomRight.Y * percentage
        end
    end

    player.Position = Game():GetRoom():GetClampedPosition(position, 0)

    delay(0, next)
end

local TestSteps = {
    [TestActions.MOVE_LEFT] = moveLeft,
    [TestActions.MOVE_UP] = moveUp,
    [TestActions.MOVE_RIGHT] = moveRight,
    [TestActions.MOVE_DOWN] = moveDown,
    [TestActions.SHOOT_LEFT] = shootLeft,
    [TestActions.SHOOT_UP] = shootUp,
    [TestActions.SHOOT_RIGHT] = shootRight,
    [TestActions.SHOOT_DOWN] = shootDown,
    [TestActions.USE_ITEM] = useItem,
    [TestActions.USE_CARD] = useCard,
    [TestActions.USE_PILL] = usePill,
    [TestActions.USE_BOMB] = useBomb,
    [TestActions.DROP_POCKET_ITEM] = dropPocketItem,
    [TestActions.DROP_TRINKET] = dropTrinket,
    [TestActions.RUN_COMMAND] = runCommand,
    [TestActions.GIVE_CARD] = giveCard,
    [TestActions.GIVE_ITEM] = giveItem,
    [TestActions.GIVE_PILL] = givePill,
    [TestActions.GIVE_TRINKET] = giveTrinket,
    [TestActions.WAIT_FOR_KEY] = waitForKey,
    [TestActions.ENABLE_DEBUG_FLAG] = enableDebugFlag,
    [TestActions.DISABLE_DEBUG_FLAG] = disableDebugFlag,
    [TestActions.EXECUTE_LUA] = executeLua,
    [TestActions.RESTART] = restart,
    [TestActions.SPAWN] = spawn,
    [TestActions.WAIT_FOR_SECONDS] = waitForSeconds,
    [TestActions.WAIT_FOR_FRAMES] = waitForFrames,
    [TestActions.REPEAT] = repeatStep,
    [TestActions.SWAP_PILL_CARDS] = swapPillCards,
    [TestActions.SWAP_ACTIVE_ITEMS] = swapActiveItems,
    [TestActions.SWAP] = swap,
    [TestActions.SWAP_SUB_PLAYERS] = swapSubPlayers,
    [TestActions.TELEPORT_TO_POSITION] = teleportToPosition
}

-- INSTRUCTIONS END

local function createRunChain(steps, next)
    local nextStep = next
    for i = #steps, 1, -1 do
        local step = steps[i]
        local tempNextStep = nextStep
        if not step.action or not TestSteps[step.action] then
            print("Error: Step "..i.." does not have a valid action property, tests have failed.")
            return
        end

        if step.action == TestActions.REPEAT then
            local repeatSteps = {}

            for j = 1, step.arguments.times do
                for _, repeatedStep in pairs(step.arguments.steps) do
                    table.insert(repeatSteps, repeatedStep)
                end
            end
            nextStep = createRunChain(repeatSteps)

            goto continue
        end

        if i == #steps then
            step.arguments.async = nil
        end

        nextStep = function()
            TestSteps[step.action](step.arguments, tempNextStep)
        end

        ::continue::
    end

    return nextStep
end

local function run(steps)
    local nextStep = createRunChain(steps)

    nextStep()
end

local function GetTruePlayerIndex(player)
    if player then
        for i = 0, Game():GetNumPlayers() - 1 do
            local p = Isaac.GetPlayer(i)
            if player.InitSeed == p.InitSeed then
                return i
            end
        end
    end
end

local function GetTestFromAction(action, player)
    local truePlayerIndex = GetTruePlayerIndex(player)

    return FindEntryByProperties(shouldActions, { action = action, playerIndex = truePlayerIndex })
end

TestingMod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
    local position = Vector(Isaac.GetScreenWidth() / 4, Isaac.GetScreenHeight() - 20)
    local color = KColor(1, 1, 1, 1)
    local boxSize = Isaac.GetScreenWidth() / 2
    local waitForKeyTest = GetTestFromAction(TestActions.WAIT_FOR_KEY)

    if waitForKeyTest then
        local keyName
        for key, value in pairs(Keyboard) do
            if value == waitForKeyTest.key then
                keyName = key
                break
            end
        end
        font:DrawString("Hit "..(keyName or "the specified key").." to continue the tests...", position.X, position.Y, color, boxSize, true)
        position = position - Vector(0, 15)
    end
end)

TestingMod:AddCallback(ModCallbacks.MC_INPUT_ACTION, function(_, entity, inputHook, buttonAction)
    if entity ~= nil and entity:ToPlayer() then
        local player = entity:ToPlayer()

        if inputHook == InputHook.GET_ACTION_VALUE then
            -- Moving left
            if buttonAction == ButtonAction.ACTION_LEFT then
                local test = GetTestFromAction(TestActions.MOVE_LEFT, player)

                if test then
                    return test.speed
                end
            end

            -- Moving right
            if buttonAction == ButtonAction.ACTION_RIGHT then
                local test = GetTestFromAction(TestActions.MOVE_RIGHT, player)

                if test then
                    return test.speed
                end
            end

            -- Moving up
            if buttonAction == ButtonAction.ACTION_UP then
                local test = GetTestFromAction(TestActions.MOVE_UP, player)

                if test then
                    return test.speed
                end
            end

            -- Moving down
            if buttonAction == ButtonAction.ACTION_DOWN then
                local test = GetTestFromAction(TestActions.MOVE_DOWN, player)

                if test then
                    return test.speed
                end
            end

            -- Shooting left
            if buttonAction == ButtonAction.ACTION_SHOOTLEFT then
                local test = GetTestFromAction(TestActions.SHOOT_LEFT, player)

                if test then
                    return 1
                end
            end

            -- Shooting right
            if buttonAction == ButtonAction.ACTION_SHOOTRIGHT then
                local test = GetTestFromAction(TestActions.SHOOT_RIGHT, player)

                if test then
                    return 1
                end
            end

            -- Shooting up
            if buttonAction == ButtonAction.ACTION_SHOOTUP then
                local test = GetTestFromAction(TestActions.SHOOT_UP, player)

                if test then
                    return 1
                end
            end

            -- Shooting down
            if buttonAction == ButtonAction.ACTION_SHOOTDOWN then
                local test = GetTestFromAction(TestActions.SHOOT_DOWN, player)

                if test then
                    return 1
                end
            end
        end

        if inputHook == InputHook.IS_ACTION_TRIGGERED then
            -- Swap cards/items
            if buttonAction == ButtonAction.ACTION_DROP then
                local test = GetTestFromAction(TestActions.SWAP, player)

                if test then
                    local isForgotten = player.SubType == PlayerType.PLAYER_THEFORGOTTEN or player.SubType == PlayerType.PLAYER_THESOUL
                    if not isForgotten or (isForgotten and test.shouldRemove) then
                        RemoveElement(shouldActions, test)
                    else
                        test.shouldRemove = true
                    end
                    return true
                end
            end

            -- Swap sub players
            if buttonAction == ButtonAction.ACTION_DROP then
                local test = GetTestFromAction(TestActions.SWAP_SUB_PLAYERS, player)

                if test then
                    local isForgotten = player.SubType == PlayerType.PLAYER_THEFORGOTTEN or player.SubType == PlayerType.PLAYER_THESOUL
                    if isForgotten then
                        RemoveElement(shouldActions, test)
                        return true
                    end
                end
            end
        end

        if inputHook == InputHook.IS_ACTION_PRESSED then

            -- Shooting left
            if buttonAction == ButtonAction.ACTION_SHOOTLEFT then
                local test = GetTestFromAction(TestActions.SHOOT_LEFT, player)

                if test then
                    return 1
                end
            end

            -- Shooting right
            if buttonAction == ButtonAction.ACTION_SHOOTRIGHT then
                local test = GetTestFromAction(TestActions.SHOOT_RIGHT, player)

                if test then
                    return 1
                end
            end

            -- Shooting up
            if buttonAction == ButtonAction.ACTION_SHOOTUP then
                local test = GetTestFromAction(TestActions.SHOOT_UP, player)

                if test then
                    return 1
                end
            end

            -- Shooting down
            if buttonAction == ButtonAction.ACTION_SHOOTDOWN then
                local test = GetTestFromAction(TestActions.SHOOT_DOWN, player)

                if test then
                    return 1
                end
            end
        end
    end
end)

TestingMod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()

    -- Decrement frames and remove completed actions
    for i = 1, #shouldActions do
        local test = shouldActions[i]

        if test then
            if test.frames then
                if test.frames - 1 > 0 then
                    test.frames = test.frames - 1
                else
                    table.remove(shouldActions, i)
                    i = i - 1
                end
            end
        end
    end

    delayConfig.frames = math.max(0, delayConfig.frames - 1)

    local waitForKeyTest = FindEntryByProperties(shouldActions, { action = TestActions.WAIT_FOR_KEY })

    if (not waitForKeyTest and delayConfig.frames <= 0) or (waitForKeyTest and Input.IsButtonPressed(waitForKeyTest.key, 0)) then
        RemoveElement(shouldActions, waitForKeyTest)

        if delayConfig.next then
            delayConfig.next()
            if not delayConfig.next then
                stop()
            end
        else
            stop()
        end
    end
end)

TestingMod:AddCallback(ModCallbacks.MC_EXECUTE_CMD, function(_, command, args)
    if command:lower() == "test" then
        if args and registeredTests[args] then
            stop()
            run(registeredTests[args])
        else
            print("Tests not found for '"..args.."'")
        end
    end
end)

Test.RegisterTest("cards", {
    {
        action = TestActions.RESTART,
        arguments = {}
    },
    {
        action = TestActions.GIVE_ITEM,
        arguments = {
            id = 251
        }
    },
    {
        action = TestActions.GIVE_CARD,
        arguments = {
            id = 2
        }
    },
    {
        action = TestActions.GIVE_CARD,
        arguments = {
            id = 3
        }
    },
    {
        action = TestActions.WAIT_FOR_SECONDS,
        arguments = {
            seconds = 1
        }
    },
    {
        action = TestActions.USE_CARD,
        arguments = {
            slot = 0
        }
    },
})

Test.RegisterTest("pills", {
    {
        action = TestActions.RESTART,
        arguments = {}
    },
    {
        action = TestActions.GIVE_PILL,
        arguments = {
            color = 2
        }
    },
    {
        action = TestActions.WAIT_FOR_SECONDS,
        arguments = {
            seconds = 1
        }
    },
    {
        action = TestActions.USE_PILL,
        arguments = {
            slot = 0
        }
    },
})

Test.RegisterTest("cards2", {
    {
        action = TestActions.RESTART,
        arguments = {
            id = 19
        }
    },
    {
        action = TestActions.GIVE_CARD,
        arguments = {
            id = 2
        }
    },
    {
        action = TestActions.GIVE_CARD,
        arguments = {
            id = 3,
            playerIndex = 1
        }
    },
    {
        action = TestActions.WAIT_FOR_SECONDS,
        arguments = {
            seconds = 1
        }
    },
    {
        action = TestActions.USE_CARD,
        arguments = {
            slot = 0,
            playerIndex = 1
        }
    },
    {
        action = TestActions.USE_CARD,
        arguments = {
            slot = 0
        }
    },
})

Test.RegisterTest("items", {
    {
        action = TestActions.RESTART,
        arguments = {}
    },
    {
        action = TestActions.GIVE_ITEM,
        arguments = {
            id = 650
        }
    },
    {
        action = TestActions.ENABLE_DEBUG_FLAG,
        arguments = {
            flag = 8
        }
    },
    {
        action = TestActions.WAIT_FOR_SECONDS,
        arguments = {
            seconds = 1
        }
    },
    {
        action = TestActions.DISABLE_DEBUG_FLAG,
        arguments = {
            flag = 8
        }
    },
    {
        action = TestActions.USE_ITEM,
        arguments = {
            force = true
        }
    },
    {
        action = TestActions.WAIT_FOR_SECONDS,
        arguments = {
            seconds = 1
        }
    },
    {
        action = TestActions.USE_ITEM,
        arguments = {
            id = 126
        }
    },
})

Test.RegisterTest("bombs", {
    {
        action = TestActions.RESTART,
        arguments = {}
    },
    {
        action = TestActions.USE_BOMB,
        arguments = {
            async = true
        }
    },
    {
        action = TestActions.MOVE_UP,
        arguments = {
            seconds = 0.7
        }
    },
    {
        action = TestActions.USE_BOMB,
        arguments = {
            force = true,
            async = true
        }
    },
    {
        action = TestActions.MOVE_DOWN,
        arguments = {
            seconds = 0.7
        }
    },
})

Test.RegisterTest("movement", {
    {
        action = TestActions.RESTART,
        arguments = {}
    },
    {
        action = TestActions.MOVE_LEFT,
        arguments = {
            seconds = 1
        }
    },
    {
        action = TestActions.MOVE_UP,
        arguments = {
            seconds = 1
        }
    },
    {
        action = TestActions.MOVE_RIGHT,
        arguments = {
            seconds = 1,
            async = true
        }
    },
    {
        action = TestActions.MOVE_DOWN,
        arguments = {
            seconds = 1
        }
    }
})

Test.RegisterTest("movement2", {
    {
        action = TestActions.RESTART,
        arguments = {
            id = 19
        }
    },
    {
        action = TestActions.MOVE_LEFT,
        arguments = {
            seconds = 1,
            async = true
        }
    },
    {
        action = TestActions.MOVE_RIGHT,
        arguments = {
            seconds = 1,
            playerIndex = 1
        }
    },
    {
        action = TestActions.MOVE_UP,
        arguments = {
            seconds = 1,
            async = true
        }
    },
        {
        action = TestActions.MOVE_UP,
        arguments = {
            seconds = 1,
            playerIndex = 1
        }
    },
    {
        action = TestActions.MOVE_RIGHT,
        arguments = {
            seconds = 1,
            async = true
        }
    },
    {
        action = TestActions.MOVE_DOWN,
        arguments = {
            seconds = 1,
            async = true
        }
    },
        {
        action = TestActions.MOVE_LEFT,
        arguments = {
            seconds = 1,
            async = true,
            playerIndex = 1
        }
    },
    {
        action = TestActions.MOVE_DOWN,
        arguments = {
            seconds = 1,
            playerIndex = 1,
            async = true
        }
    }
})

Test.RegisterTest("shooting", {
    {
        action = TestActions.RESTART,
        arguments = {}
    },
    {
        action = TestActions.SHOOT_RIGHT,
        arguments = {
            seconds = 1
        }
    },
    {
        action = TestActions.SHOOT_DOWN,
        arguments = {
            seconds = 1
        }
    },
    {
        action = TestActions.SHOOT_LEFT,
        arguments = {
            seconds = 1
        }
    },
    {
        action = TestActions.SHOOT_UP,
        arguments = {
            seconds = 1
        }
    },
})

Test.RegisterTest("key", {
    {
        action = TestActions.WAIT_FOR_KEY,
        arguments = {
            key = Keyboard.KEY_ENTER
        }
    },
    {
        action = TestActions.SHOOT_RIGHT,
        arguments = {
            seconds = 1
        }
    }
})

Test.RegisterTest("seconds", {
    {
        action = TestActions.WAIT_FOR_SECONDS,
        arguments = {
            seconds = 5
        }
    },
    {
        action = TestActions.SHOOT_RIGHT,
        arguments = {
            seconds = 1
        }
    }
})

Test.RegisterTest("swapCards", {
    {
        action = TestActions.RESTART,
        arguments = {
        }
    },
    {
        action = TestActions.GIVE_ITEM,
        arguments = {
            id = 251
        }
    },
    {
        action = TestActions.GIVE_CARD,
        arguments = {
            id = 1
        }
    },
    {
        action = TestActions.GIVE_CARD,
        arguments = {
            id = 2
        }
    },
    {
        action = TestActions.WAIT_FOR_SECONDS,
        arguments = {
            seconds = 1
        }
    },
    {
        action = TestActions.SWAP_PILL_CARDS,
        arguments = {
        }
    }
})

Test.RegisterTest("swapItems", {
    {
        action = TestActions.RESTART,
        arguments = {
        }
    },
    {
        action = TestActions.GIVE_ITEM,
        arguments = {
            id = 534
        }
    },
    {
        action = TestActions.GIVE_ITEM,
        arguments = {
            id = 650
        }
    },
    {
        action = TestActions.GIVE_ITEM,
        arguments = {
            id = 84
        }
    },
    {
        action = TestActions.WAIT_FOR_SECONDS,
        arguments = {
            seconds = 1
        }
    },
    {
        action = TestActions.SWAP_ACTIVE_ITEMS,
        arguments = {
        }
    }
})

Test.RegisterTest("swap", {
    {
        action = TestActions.RESTART,
        arguments = {
        }
    },
    {
        action = TestActions.GIVE_ITEM,
        arguments = {
            id = 534
        }
    },
    {
        action = TestActions.GIVE_ITEM,
        arguments = {
            id = 251
        }
    },
    {
        action = TestActions.GIVE_ITEM,
        arguments = {
            id = 650
        }
    },
    {
        action = TestActions.GIVE_ITEM,
        arguments = {
            id = 84
        }
    },
    {
        action = TestActions.GIVE_CARD,
        arguments = {
            id = 1
        }
    },
    {
        action = TestActions.GIVE_CARD,
        arguments = {
            id = 2
        }
    },
    {
        action = TestActions.WAIT_FOR_SECONDS,
        arguments = {
            seconds = 1
        }
    },
    {
        action = TestActions.SWAP,
        arguments = {
        }
    }
})

Test.RegisterTest("swapSubPlayers", {
    {
        action = TestActions.RESTART,
        arguments = {
            id = 16
        }
    },
    {
        action = TestActions.GIVE_ITEM,
        arguments = {
            id = 534
        }
    },
    {
        action = TestActions.GIVE_ITEM,
        arguments = {
            id = 251
        }
    },
    {
        action = TestActions.GIVE_ITEM,
        arguments = {
            id = 650
        }
    },
    {
        action = TestActions.GIVE_ITEM,
        arguments = {
            id = 84
        }
    },
    {
        action = TestActions.GIVE_CARD,
        arguments = {
            id = 1
        }
    },
    {
        action = TestActions.GIVE_CARD,
        arguments = {
            id = 2
        }
    },
    {
        action = TestActions.WAIT_FOR_SECONDS,
        arguments = {
            seconds = 1
        }
    },
    {
        action = TestActions.SWAP_SUB_PLAYERS,
        arguments = {
        }
    }
})

Test.RegisterTest("drop", {
    {
        action = TestActions.RESTART,
        arguments = {
            id = 0
        }
    },
    {
        action = TestActions.GIVE_CARD,
        arguments = {
            id = 1
        }
    },
    {
        action = TestActions.GIVE_TRINKET,
        arguments = {
            id = 1
        }
    },
    {
        action = TestActions.WAIT_FOR_SECONDS,
        arguments = {
            seconds = 1
        }
    },
    {
        action = TestActions.DROP_POCKET_ITEM,
        arguments = {}
    },
    {
        action = TestActions.WAIT_FOR_SECONDS,
        arguments = {
            seconds = 1
        }
    },
    {
        action = TestActions.GIVE_ITEM,
        arguments = {
            id = 251
        }
    },
    {
        action = TestActions.GIVE_CARD,
        arguments = {
            id = 1
        }
    },
    {
        action = TestActions.GIVE_CARD,
        arguments = {
            id = 2
        }
    },
    {
        action = TestActions.WAIT_FOR_SECONDS,
        arguments = {
            seconds = 1
        }
    },
    {
        action = TestActions.DROP_POCKET_ITEM,
        arguments = {
            slot = 1
        }
    },
    {
        action = TestActions.WAIT_FOR_SECONDS,
        arguments = {
            seconds = 1
        }
    },
    {
        action = TestActions.DROP_TRINKET,
        arguments = {
            slot = 1
        }
    },
    {
        action = TestActions.WAIT_FOR_KEY,
        arguments = {
            key = Keyboard.KEY_ENTER,
        }
    },
    {
        action = TestActions.RESTART,
        arguments = {
            id = 19
        }
    },
    {
        action = TestActions.GIVE_CARD,
        arguments = {
            id = 1,
            playerIndex = 1
        }
    },
    {
        action = TestActions.WAIT_FOR_SECONDS,
        arguments = {
            seconds = 1,
        }
    },
    {
        action = TestActions.DROP_POCKET_ITEM,
        arguments = {
            playerIndex = 1
        }
    }
})

Test.RegisterTest("teleport", {
    {
        action = TestActions.RESTART,
        arguments = {
        }
    },
    {
        action = TestActions.TELEPORT_TO_POSITION,
        arguments = {
            x = "50%",
            y = "50%"
        }
    }
})

Test.RegisterTest("repeat", {
    {
        action = TestActions.REPEAT,
        arguments = {
            times = 5,
            steps = {
                {
                    action = TestActions.USE_CARD,
                    arguments = {
                        id = 3
                    }
                },
                {
                    action = TestActions.WAIT_FOR_KEY,
                    arguments = {
                        key = Keyboard.KEY_ENTER
                    }
                }
            }
        }
    }
})