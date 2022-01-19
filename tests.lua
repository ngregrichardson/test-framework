Test.RegisterTest("cards", {
    {
        action = "RESTART",
        arguments = {}
    },
    {
        action = "GIVE_ITEM",
        arguments = {
            id = 251
        }
    },
    {
        action = "GIVE_CARD",
        arguments = {
            id = 2
        }
    },
    {
        action = "GIVE_CARD",
        arguments = {
            id = 3
        }
    },
    {
        action = "WAIT_FOR_SECONDS",
        arguments = {
            seconds = 1
        }
    },
    {
        action = "USE_CARD",
        arguments = {
            slot = 0
        }
    },
})

Test.RegisterTest("pills", {
    {
        action = "RESTART",
        arguments = {}
    },
    {
        action = "GIVE_PILL",
        arguments = {
            color = 2
        }
    },
    {
        action = "WAIT_FOR_SECONDS",
        arguments = {
            seconds = 1
        }
    },
    {
        action = "USE_PILL",
        arguments = {
            slot = 0
        }
    },
})

Test.RegisterTest("cards2", {
    {
        action = "RESTART",
        arguments = {
            id = 19
        }
    },
    {
        action = "GIVE_CARD",
        arguments = {
            id = 2
        }
    },
    {
        action = "GIVE_CARD",
        arguments = {
            id = 3,
            playerIndex = 1
        }
    },
    {
        action = "WAIT_FOR_SECONDS",
        arguments = {
            seconds = 1
        }
    },
    {
        action = "USE_CARD",
        arguments = {
            slot = 0,
            playerIndex = 1
        }
    },
    {
        action = "USE_CARD",
        arguments = {
            slot = 0
        }
    },
})

Test.RegisterTest("items", {
    {
        action = "RESTART",
        arguments = {}
    },
    {
        action = "GIVE_ITEM",
        arguments = {
            id = 650
        }
    },
    {
        action = "ENABLE_DEBUG_FLAG",
        arguments = {
            flag = 8
        }
    },
    {
        action = "WAIT_FOR_SECONDS",
        arguments = {
            seconds = 1
        }
    },
    {
        action = "DISABLE_DEBUG_FLAG",
        arguments = {
            flag = 8
        }
    },
    {
        action = "USE_ITEM",
        arguments = {
            force = true
        }
    },
    {
        action = "WAIT_FOR_SECONDS",
        arguments = {
            seconds = 1
        }
    },
    {
        action = "USE_ITEM",
        arguments = {
            id = 126
        }
    },
})

Test.RegisterTest("bombs", {
    {
        action = "RESTART",
        arguments = {}
    },
    {
        action = "USE_BOMB",
        arguments = {
            async = true
        }
    },
    {
        action = "MOVE_UP",
        arguments = {
            seconds = 0.7
        }
    },
    {
        action = "USE_BOMB",
        arguments = {
            force = true,
            async = true
        }
    },
    {
        action = "MOVE_DOWN",
        arguments = {
            seconds = 0.7
        }
    },
})

Test.RegisterTest("movement", {
    {
        action = "RESTART",
        arguments = {}
    },
    {
        action = "MOVE_LEFT",
        arguments = {
            seconds = 1
        }
    },
    {
        action = "MOVE_UP",
        arguments = {
            seconds = 1
        }
    },
    {
        action = "MOVE_RIGHT",
        arguments = {
            seconds = 1,
            async = true
        }
    },
    {
        action = "MOVE_DOWN",
        arguments = {
            seconds = 1
        }
    }
})

Test.RegisterTest("movement2", {
    {
        action = "RESTART",
        arguments = {
            id = 19
        }
    },
    {
        action = "MOVE_LEFT",
        arguments = {
            seconds = 1,
            async = true
        }
    },
    {
        action = "MOVE_RIGHT",
        arguments = {
            seconds = 1,
            playerIndex = 1
        }
    },
    {
        action = "MOVE_UP",
        arguments = {
            seconds = 1,
            async = true
        }
    },
        {
        action = "MOVE_UP",
        arguments = {
            seconds = 1,
            playerIndex = 1
        }
    },
    {
        action = "MOVE_RIGHT",
        arguments = {
            seconds = 1,
            async = true
        }
    },
    {
        action = "MOVE_DOWN",
        arguments = {
            seconds = 1,
            async = true
        }
    },
        {
        action = "MOVE_LEFT",
        arguments = {
            seconds = 1,
            async = true,
            playerIndex = 1
        }
    },
    {
        action = "MOVE_DOWN",
        arguments = {
            seconds = 1,
            playerIndex = 1,
            async = true
        }
    }
})

Test.RegisterTest("shooting", {
    {
        action = "RESTART",
        arguments = {}
    },
    {
        action = "SHOOT_RIGHT",
        arguments = {
            seconds = 1
        }
    },
    {
        action = "SHOOT_DOWN",
        arguments = {
            seconds = 1
        }
    },
    {
        action = "SHOOT_LEFT",
        arguments = {
            seconds = 1
        }
    },
    {
        action = "SHOOT_UP",
        arguments = {
            seconds = 1
        }
    },
})

Test.RegisterTest("key", {
    {
        action = "WAIT_FOR_KEY",
        arguments = {
            key = Keyboard.KEY_ENTER
        }
    },
    {
        action = "SHOOT_RIGHT",
        arguments = {
            seconds = 1
        }
    }
})

Test.RegisterTest("seconds", {
    {
        action = "WAIT_FOR_SECONDS",
        arguments = {
            seconds = 5
        }
    },
    {
        action = "SHOOT_RIGHT",
        arguments = {
            seconds = 1
        }
    }
})

