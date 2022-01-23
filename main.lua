TestingMod = RegisterMod("Testing Framework", 1)
local font = Font()
font:Load("font/terminus.fnt")

local json = include("json")
local helpers = include("helpers")

local registeredMods = {}

local registeredTests = {}

if TestingMod:HasData() then
    registeredMods = json.decode(TestingMod:LoadData())
end

Test = {}

TestActions = {
    MOVE_RIGHT = "MOVE_RIGHT",
    MOVE_LEFT = "MOVE_LEFT",
    MOVE_UP = "MOVE_UP",
    MOVE_DOWN = "MOVE_DOWN",
    SHOOT_RIGHT = "SHOOT_RIGHT",
    SHOOT_LEFT = "SHOOT_LEFT",
    SHOOT_UP = "SHOOT_UP",
    SHOOT_DOWN = "SHOOT_DOWN",
    USE_CARD = "USE_CARD",
    USE_PILL = "USE_PILL",
    USE_BOMB = "USE_BOMB",
    USE_ITEM = "USE_ITEM",
    DROP_POCKET_ITEM = "DROP_POCKET_ITEM",
    DROP_TRINKET = "DROP_TRINKET",
    RUN_COMMAND = "RUN_COMMAND",
    GIVE_CARD = "GIVE_CARD",
    GIVE_ITEM = "GIVE_ITEM",
    GIVE_PILL = "GIVE_PILL",
    GIVE_TRINKET = "GIVE_TRINKET",
    WAIT_FOR_KEY = "WAIT_FOR_KEY",
    ENABLE_DEBUG_FLAG = "ENABLE_DEBUG_FLAG",
    DISABLE_DEBUG_FLAG = "DISABLE_DEBUG_FLAG",
    EXECUTE_LUA = "EXECUTE_LUA",
    RESTART = "RESTART",
    SPAWN = "SPAWN",
    WAIT_FOR_SECONDS = "WAIT_FOR_SECONDS",
    WAIT_FOR_FRAMES = "WAIT_FOR_FRAMES",
    REPEAT = "REPEAT",
    SWAP_PILL_CARDS = "SWAP_PILL_CARDS",
    SWAP_ACTIVE_ITEMS = "SWAP_ACTIVE_ITEMS",
    SWAP_SUB_PLAYERS = "SWAP_SUB_PLAYERS",
    SWAP = "SWAP",
    TELEPORT_TO_POSITION = "TELEPORT_TO_POSITION",
    CHARGE_ACTIVE_ITEM = "CHARGE_ACTIVE_ITEM",
    DISCHARGE_ACTIVE_ITEM = "DISCHARGE_ACTIVE_ITEM",
    GO_TO_DOOR = "GO_TO_DOOR",
    CLEAR_SEED = "CLEAR_SEED"
}

function Test.RegisterTest(name, steps, mod)
    registeredTests[name] = steps

    if mod and not registeredMods[mod] then
        registeredMods[mod] = true

        TestingMod:SaveData(json.encode(registeredMods))
    end

    return steps
end

function Test.RegisterTests(name, tests, mod, awaitStep)
    local finalSteps = {}

    for index, test in pairs(tests) do
        local results

        if helpers.IncludesMultipleTests(test.steps) then
            results = Test.RegisterTests(test.name, test.steps, mod, awaitStep)
        else
            results = Test.RegisterTest(test.name, test.steps, mod)
        end

        if results then
            for _, newStep in pairs(results) do
                if not newStep._id then
                    newStep._id = test.name
                end
                table.insert(finalSteps, newStep)
            end
        end

        if index < #tests then
            table.insert(finalSteps, awaitStep or { action = TestActions.WAIT_FOR_KEY, key = Keyboard.KEY_ENTER })
        end
    end

    Test.RegisterTest(name, finalSteps, mod)

    return finalSteps
end

local initialDelayConfig = {
    frames = 0,
    next = nil
}

local shouldActions = {}

local delayConfig = helpers.DeepCopyTable(initialDelayConfig)

