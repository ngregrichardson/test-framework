TestingMod = RegisterMod("Testing Framework", 1)

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
    USE_PILL_CARD = "usePillCard",
    USE_BOMB = "useBomb",
    USE_ITEM = "useItem",
    DROP_PILL_CARD = "dropPillCard",
    RUN_COMMAND = "runCommand",
    GIVE_CARD = "giveCard",
    GIVE_ITEM = "giveItem",
    WAIT_FOR_KEY = "waitForKey",
    ENABLE_DEBUG_FLAG = "enableDebugFlag",
    DISABLE_DEBUG_FLAG = "disableDebugFlag",
    EXECUTE_LUA = "executeLua",
    RESTART = "restart",
    SPAWN = "spawn"
}

function Test.RegisterTests(name, tests)
    registeredTests[name] = tests
end

local initialDelayConfig = {
    frames = 0,
    next = nil
}

local shouldActions = {}

local delayConfig = table.deepCopy(initialDelayConfig)

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

local moveLeft = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.MOVE_LEFT,
        speed = arguments.speed or 1,
        frames = arguments.seconds * 30,
        playerIndex = arguments.playerIndex or 0
    })
    delay(arguments.seconds, next)
end

local moveRight = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.MOVE_RIGHT,
        speed = arguments.speed or 1,
        frames = arguments.seconds * 30,
        playerIndex = arguments.playerIndex or 0
    })
    delay(arguments.seconds, next)
end

local moveUp = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.MOVE_UP,
        speed = arguments.speed or 1,
        frames = arguments.seconds * 30,
        playerIndex = arguments.playerIndex or 0
    })
    delay(arguments.seconds, next)
end

local moveDown = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.MOVE_DOWN,
        speed = arguments.speed or 1,
        frames = arguments.seconds * 30,
        playerIndex = arguments.playerIndex or 0
    })
    delay(arguments.seconds, next)
end

local shootLeft = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.SHOOT_LEFT,
        frames = arguments.seconds * 30,
        playerIndex = arguments.playerIndex or 0
    })
    delay(arguments.seconds, next)
end

local shootRight = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.SHOOT_RIGHT,
        frames = arguments.seconds * 30,
        playerIndex = arguments.playerIndex or 0
    })
    delay(arguments.seconds, next)
end

local shootUp = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.SHOOT_UP,
        frames = arguments.seconds * 30,
        playerIndex = arguments.playerIndex or 0
    })
    delay(arguments.seconds, next)
end

local shootDown = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.SHOOT_DOWN,
        frames = arguments.seconds * 30,
        playerIndex = arguments.playerIndex or 0
    })
    delay(arguments.seconds, next)
end

local runCommand = function(arguments, next)
    local result = Isaac.ExecuteCommand(arguments.command)
    delay(arguments.delay, next)
    return result
end

local giveCard = function(arguments, next)
    local player = Isaac.GetPlayer(arguments.playerIndex or 0)

    player:AddCard(arguments.id)
    delay(arguments.delay, next)
end

local giveItem = function(arguments, next)
    local player = Isaac.GetPlayer(arguments.playerIndex or 0)

    player:AddCollectible(arguments.id)
    delay(arguments.delay, next)
end

local usePillCard = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.USE_PILL_CARD,
        playerIndex = arguments.playerIndex or 0
    })
    local delayFrames = 0
    if arguments.await then
       delayFrames = 13
    end
    delay(delayFrames, next, true)
end

local useBomb = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.USE_BOMB,
        playerIndex = arguments.playerIndex or 0
    })
    local delayFrames = 0
    if arguments.await then
       delayFrames = 60
    end
    delay(delayFrames, next, true)
end

local useItem = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.USE_ITEM,
        playerIndex = arguments.playerIndex or 0
    })
    local delayFrames = 0
    if arguments.await then
       delayFrames = 18
    end
    delay(delayFrames, next, true)
end

