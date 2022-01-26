Test.RegisterTest("cards", {
    {
        action = "RESTART"
    },
    {
        action = "GIVE_ITEM",
        id = 251
    },
    {
        action = "GIVE_CARD",
        id = 2
    },
    {
        action = "GIVE_CARD",
        id = 3
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 1
    },
    {
        action = "USE_CARD",
        slot = 0
    },
})

Test.RegisterTest("pills", {
    {
        action = "RESTART"
    },
    {
        action = "GIVE_PILL",
        color = 2
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 1
    },
    {
        action = "USE_PILL",
        slot = 0
    },
})

Test.RegisterTest("cards2", {
    {
        action = "RESTART",
        id = 19
    },
    {
        action = "GIVE_CARD",
        id = 2
    },
    {
        action = "GIVE_CARD",
        id = 3,
        playerIndex = 1
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 1
    },
    {
        action = "USE_CARD",
        slot = 0,
        playerIndex = 1
    },
    {
        action = "USE_CARD",
        slot = 0
    },
})

Test.RegisterTest("items", {
    {
        action = "RESTART"
    },
    {
        action = "GIVE_ITEM",
        id = 650
    },
    {
        action = "ENABLE_DEBUG_FLAG",
        flag = 8
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 1
    },
    {
        action = "DISABLE_DEBUG_FLAG",
        flag = 8
    },
    {
        action = "USE_ITEM",
        force = true
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 1
    },
    {
        action = "USE_ITEM",
        id = 126
    },
})

Test.RegisterTest("bombs", {
    {
        action = "RESTART"
    },
    {
        action = "USE_BOMB",
        async = true
    },
    {
        action = "MOVE_UP",
        seconds = 0.7
    },
    {
        action = "USE_BOMB",
        force = true,
        async = true
    },
    {
        action = "MOVE_DOWN",
        seconds = 0.7
    },
})

Test.RegisterTest("movement", {
    {
        action = "RESTART"
    },
    {
        action = "MOVE_LEFT",
        seconds = 1
    },
    {
        action = "MOVE_UP",
        seconds = 1
    },
    {
        action = "MOVE_RIGHT",
        seconds = 1,
        async = true
    },
    {
        action = "MOVE_DOWN",
        seconds = 1
    }
})

Test.RegisterTest("movement2", {
    {
        action = "RESTART",
        id = 19
    },
    {
        action = "MOVE_LEFT",
        seconds = 1,
        async = true
    },
    {
        action = "MOVE_RIGHT",
        seconds = 1,
        playerIndex = 1
    },
    {
        action = "MOVE_UP",
        seconds = 1,
        async = true
    },
        {
        action = "MOVE_UP",
        seconds = 1,
        playerIndex = 1
    },
    {
        action = "MOVE_RIGHT",
        seconds = 1,
        async = true
    },
    {
        action = "MOVE_DOWN",
        seconds = 1,
        async = true
    },
        {
        action = "MOVE_LEFT",
        seconds = 1,
        async = true,
        playerIndex = 1
    },
    {
        action = "MOVE_DOWN",
        seconds = 1,
        playerIndex = 1,
        async = true
    }
})

Test.RegisterTest("shooting", {
    {
        action = "RESTART"
    },
    {
        action = "SHOOT_RIGHT",
        seconds = 1
    },
    {
        action = "SHOOT_DOWN",
        seconds = 1
    },
    {
        action = "SHOOT_LEFT",
        seconds = 1
    },
    {
        action = "SHOOT_UP",
        seconds = 1
    },
})

Test.RegisterTest("key", {
    {
        action = "WAIT_FOR_KEY",
        key = Keyboard.KEY_ENTER
    },
    {
        action = "SHOOT_RIGHT",
        seconds = 1
    }
})

Test.RegisterTest("seconds", {
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 5
    },
    {
        action = "SHOOT_RIGHT",
        seconds = 1
    }
})

Test.RegisterTest("swapCards", {
    {
        action = "RESTART"
    },
    {
        action = "GIVE_ITEM",
        id = 251
    },
    {
        action = "GIVE_CARD",
        id = 1
    },
    {
        action = "GIVE_CARD",
        id = 2
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 1
    },
    {
        action = "SWAP_PILL_CARDS"
    }
})