local GetAsyncOrDelay = function(arguments, value)
    if helpers.GetValue(arguments.async, arguments) then
        return 0
    else
        return value
    end
end

-- INSTRUCTIONS

local stop = function()
    shouldActions = {}
    delayConfig = helpers.DeepCopyTable(initialDelayConfig)
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
    delay(helpers.GetValue(arguments.seconds, arguments), next)
end

local waitForFrames = function(arguments, next)
    delay(helpers.GetValue(arguments.frames, arguments), next, true)
end

local moveLeft = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.MOVE_LEFT,
        speed = helpers.GetValue(arguments.speed, arguments, 1),
        frames = helpers.GetValue(arguments.seconds, arguments, 0) * 30,
        playerIndex = helpers.GetPlayerIndex(arguments)
    })
    delay(GetAsyncOrDelay(arguments, arguments.seconds), next)
end

local moveRight = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.MOVE_RIGHT,
        speed = helpers.GetValue(arguments.speed, arguments, 1),
        frames = helpers.GetValue(arguments.seconds, arguments, 0) * 30,
        playerIndex = helpers.GetPlayerIndex(arguments)
    })
    delay(GetAsyncOrDelay(arguments, arguments.seconds), next)
end

local moveUp = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.MOVE_UP,
        speed = helpers.GetValue(arguments.speed, arguments, 1),
        frames = helpers.GetValue(arguments.seconds, arguments, 0) * 30,
        playerIndex = helpers.GetPlayerIndex(arguments)
    })
    delay(GetAsyncOrDelay(arguments, arguments.seconds), next)
end

local moveDown = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.MOVE_DOWN,
        speed = helpers.GetValue(arguments.speed, arguments, 1),
        frames = helpers.GetValue(arguments.seconds, arguments, 0) * 30,
        playerIndex = helpers.GetPlayerIndex(arguments)
    })
    delay(GetAsyncOrDelay(arguments, arguments.seconds), next)
end

local shootLeft = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.SHOOT_LEFT,
        frames = helpers.GetValue(arguments.seconds, arguments, 0) * 30,
        playerIndex = helpers.GetPlayerIndex(arguments)
    })
    delay(GetAsyncOrDelay(arguments, arguments.seconds), next)
end

local shootRight = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.SHOOT_RIGHT,
        frames = helpers.GetValue(arguments.seconds, arguments, 0) * 30,
        playerIndex = helpers.GetPlayerIndex(arguments)
    })
    delay(GetAsyncOrDelay(arguments, arguments.seconds), next)
end

local shootUp = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.SHOOT_UP,
        frames = helpers.GetValue(arguments.seconds, arguments, 0) * 30,
        playerIndex = helpers.GetPlayerIndex(arguments)
    })
    delay(GetAsyncOrDelay(arguments, arguments.seconds), next)
end

local shootDown = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.SHOOT_DOWN,
        frames = helpers.GetValue(arguments.seconds, arguments, 0) * 30,
        playerIndex = helpers.GetPlayerIndex(arguments)
    })
    delay(GetAsyncOrDelay(arguments, arguments.seconds), next)
end

local runCommand = function(arguments, next)
    local result = Isaac.ExecuteCommand(helpers.GetValue(arguments.command, arguments))
    delay(0, next)
    return result
end

local giveCard = function(arguments, next)
    local player = helpers.GetPlayer(arguments)

    player:AddCard(helpers.GetValue(arguments.id, arguments))
    delay(0, next)
end

local givePill = function(arguments, next)
    local player = helpers.GetPlayer(arguments)

    player:AddPill(helpers.GetValue(arguments.color, arguments))
    delay(0, next)
end

local giveItem = function(arguments, next)
    local player = helpers.GetPlayer(arguments)

    player:AddCollectible(helpers.GetValue(arguments.id, arguments), 0, true, helpers.GetValue(arguments.slot, arguments, 0))

    if helpers.GetValue(arguments.charged, arguments) then
        player:FullCharge(helpers.GetValue(arguments.slot, arguments, 0))
    end

    delay(0, next)