local dropPillCard = function(arguments, next)
    local framesCount = 2.5 * 30
    table.insert(shouldActions, {
        action = TestActions.DROP_PILL_CARD,
        frames = framesCount,
        playerIndex = arguments.playerIndex or 0
    })
    local delayFrames = 0
    if arguments.await then
       delayFrames = framesCount
    end
    delay(delayFrames, next, true)
end

local waitForKey = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.WAIT_FOR_KEY,
        key = arguments.key
    })
    delay(0, next, true)
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
    delay(arguments.delay, next)
end

local disableDebugFlag = function(arguments, next)
    if isDebugFlagEnabled(arguments.flag) then
        toggleDebugFlag(arguments.flag)
    end
    delay(arguments.delay, next)
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
        runCommand({ command = arguments.command, delay = 0 }, function()
            runCommand({ command = "seed "..arguments.seed, delay = arguments.delay }, next)
        end)
    end
end

local spawn = function(arguments, next)
    Isaac.Spawn(arguments.type or 0, arguments.variant or 0, arguments.subType or 0, arguments.position or Game():GetRoom():GetCenterPos(), arguments.velocity or Vector.Zero, arguments.spawner)

    delay(arguments.delay, next)
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
    [TestActions.USE_PILL_CARD] = usePillCard,
    [TestActions.USE_BOMB] = useBomb,
    [TestActions.DROP_PILL_CARD] = dropPillCard,
    [TestActions.RUN_COMMAND] = runCommand,
    [TestActions.GIVE_CARD] = giveCard,
    [TestActions.GIVE_ITEM] = giveItem,
    [TestActions.WAIT_FOR_KEY] = waitForKey,
    [TestActions.ENABLE_DEBUG_FLAG] = enableDebugFlag,
    [TestActions.DISABLE_DEBUG_FLAG] = disableDebugFlag,
    [TestActions.EXECUTE_LUA] = executeLua,
    [TestActions.RESTART] = restart,
    [TestActions.SPAWN] = spawn
}

-- INSTRUCTIONS END

local function run(steps)
    local nextStep = nil
    for i = #steps, 1, -1 do
        local step = steps[i]
        local tempNextStep = nextStep
        if not step.action or not TestSteps[step.action] then
            print("Error: Step "..i.." does not have a valid action property, tests have failed.")
            return
        end
        nextStep = function()
            TestSteps[step.action](step.arguments, tempNextStep)
        end
    end
    nextStep()
end

local function GetTestFromAction(action, player)
    local truePlayerIndex

    if player then
        for i = 0, Game():GetNumPlayers() - 1 do
            local p = Isaac.GetPlayer(i)
            if player.InitSeed == p.InitSeed then
                truePlayerIndex = i
                break
            end
        end
    end

    return FindEntryByProperties(shouldActions, { action = action, playerIndex = truePlayerIndex })
end