Test.RegisterTest("swapCards", {
    {
        action = "RESTART",
        arguments = {
        }
    },
    {
        action = "GIVE_ITEM",
        arguments = {
            id = 251
        }
    },
    {
        action = "GIVE_CARD",
        arguments = {
            id = 1
        }
    },
    {
        action = "GIVE_CARD",
        arguments = {
            id = 2
        }
    },
    {
        action = "WAIT_FOR_SECONDS",
        arguments = {
            seconds = 1
        }
    },
    {
        action = "SWAP_PILL_CARDS",
        arguments = {
        }
    }
})

Test.RegisterTest("swapItems", {
    {
        action = "RESTART",
        arguments = {
        }
    },
    {
        action = "GIVE_ITEM",
        arguments = {
            id = 534
        }
    },
    {
        action = "GIVE_ITEM",
        arguments = {
            id = 650
        }
    },
    {
        action = "GIVE_ITEM",
        arguments = {
            id = 84
        }
    },
    {
        action = "WAIT_FOR_SECONDS",
        arguments = {
            seconds = 1
        }
    },
    {
        action = "SWAP_ACTIVE_ITEMS",
        arguments = {
        }
    }
})

Test.RegisterTest("swap", {
    {
        action = "RESTART",
        arguments = {
        }
    },
    {
        action = "GIVE_ITEM",
        arguments = {
            id = 534
        }
    },
    {
        action = "GIVE_ITEM",
        arguments = {
            id = 251
        }
    },
    {
        action = "GIVE_ITEM",
        arguments = {
            id = 650
        }
    },
    {
        action = "GIVE_ITEM",
        arguments = {
            id = 84
        }
    },
    {
        action = "GIVE_CARD",
        arguments = {
            id = 1
        }
    },
    {
        action = "GIVE_CARD",
        arguments = {
            id = 2
        }
    },
    {
        action = "WAIT_FOR_SECONDS",
        arguments = {
            seconds = 1
        }
    },
    {
        action = "SWAP",
        arguments = {
        }
    }
})

Test.RegisterTest("swapSubPlayers", {
    {
        action = "RESTART",
        arguments = {
            id = 16
        }
    },
    {
        action = "GIVE_ITEM",
        arguments = {
            id = 534
        }
    },
    {
        action = "GIVE_ITEM",
        arguments = {
            id = 251
        }
    },
    {
        action = "GIVE_ITEM",
        arguments = {
            id = 650
        }
    },
    {
        action = "GIVE_ITEM",
        arguments = {
            id = 84
        }
    },
    {
        action = "GIVE_CARD",
        arguments = {
            id = 1
        }
    },
    {
        action = "GIVE_CARD",
        arguments = {
            id = 2
        }
    },
    {
        action = "WAIT_FOR_SECONDS",
        arguments = {
            seconds = 1
        }
    },
    {
        action = "SWAP_SUB_PLAYERS",
        arguments = {
        }
    }
})

Test.RegisterTest("drop", {
    {
        action = "RESTART",
        arguments = {
            id = 0
        }
    },
    {
        action = "GIVE_CARD",
        arguments = {
            id = 1
        }
    },
    {
        action = "GIVE_TRINKET",
        arguments = {
            id = 1
        }
    },
    {
        action = "WAIT_FOR_SECONDS",
        arguments = {
            seconds = 1
        }
    },
    {
        action = "DROP_POCKET_ITEM",
        arguments = {}
    },
    {
        action = "WAIT_FOR_SECONDS",
        arguments = {
            seconds = 1
        }
    },
    {
        action = "GIVE_ITEM",
        arguments = {
            id = 251
        }
    },
    {
        action = "GIVE_CARD",
        arguments = {
            id = 1
        }
    },
    {
        action = "GIVE_CARD",
        arguments = {
            id = 2
        }
    },
    {
        action = "WAIT_FOR_SECONDS",
        arguments = {
            seconds = 1
        }
    },
    {
        action = "DROP_POCKET_ITEM",
        arguments = {
            slot = 1
        }
    },
    {
        action = "WAIT_FOR_SECONDS",
        arguments = {
            seconds = 1
        }
    },
    {
        action = "DROP_TRINKET",
        arguments = {
            slot = 1
        }
    },
    {
        action = "WAIT_FOR_KEY",
        arguments = {
            key = Keyboard.KEY_ENTER,
        }
    },
    {
        action = "RESTART",
        arguments = {
            id = 19
        }
    },
    {
        action = "GIVE_CARD",
        arguments = {
            id = 1,
            playerIndex = 1
        }
    },
    {
        action = "WAIT_FOR_SECONDS",
        arguments = {
            seconds = 1,
        }
    },
    {
        action = "DROP_POCKET_ITEM",
        arguments = {
            playerIndex = 1
        }
    }
})

Test.RegisterTest("teleport", {
    {
        action = "RESTART",
        arguments = {
        }
    },
    {
        action = "TELEPORT_TO_POSITION",
        arguments = {
            x = "50%",
            y = "50%"
        }
    }
})

Test.RegisterTest("repeat", {
    {
        action = "REPEAT",
        arguments = {
            times = 2,
            steps = {
                {
                    action = "USE_CARD",
                    arguments = {
                        id = 3
                    }
                },
                {
                    action = "WAIT_FOR_KEY",
                    arguments = {
                        key = Keyboard.KEY_ENTER
                    }
                }
            }
        }
    },
    {
        action = "SHOOT_DOWN",
        arguments = {
            seconds = 1
        }
    }
})