Test.RegisterTest("swapItems", {
    {
        action = "RESTART"
    },
    {
        action = "GIVE_ITEM",
        id = 534
    },
    {
        action = "GIVE_ITEM",
        id = 650
    },
    {
        action = "GIVE_ITEM",
        id = 84
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 1
    },
    {
        action = "SWAP_ACTIVE_ITEMS"
    }
})

Test.RegisterTest("swap", {
    {
        action = "RESTART"
    },
    {
        action = "GIVE_ITEM",
        id = 534
    },
    {
        action = "GIVE_ITEM",
        id = 251
    },
    {
        action = "GIVE_ITEM",
        id = 650
    },
    {
        action = "GIVE_ITEM",
        id = 84
    },
    {
        action = "GIVE_CARD",
        id = 1
    },
    {
        action = "GIVE_CARD",
        id = 2
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 1
    },
    {
        action = "SWAP"
    }
})

Test.RegisterTest("swapSubPlayers", {
    {
        action = "RESTART",
        id = 16
    },
    {
        action = "GIVE_ITEM",
        id = 534
    },
    {
        action = "GIVE_ITEM",
        id = 251
    },
    {
        action = "GIVE_ITEM",
        id = 650
    },
    {
        action = "GIVE_ITEM",
        id = 84
    },
    {
        action = "GIVE_CARD",
        id = 1
    },
    {
        action = "GIVE_CARD",
        id = 2
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 1
    },
    {
        action = "SWAP_SUB_PLAYERS"
    }
})

Test.RegisterTest("drop", {
    {
        action = "RESTART",
        id = 0
    },
    {
        action = "GIVE_CARD",
        id = 1
    },
    {
        action = "GIVE_TRINKET",
        id = 1
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 1
    },
    {
        action = "DROP_POCKET_ITEM"
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 1
    },
    {
        action = "GIVE_ITEM",
        id = 251
    },
    {
        action = "GIVE_CARD",
        id = 1
    },
    {
        action = "GIVE_CARD",
        id = 2
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 1
    },
    {
        action = "DROP_POCKET_ITEM",
        slot = 1
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 1
    },
    {
        action = "DROP_TRINKET",
        slot = 1
    },
    {
        action = "WAIT_FOR_KEY",
        key = Keyboard.KEY_ENTER
    },
    {
        action = "RESTART",
        id = 19
    },
    {
        action = "GIVE_CARD",
        id = 1,
        playerIndex = 1
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 1
    },
    {
        action = "DROP_POCKET_ITEM",
        playerIndex = 1
    }
})

Test.RegisterTest("teleport", {
    {
        action = "RESTART"
    },
    {
        action = "TELEPORT_TO_POSITION",
        x = "50%",
        y = "50%"
    }
})

Test.RegisterTest("repeat", {
    {
        action = "REPEAT",
        times = 2,
        steps = {
            {
                action = "USE_CARD",
                id = 3
            },
            {
                action = "WAIT_FOR_KEY",
                key = Keyboard.KEY_ENTER
            }
        }
    },
    {
        action = "SHOOT_DOWN",
        seconds = 1
    }
})

Test.RegisterTest("door", {
    {
        action = "RESTART",
        id = 0
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 2
    },
    {
        action = "GO_TO_DOOR"
    }
})

Test.RegisterTests("outerTest", {
    {
        name = "innerTest",
        steps = {
            {
                name = "innerInnerTest",
                steps = {
                    {
                        action = "EXECUTE_LUA",
                        code = function() print('running innerInnerTest') end
                    }
                },
                instructions = "innerInnerTest"
            },
            {
                name = "innerInnerTestTwo",
                steps = {
                    {
                        action = "EXECUTE_LUA",
                        code = function() print('running innerInnerTestTwo') end
                    }
                },
                instructions = "innerInnerTestTwo"
            },
            {
                name = "innerInnerTestThree",
                steps = {
                    {
                        action = "EXECUTE_LUA",
                        code = function() print('running innerInnerTestThree') end
                    }
                }
            }
        },
        instructions = "poggie inner test"
    }
})