end

local giveTrinket = function(arguments, next)
    local player = helpers.GetPlayer(arguments)

    player:AddTrinket(helpers.GetValue(arguments.id, arguments))
    delay(0, next)
end

local useCard = function(arguments, next)
    local player = helpers.GetPlayer(arguments)

    local cardId

    if arguments.id then
        cardId = helpers.GetValue(arguments.id, arguments)
    else
        local card = player:GetCard(helpers.GetValue(arguments.slot, arguments, 0))
        if card ~= 0 then
            cardId = card
        end
    end

    if cardId then
        player:UseCard(cardId)

        for i = helpers.GetValue(arguments.slot, arguments, 0), 3 do
            player:SetCard(i, player:GetCard(i + 1))
        end

        delay(GetAsyncOrDelay(arguments, 13), next, true)
    else
        delay(0, next)
    end
end

local usePill = function(arguments, next)
    local player = helpers.GetPlayer(arguments)

    local pillId
    local pillColor

    if arguments.id then
        pillId = helpers.GetValue(arguments.id, arguments)
        pillColor = helpers.GetValue(arguments.color, arguments, 0)
    else
        local pill = player:GetPill(helpers.GetValue(arguments.slot, arguments, 0))
        if pill ~= 0 then
            pillColor = pill
            pillId = Game():GetItemPool():GetPillEffect(pillColor, player)
        end
    end

    if pillId then
        player:UsePill(pillId, pillColor or 0)

        for i = helpers.GetValue(arguments.slot, arguments, 0), 3 do
            player:SetPill(i, player:GetPill(i + 1))
        end

        delay(GetAsyncOrDelay(arguments, 13), next, true)
    else
        delay(0, next)
    end
end

local useBomb = function(arguments, next)
    local player = helpers.GetPlayer(arguments)

    if helpers.GetValue(arguments.force, arguments) or player:GetNumBombs() > 0 then
        player:FireBomb(player.Position, Vector.Zero, player)
        player:AddBombs(-1)
    end

    delay(GetAsyncOrDelay(arguments, 60), next, true)
end

local useItem = function(arguments, next)
    local player = helpers.GetPlayer(arguments)

    local itemId
    local itemSlot

    if arguments.id then
        itemId = helpers.GetValue(arguments.id, arguments, 0)
    else
        local item = player:GetActiveItem(helpers.GetValue(arguments.slot, arguments, 0))
        if item ~= 0 then
            itemId = item
            itemSlot = helpers.GetValue(arguments.slot, arguments, 0)
        end
    end

    if itemId and (helpers.GetValue(arguments.force, arguments) or not itemSlot or not player:NeedsCharge(itemSlot)) then
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
    local player = helpers.GetPlayer(arguments)

    player:DropPocketItem(helpers.GetValue(arguments.slot, arguments, 0), player.Position)
    delay(0, next)
end

local dropTrinket = function(arguments, next)
    local player = helpers.GetPlayer(arguments)

    player:DropTrinket(player.Position)
    delay(0, next)
end

local waitForKey = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.WAIT_FOR_KEY,
        key = helpers.GetValue(arguments.key, arguments, Keyboard.KEY_ENTER)
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
    if not isDebugFlagEnabled(helpers.GetValue(arguments.flag, arguments)) then
        toggleDebugFlag(helpers.GetValue(arguments.flag, arguments))
    end
    delay(0, next)
end

local disableDebugFlag = function(arguments, next)
    if isDebugFlagEnabled(helpers.GetValue(arguments.flag, arguments)) then
        toggleDebugFlag(helpers.GetValue(arguments.flag, arguments))
    end
    delay(0, next)
end

local executeLua = function(arguments, next)
    if type(arguments.code) == "function" then
        arguments.code(arguments)
        delay(0, next)
    else
        arguments.command = "lua "..helpers.GetValue(arguments.code, arguments)
        local result = runCommand(arguments, next)
        if result and result ~= "" then
            print(result)
        end
    end
end

