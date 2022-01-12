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

local initialShouldActions = {
    left = {
        frames = 0,
        speed = 0
    },
    right = {
        frames = 0,
        speed = 0
    },
    up = {
        frames = 0,
        speed = 0
    },
    down = {
        frames = 0,
        speed = 0
    },
    shootLeft = {
        frames = 0
    },
    shootRight = {
        frames = 0
    },
    shootUp = {
        frames = 0
    },
    shootDown = {
        frames = 0
    },
    pillCard = false,
    bomb = false,
    item = false,
    drop = {
        frames = 0
    },
    waitForKey = nil
}

local initialDelayConfig = {
    frames = 0,
    next = nil
}

local shouldActions = table.deepCopy(initialShouldActions)

local delayConfig = table.deepCopy(initialDelayConfig)

-- INSTRUCTIONS

local stop = function()
    shouldActions = table.deepCopy(initialShouldActions)
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
    arguments.speed = arguments.speed or 1
    shouldActions.left.speed = arguments.speed
    shouldActions.left.frames = arguments.seconds * 30
    delay(arguments.seconds, next)
end

local moveRight = function(arguments, next)
    arguments.speed = arguments.speed or 1
    shouldActions.right.speed = arguments.speed
    shouldActions.right.frames = arguments.seconds * 30
    delay(arguments.seconds, next)
end

local moveUp = function(arguments, next)
    arguments.speed = arguments.speed or 1
    shouldActions.up.speed = arguments.speed
    shouldActions.up.frames = arguments.seconds * 30
    delay(arguments.seconds, next)
end

local moveDown = function(arguments, next)
    arguments.speed = arguments.speed or 1
    shouldActions.down.speed = arguments.speed
    shouldActions.down.frames = arguments.seconds * 30
    delay(arguments.seconds, next)
end

local shootLeft = function(arguments, next)
    shouldActions.shootLeft.frames = arguments.seconds * 30
    delay(arguments.seconds, next)
end

local shootRight = function(arguments, next)
    shouldActions.shootRight.frames = arguments.seconds * 30
    delay(arguments.seconds, next)
end

local shootUp = function(arguments, next)
    shouldActions.shootUp.frames = arguments.seconds * 30
    delay(arguments.seconds, next)
end

local shootDown = function(arguments, next)
    shouldActions.shootDown.frames = arguments.seconds * 30
    delay(arguments.seconds, next)
end

local runCommand = function(arguments, next)
    local result = Isaac.ExecuteCommand(arguments.command)
    delay(arguments.delay, next)
    return result
end

local giveCard = function(arguments, next)
    arguments.command = "g k"..arguments.id
    runCommand(arguments, next)
end

local giveItem = function(arguments, next)
    arguments.command = "g c"..arguments.id
    runCommand(arguments, next)
end

local usePillCard = function(arguments, next)
    shouldActions.pillCard = true
    local delayFrames = 0
    if arguments.await then
       delayFrames = 13
    end
    delay(delayFrames, next, true)
end

local useBomb = function(arguments, next)
    shouldActions.bomb = true
    local delayFrames = 0
    if arguments.await then
       delayFrames = 60
    end
    delay(delayFrames, next, true)
end

local useItem = function(arguments, next)
    shouldActions.item = true
    local delayFrames = 0
    if arguments.await then
       delayFrames = 18
    end
    delay(delayFrames, next, true)
end

local dropPillCard = function(arguments, next)
    local framesCount = 2.5 * 30
    shouldActions.drop.frames = framesCount
    local delayFrames = 0
    if arguments.await then
       delayFrames = framesCount
    end
    delay(delayFrames, next, true)
end

local waitForKey = function(arguments, next)
    shouldActions.waitForKey = arguments.key
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
    delay(arguments.seconds, next)
end

local disableDebugFlag = function(arguments, next)
    if isDebugFlagEnabled(arguments.flag) then
        toggleDebugFlag(arguments.flag)
    end
    delay(arguments.seconds, next)
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
    [TestActions.MOVE_RIGHT] = moveRight,
    [TestActions.MOVE_LEFT] = moveLeft,
    [TestActions.MOVE_UP] = moveUp,
    [TestActions.MOVE_DOWN] = moveDown,
    [TestActions.SHOOT_RIGHT] = shootRight,
    [TestActions.SHOOT_LEFT] = shootLeft,
    [TestActions.SHOOT_UP] = shootUp,
    [TestActions.SHOOT_DOWN] = shootDown,
    [TestActions.USE_PILL_CARD] = usePillCard,
    [TestActions.USE_BOMB] = useBomb,
    [TestActions.USE_ITEM] = useItem,
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
        nextStep = function()
            TestSteps[step.action](step.arguments, tempNextStep)
        end
    end
    nextStep()