TestingMod:AddCallback(ModCallbacks.MC_INPUT_ACTION, function(_, entity, inputHook, buttonAction)
    if entity ~= nil and entity:ToPlayer() then
        local player = entity:ToPlayer()

        -- Moving
        if inputHook == InputHook.GET_ACTION_VALUE then
            if buttonAction == ButtonAction.ACTION_LEFT then
                local test = GetTestFromAction(TestActions.MOVE_LEFT, player)

                if test then
                    return test.speed
                end
            end
            if buttonAction == ButtonAction.ACTION_RIGHT then
                local test = GetTestFromAction(TestActions.MOVE_RIGHT, player)

                if test then
                    return test.speed
                end
            end
            if buttonAction == ButtonAction.ACTION_UP then
                local test = GetTestFromAction(TestActions.MOVE_UP, player)

                if test then
                    return test.speed
                end
            end
            if buttonAction == ButtonAction.ACTION_DOWN then
                local test = GetTestFromAction(TestActions.MOVE_DOWN, player)

                if test then
                    return test.speed
                end
            end

            if buttonAction == ButtonAction.ACTION_SHOOTLEFT then
                local test = GetTestFromAction(TestActions.SHOOT_LEFT, player)

                if test then
                    return 1
                end
            end
            if buttonAction == ButtonAction.ACTION_SHOOTRIGHT then
                local test = GetTestFromAction(TestActions.SHOOT_RIGHT, player)

                if test then
                    return 1
                end
            end
            if buttonAction == ButtonAction.ACTION_SHOOTUP then
                local test = GetTestFromAction(TestActions.SHOOT_UP, player)

                if test then
                    return 1
                end
            end
            if buttonAction == ButtonAction.ACTION_SHOOTDOWN then
                local test = GetTestFromAction(TestActions.SHOOT_DOWN, player)

                if test then
                    return 1
                end
            end
        end

        -- Use pill slot
        if inputHook == InputHook.IS_ACTION_TRIGGERED then
            if buttonAction == ButtonAction.ACTION_PILLCARD then
                local test = GetTestFromAction(TestActions.USE_PILL_CARD, player)

                if test then
                    RemoveElement(shouldActions, test)
                    return true
                end
            end

            if buttonAction == ButtonAction.ACTION_BOMB then
                local test = GetTestFromAction(TestActions.USE_BOMB, player)

                if test then
                    RemoveElement(shouldActions, test)
                    return true
                end
            end

            if buttonAction == ButtonAction.ACTION_ITEM then
                local test = GetTestFromAction(TestActions.USE_ITEM, player)

                if test then
                    RemoveElement(shouldActions, test)
                    return true
                end
            end
        end

        -- Shooting
        if inputHook == InputHook.IS_ACTION_PRESSED then
            if buttonAction == ButtonAction.ACTION_SHOOTLEFT then
                local test = GetTestFromAction(TestActions.SHOOT_LEFT, player)

                if test then
                    return 1
                end
            end
            if buttonAction == ButtonAction.ACTION_SHOOTRIGHT then
                local test = GetTestFromAction(TestActions.SHOOT_RIGHT, player)

                if test then
                    return 1
                end
            end
            if buttonAction == ButtonAction.ACTION_SHOOTUP then
                local test = GetTestFromAction(TestActions.SHOOT_UP, player)

                if test then
                    return 1
                end
            end
            if buttonAction == ButtonAction.ACTION_SHOOTDOWN then
                local test = GetTestFromAction(TestActions.SHOOT_DOWN, player)

                if test then
                    return 1
                end
            end

            if buttonAction == ButtonAction.ACTION_DROP then
                local test = GetTestFromAction(TestActions.DROP_PILL_CARD, player)

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

Test.RegisterTests("cards", {
    {
        action = TestActions.RESTART,
        arguments = {}
    },
    {
        action = TestActions.GIVE_CARD,
        arguments = {
            id = 2,
            delay = 2
        }
    },
    {
        action = TestActions.USE_PILL_CARD,
        arguments = {
            await = true
        }
    },
})

Test.RegisterTests("items", {
    {
        action = TestActions.RESTART,
        arguments = {}
    },
    {
        action = TestActions.GIVE_ITEM,
        arguments = {
            id = 126,
            delay = 2
        }
    },
    {
        action = TestActions.USE_ITEM,
        arguments = {
            await = true
        }
    },
})

Test.RegisterTests("bombs", {
    {
        action = TestActions.RESTART,
        arguments = {}
    },
    {
        action = TestActions.GIVE_ITEM,
        arguments = {
            id = 190
        }
    },
    {
        action = TestActions.USE_BOMB,
        arguments = {}
    },
    {
        action = TestActions.MOVE_UP,
        arguments = {
            seconds = 0.7
        }
    }
})

Test.RegisterTests("movement", {
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
            seconds = 1
        }
    },
    {
        action = TestActions.MOVE_DOWN,
        arguments = {
            seconds = 1
        }
    }
})

Test.RegisterTests("shooting", {
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