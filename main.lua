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
    pillCard = false
}

local initialDelayConfig = {
    frames = 0,
    next = nil
}

local shouldActions = table.deepCopy(initialShouldActions)

local delayConfig = table.deepCopy(initialDelayConfig)

local stop = function()
    shouldActions = table.deepCopy(initialShouldActions)
    delayConfig = table.deepCopy(initialDelayConfig)
end

local delay = function(seconds, callback)
    delayConfig.frames = seconds * 30
    if callback then
        delayConfig.next = callback
    else
        delayConfig.next = stop
    end
end

local moveLeft = function(seconds, speed, next)
    speed = speed or 1
    shouldActions.left.speed = speed
    shouldActions.left.frames = seconds * 30
    delay(seconds, next)
end

local moveRight = function(seconds, speed, next)
    speed = speed or 1
    shouldActions.right.speed = speed
    shouldActions.right.frames = seconds * 30
    delay(seconds, next)
end

local moveUp = function(seconds, speed, next)
    speed = speed or 1
    shouldActions.up.speed = speed
    shouldActions.up.frames = seconds * 30
    delay(seconds, next)
end

local moveDown = function(seconds, speed, next)
    speed = speed or 1
    shouldActions.down.speed = speed
    shouldActions.down.frames = seconds * 30
    delay(seconds, next)
end

local runCommand = function(command, next)
    Isaac.ExecuteCommand(command)
    delay(0, next)
end

local usePillCard = function(next)
    shouldActions.pillCard = true
    delay(0, next)
end

TestingMod:AddCallback(ModCallbacks.MC_INPUT_ACTION, function(_, entity, inputHook, buttonAction)
    if entity ~= nil then
        if inputHook == InputHook.GET_ACTION_VALUE then
            if buttonAction == ButtonAction.ACTION_LEFT then
                return shouldActions.left.speed
            end
            if buttonAction == ButtonAction.ACTION_RIGHT then
                return shouldActions.right.speed
            end
            if buttonAction == ButtonAction.ACTION_UP then
                return shouldActions.up.speed
            end
            if buttonAction == ButtonAction.ACTION_DOWN then
                return shouldActions.down.speed
            end
        end

        if inputHook == InputHook.IS_ACTION_TRIGGERED then
            if buttonAction == ButtonAction.ACTION_PILLCARD then
                if shouldActions.pillCard then
                    shouldActions.pillCard = false
                    return true 
                end
            end
        end
    end
end)

TestingMod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
    shouldActions.left.frames = math.max(0, shouldActions.left.frames - 1)
    if shouldActions.left.frames <= 0 then
        shouldActions.left.speed = 0
    end
    shouldActions.right.frames = math.max(0, shouldActions.right.frames - 1)
    if shouldActions.right.frames <= 0 then
        shouldActions.right.speed = 0
    end
    shouldActions.up.frames = math.max(0, shouldActions.up.frames - 1)
    if shouldActions.up.frames <= 0 then
        shouldActions.up.speed = 0
    end
    shouldActions.down.frames = math.max(0, shouldActions.down.frames - 1)
    if shouldActions.down.frames <= 0 then
        shouldActions.down.speed = 0
    end
    delayConfig.frames = math.max(0, delayConfig.frames - 1)
    if delayConfig.frames <= 0 then
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

TestingMod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function(_, isContinued)
    if not isContinued then
        stop()
    end
    moveRight(2, 1, function()
        moveLeft(2, 0.5, function()
            moveUp(2, 0.5, function()
                runCommand("g k1", function()
                    usePillCard()
                end)
            end)
        end)
    end)
end)