local clearSeed = function(_, next)
    Game():GetSeeds():ClearStartSeed()

    delay(0, next)
end

local restart = function(arguments, next)
    if arguments.id then
        arguments.command = "restart "..helpers.GetValue(arguments.id, arguments)
    else
        arguments.command = "restart"
    end

    if not arguments.seed then
        clearSeed({}, function()
            runCommand(arguments, next)
        end)
    else
        runCommand({ command = arguments.command }, function()
            runCommand({ command = "seed "..helpers.GetValue(arguments.seed, arguments) }, function()
                if not helpers.GetValue(arguments.persist, arguments) then
                    clearSeed({}, next)
                end
            end)
        end)
    end
end

local spawn = function(arguments, next)
    local entity = Isaac.Spawn(helpers.GetValue(arguments.type, arguments), helpers.GetValue(arguments.variant, arguments, 0), helpers.GetValue(arguments.subType, arguments, 0), helpers.GetValue(arguments.position, arguments, Game():GetRoom():GetCenterPos()), helpers.GetValue(arguments.velocity, arguments, Vector.Zero), helpers.GetValue(arguments.spawner, arguments))

    if arguments.after and type(arguments.after) == "function" then
        arguments.after(entity)
    end

    delay(0, next)
end

local repeatStep = function(_, next)
    delay(0, next)
end

local swapPillCards = function(arguments, next)
    local player = helpers.GetPlayer(arguments)

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
    local player = helpers.GetPlayer(arguments)

    player:SwapActiveItems()

    delay(0, next)
end

local swap = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.SWAP,
        playerIndex = helpers.GetPlayerIndex(arguments)
    })
    delay(0, next)
end

local swapSubPlayers = function(arguments, next)
    table.insert(shouldActions, {
        action = TestActions.SWAP_SUB_PLAYERS,
        playerIndex = helpers.GetPlayerIndex(arguments)
    })
    delay(0, next)
end

local teleportToPosition = function(arguments, next)
    local player = helpers.GetPlayer(arguments)

    player.Position = Game():GetRoom():GetClampedPosition(helpers.GetValue(arguments.position, arguments, Game():GetRoom():GetCenterPos()), 0)

    delay(0, next)
end

local chargeActiveItem = function(arguments, next)
    local player = helpers.GetPlayer(arguments)

    player:FullCharge(helpers.GetValue(arguments.slot, arguments, 0))

    delay(0, next)
end

local dischargeActiveItem = function(arguments, next)
    local player = helpers.GetPlayer(arguments)

    player:DischargeActiveItem(helpers.GetValue(arguments.slot, arguments, 0))

    delay(0, next)
end

local goToDoor = function(arguments, next)
    local player = helpers.GetPlayer(arguments)
    local room = Game():GetRoom()

    if arguments.slot then
        local slotValue = helpers.GetValue(arguments.slot, arguments)
        local door = room:GetDoor(slotValue)

        if door then
            if not door:IsOpen() then
                door:SetLocked(false)
                door:Open()
                
                delay(12, function()
                    player.Position = room:GetDoorSlotPosition(slotValue)
                    delay(0, next)
                end, true)
            else
                player.Position = room:GetDoorSlotPosition(slotValue)
            end

            return
        end
    else
        for i = 0, DoorSlot.NUM_DOOR_SLOTS - 1 do
            local door = room:GetDoor(i)

            if door and door.TargetRoomType == (helpers.GetValue(arguments.type, arguments, RoomType.ROOM_DEFAULT)) then
                if not door:IsOpen() then
                    door:Open()

                    delay(12, function()
                        player.Position = room:GetDoorSlotPosition(i)
                        delay(0, next)
                    end, true)

                    return
                else
                    player.Position = room:GetDoorSlotPosition(i)
                end
            end
        end
    end

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
    [TestActions.TELEPORT_TO_POSITION] = teleportToPosition,
    [TestActions.CHARGE_ACTIVE_ITEM] = chargeActiveItem,
    [TestActions.DISCHARGE_ACTIVE_ITEM] = dischargeActiveItem,
    [TestActions.GO_TO_DOOR] = goToDoor,
    [TestActions.CLEAR_SEED] = clearSeed
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

        if step.action == TestActions.REPEAT and step.steps then
            local repeatSteps = {}

            for j = 1, helpers.GetValue(step.times, step, 1) do
                for _, repeatedStep in pairs(helpers.GetValue(step.steps, step)) do
                    table.insert(repeatSteps, repeatedStep)
                end
            end
            nextStep = createRunChain(repeatSteps, nextStep)

            goto continue
        end

        if i == #steps and step then
            step.async = nil
        end

        nextStep = function()
            TestSteps[step.action](step or {}, tempNextStep)
        end

        ::continue::
    end

    return nextStep