end

TestingMod:AddCallback(ModCallbacks.MC_INPUT_ACTION, function(_, entity, inputHook, buttonAction)
    if entity ~= nil then

        -- Moving
        if inputHook == InputHook.GET_ACTION_VALUE then
            if buttonAction == ButtonAction.ACTION_LEFT then
                if shouldActions.left.frames > 0 then
                   return shouldActions.left.speed
                end
            end
            if buttonAction == ButtonAction.ACTION_RIGHT then
                if shouldActions.right.frames > 0 then
                   return shouldActions.right.speed
                end
            end
            if buttonAction == ButtonAction.ACTION_UP then
                if shouldActions.up.frames > 0 then
                   return shouldActions.up.speed
                end
            end
            if buttonAction == ButtonAction.ACTION_DOWN then
                if shouldActions.down.frames > 0 then
                   return shouldActions.down.speed
                end
            end

            if buttonAction == ButtonAction.ACTION_SHOOTLEFT then
                if shouldActions.shootLeft.frames > 0 then
                    return 1
                end
            end
            if buttonAction == ButtonAction.ACTION_SHOOTRIGHT then
                if shouldActions.shootRight.frames > 0 then
                    return 1
                end
            end
            if buttonAction == ButtonAction.ACTION_SHOOTUP then
                if shouldActions.shootUp.frames > 0 then
                    return 1
                end
            end
            if buttonAction == ButtonAction.ACTION_SHOOTDOWN then
                if shouldActions.shootDown.frames > 0 then
                    return 1
                end
            end
        end

        -- Use pill slot
        if inputHook == InputHook.IS_ACTION_TRIGGERED then
            if buttonAction == ButtonAction.ACTION_PILLCARD then
                if shouldActions.pillCard then
                    shouldActions.pillCard = false
                    return true
                end
            end

            if buttonAction == ButtonAction.ACTION_BOMB then
                if shouldActions.bomb then
                    shouldActions.bomb = false
                    return true
                end
            end

            if buttonAction == ButtonAction.ACTION_ITEM then
                if shouldActions.item then
                    shouldActions.item = false
                    return true
                end
            end
        end

        -- Shooting
        if inputHook == InputHook.IS_ACTION_PRESSED then
            if buttonAction == ButtonAction.ACTION_SHOOTLEFT then
                if shouldActions.shootLeft.frames > 0 then
                    return 1
                end
            end
            if buttonAction == ButtonAction.ACTION_SHOOTRIGHT then
                if shouldActions.shootRight.frames > 0 then
                    return 1
                end
            end
            if buttonAction == ButtonAction.ACTION_SHOOTUP then
                if shouldActions.shootUp.frames > 0 then
                    return 1
                end
            end
            if buttonAction == ButtonAction.ACTION_SHOOTDOWN then
                if shouldActions.shootDown.frames > 0 then
                    return 1
                end
            end

            if buttonAction == ButtonAction.ACTION_DROP then
                if shouldActions.drop.frames > 0 then
                    return 1
                end
            end
        end
    end
end)

TestingMod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
    if not Game():IsPaused() then
        for _, value in pairs(shouldActions) do
            if value and type(value) == "table" and value.frames then
                value.frames = math.max(0, value.frames - 1)
            end
        end
    end

    if shouldActions.left.frames <= 0 then
        shouldActions.left.speed = 0
    end

    if shouldActions.right.frames <= 0 then
        shouldActions.right.speed = 0
    end

    if shouldActions.up.frames <= 0 then
        shouldActions.up.speed = 0
    end

    if shouldActions.down.frames <= 0 then
        shouldActions.down.speed = 0
    end

    delayConfig.frames = math.max(0, delayConfig.frames - 1)

    if (shouldActions.waitForKey and Input.IsButtonPressed(shouldActions.waitForKey, 0)) or (not shouldActions.waitForKey and delayConfig.frames <= 0) then
        shouldActions.waitForKey = nil
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
            print("Testing steps not found for '"..args.."'")
        end
    end
end)