end

local function run(steps)
    local nextStep = createRunChain(steps)

    if nextStep then
        nextStep()
    end
end

local function GetTestFromAction(action, player)
    local truePlayerIndex = helpers.ExtractTruePlayerIndex(player)

    return helpers.FindTableEntryByProperty(shouldActions, { action = action, playerIndex = truePlayerIndex })
end

TestingMod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
    local position = Vector(Isaac.GetScreenWidth() / 4, Isaac.GetScreenHeight() - 20)
    local color = KColor(1, 1, 1, 1)
    local boxSize = math.floor(Isaac.GetScreenWidth() / 2)
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
                        helpers.RemoveElementFromTable(shouldActions, test)
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
                        helpers.RemoveElementFromTable(shouldActions, test)
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

    local waitForKeyTest = helpers.FindTableEntryByProperty(shouldActions, { action = TestActions.WAIT_FOR_KEY })

    if (not waitForKeyTest and delayConfig.frames <= 0) or (waitForKeyTest and Input.IsButtonPressed(waitForKeyTest.key, 0)) then
        helpers.RemoveElementFromTable(shouldActions, waitForKeyTest)

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
    if command:lower() == "test" and args then
        if args:lower() == "stop" then
            stop()
        else
            local testNames = {}
            for substring in args:gmatch("%S+") do
                table.insert(testNames, substring)
            end

            if #testNames > 0 then
                local firstTestName = testNames[1]
                local testSuite = registeredTests[firstTestName]
                table.remove(testNames, 1)
                local firstStepIndex = 1
                
                if testSuite then
                    for i, testName in pairs(testNames) do
                        local lastTestName

                        if i - 1 < 1 then
                            lastTestName = firstTestName
                        else
                            lastTestName = testNames[i - 1]
                        end

                        local foundFirstStepIndex = helpers.FindTableEntryIndexByProperty(testSuite, { _id = testName })
                        if not foundFirstStepIndex then
                            print("Tests not found for '"..testName.."' under '"..lastTestName.."'")
                            return
                        else
                            if firstStepIndex and foundFirstStepIndex < firstStepIndex then
                                print("Tests not found for '"..testName.."' under '"..lastTestName.."'")
                                return
                            else
                                firstStepIndex = foundFirstStepIndex
                            end
                        end
                    end

                    if firstStepIndex then
                        stop()

                        local steps = {}

                        for i = firstStepIndex, #testSuite do
                            table.insert(steps, testSuite[i])
                        end

                        run(steps)
                    end
                else
                    print("Tests not found for '"..testNames[1].."'")
                end
            else
                print("Tests not found for '"..args.."'")
            end
        end
    end
end)

include("tests")

local shouldReload = true

local function ReloadMods()
    if shouldReload then
        for key, _ in pairs(registeredMods) do
            local result = Isaac.ExecuteCommand("luamod "..key)
            if result ~= "Failed to run mod!" then
                print("Testing Mod re-registered '"..key.."' tests")
            else
                print("Testing Mod failed to re-register '"..key.."' tests because the mod is disabled")
            end
        end
        shouldReload = false
    else
        TestingMod:RemoveCallback(ModCallbacks.MC_POST_RENDER, ReloadMods)
    end
end

TestingMod:AddCallback(ModCallbacks.MC_POST_RENDER, ReloadMods)