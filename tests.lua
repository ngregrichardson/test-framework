-- Test.RegisterTests("testing", {
--     {
--         name = "cards",
--         steps = {
--             {
--                 action = "RESTART",
--                 id = PlayerType.PLAYER_ISAAC
--             },
--             {
--                 action = "GIVE_CARD",
--                 id = function()
--                     for i = 1, 12 do
--                         if i == 6 then
--                             return i
--                         end
--                     end
--                 end
--             },
--             {
--                 action = "WAIT_FOR_SECONDS",
--                 seconds = 1
--             },
--             {
--                 action = "USE_CARD"
--             },
--             {
--                 action = "GIVE_ITEM",
--                 id = CollectibleType.COLLECTIBLE_STARTER_DECK
--             },
--             {
--                 action = "GIVE_CARD",
--                 id = 3
--             },
--             {
--                 action = "GIVE_CARD",
--                 id = 4
--             },
--             {
--                 action = "WAIT_FOR_SECONDS",
--                 seconds = 1
--             },
--             {
--                 action = "USE_CARD",
--                 slot = function(args)
--                     local player = Isaac.GetPlayer(args.playerIndex or 0)
--                     for i = 0, 3 do
--                         if player:GetCard(i) == 0 then
--                             return i - 1
--                         end
--                     end
--                 end
--             },
--         }
--     }
-- })

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

Test.RegisterTest("MovementAndShooting", {
    {
        action = "RESTART",
        id = PlayerType.PLAYER_ISAAC
    },
    {
        action = "REPEAT",
        times = 5,
        steps = {
            {
                action = "GIVE_ITEM",
                id = CollectibleType.COLLECTIBLE_BLUE_CAP
            }
        }
    },
    {
        action = "GIVE_ITEM",
        id = CollectibleType.COLLECTIBLE_HOLY_GRAIL
    },
    {
        action = "GIVE_ITEM",
        id = CollectibleType.COLLECTIBLE_TECHNOLOGY_2
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 3
    },
    {
        action = "MOVE_UP",
        seconds = 1,
        async = true
    },
    {
        action = "MOVE_RIGHT",
        seconds = 1,
        async = true
    },
    {
        action = "SHOOT_LEFT",
        seconds = 1
    },
    {
        action = "MOVE_LEFT",
        seconds = 2,
        async = true
    },
    {
        action = "SHOOT_RIGHT",
        seconds = 2
    },
    {
        action = "MOVE_DOWN",
        seconds = 0.5,
        async = true
    },
    {
        action = "SHOOT_RIGHT",
        seconds = 0.5
    },
    {
        action = "MOVE_RIGHT",
        seconds = 1,
        async = true
    },
    {
        action = "SHOOT_UP",
        seconds = 1
    }
})

Test.RegisterTest("PickupInteractions", {
    {
        action = "RESTART",
        id = PlayerType.PLAYER_ISAAC
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 3
    },
    {
        action = "REPEAT",
        times = 5,
        steps = {
            {
                action = "GIVE_ITEM",
                id = CollectibleType.COLLECTIBLE_SPEED_BALL
            }
        }
    },
    {
        action = "REPEAT",
        times = 5,
        steps = {
            {
                action = "USE_CARD",
                id = Card.CARD_LOVERS
            }
        }
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 0.5
    },
    {
        action = "GIVE_ITEM",
        id = CollectibleType.COLLECTIBLE_WE_NEED_TO_GO_DEEPER,
        charged = true
    },
    {
        action = "USE_ITEM"
    }
})

local enemyEntities = {
    EntityType.ENTITY_BOMBDROP,
    EntityType.ENTITY_GAPER,
    EntityType.ENTITY_GUSHER,
    EntityType.ENTITY_HORF,
    EntityType.ENTITY_FLY,
    EntityType.ENTITY_POOTER,
    EntityType.ENTITY_CLOTTY,
    EntityType.ENTITY_MULLIGAN,
    EntityType.ENTITY_SHOPKEEPER,
    EntityType.ENTITY_ATTACKFLY,
    EntityType.ENTITY_LARRYJR,
    EntityType.ENTITY_MONSTRO,
    EntityType.ENTITY_MAGGOT,
    EntityType.ENTITY_HIVE,
    EntityType.ENTITY_CHARGER,
    EntityType.ENTITY_GLOBIN,
    EntityType.ENTITY_BOOMFLY,
    EntityType.ENTITY_MAW,
    EntityType.ENTITY_HOST,
    EntityType.ENTITY_CHUB,
    EntityType.ENTITY_HOPPER,
    EntityType.ENTITY_BOIL,
    EntityType.ENTITY_SPITY,
    EntityType.ENTITY_BRAIN,
    EntityType.ENTITY_FIREPLACE,
    EntityType.ENTITY_LEAPER,
    EntityType.ENTITY_MRMAW,
    EntityType.ENTITY_GURDY,
    EntityType.ENTITY_BABY,
    EntityType.ENTITY_VIS,
    EntityType.ENTITY_GUTS,
    EntityType.ENTITY_KNIGHT,
    EntityType.ENTITY_STONEHEAD,
    EntityType.ENTITY_MONSTRO2,
    EntityType.ENTITY_POKY,
    EntityType.ENTITY_MOM,
    EntityType.ENTITY_SLOTH,
    EntityType.ENTITY_LUST,
    EntityType.ENTITY_WRATH,
    EntityType.ENTITY_GLUTTONY,
    EntityType.ENTITY_GREED,
    EntityType.ENTITY_ENVY,
    EntityType.ENTITY_PRIDE,
    EntityType.ENTITY_DOPLE,
    EntityType.ENTITY_FLAMINGHOPPER,
    EntityType.ENTITY_LEECH,
    EntityType.ENTITY_LUMP,
    EntityType.ENTITY_MEMBRAIN,
    EntityType.ENTITY_PARA_BITE,
    EntityType.ENTITY_FRED,
    EntityType.ENTITY_EYE,
    EntityType.ENTITY_SUCKER,
    EntityType.ENTITY_PIN,
    EntityType.ENTITY_FAMINE,
    EntityType.ENTITY_PESTILENCE,
    EntityType.ENTITY_WAR,
    EntityType.ENTITY_DEATH,
    EntityType.ENTITY_DUKE,
    EntityType.ENTITY_PEEP,
    EntityType.ENTITY_LOKI,
    EntityType.ENTITY_FISTULA_BIG,
    EntityType.ENTITY_FISTULA_MEDIUM,
    EntityType.ENTITY_FISTULA_SMALL,
    EntityType.ENTITY_BLASTOCYST_BIG,
    EntityType.ENTITY_BLASTOCYST_MEDIUM,
    EntityType.ENTITY_BLASTOCYST_SMALL,
    EntityType.ENTITY_EMBRYO,
    EntityType.ENTITY_MOMS_HEART,
    EntityType.ENTITY_GEMINI,
    EntityType.ENTITY_MOTER,
    EntityType.ENTITY_FALLEN,
    EntityType.ENTITY_HEADLESS_HORSEMAN,
    EntityType.ENTITY_HORSEMAN_HEAD,
    EntityType.ENTITY_SATAN,
    EntityType.ENTITY_SPIDER,
    EntityType.ENTITY_KEEPER,
    EntityType.ENTITY_GURGLE,
    EntityType.ENTITY_WALKINGBOIL,
    EntityType.ENTITY_BUTTLICKER,
    EntityType.ENTITY_HANGER,
    EntityType.ENTITY_SWARMER,
    EntityType.ENTITY_HEART,
    EntityType.ENTITY_MASK,
    EntityType.ENTITY_BIGSPIDER,
    EntityType.ENTITY_ETERNALFLY,
    EntityType.ENTITY_MASK_OF_INFAMY,
    EntityType.ENTITY_HEART_OF_INFAMY,
    EntityType.ENTITY_GURDY_JR,
    EntityType.ENTITY_WIDOW,
    EntityType.ENTITY_DADDYLONGLEGS,
    EntityType.ENTITY_ISAAC,
    EntityType.ENTITY_STONE_EYE,
    EntityType.ENTITY_CONSTANT_STONE_SHOOTER,
    EntityType.ENTITY_BRIMSTONE_HEAD,
    EntityType.ENTITY_MOBILE_HOST,
    EntityType.ENTITY_NEST,
    EntityType.ENTITY_BABY_LONG_LEGS,
    EntityType.ENTITY_CRAZY_LONG_LEGS,
    EntityType.ENTITY_FATTY,
    EntityType.ENTITY_FAT_SACK,
    EntityType.ENTITY_BLUBBER,
    EntityType.ENTITY_HALF_SACK,
    EntityType.ENTITY_DEATHS_HEAD,
    EntityType.ENTITY_MOMS_HAND,
    EntityType.ENTITY_FLY_L2,
    EntityType.ENTITY_SPIDER_L2,
    EntityType.ENTITY_SWINGER,
    EntityType.ENTITY_DIP,
    EntityType.ENTITY_WALL_HUGGER,
    EntityType.ENTITY_WIZOOB,
    EntityType.ENTITY_SQUIRT,
    EntityType.ENTITY_COD_WORM,
    EntityType.ENTITY_RING_OF_FLIES,
    EntityType.ENTITY_DINGA,
    EntityType.ENTITY_OOB,
    EntityType.ENTITY_BLACK_MAW,
    EntityType.ENTITY_SKINNY,
    EntityType.ENTITY_BONY,
    EntityType.ENTITY_HOMUNCULUS,
    EntityType.ENTITY_TUMOR,
    EntityType.ENTITY_CAMILLO_JR,
    EntityType.ENTITY_NERVE_ENDING,
    EntityType.ENTITY_ONE_TOOTH,
    EntityType.ENTITY_GAPING_MAW,
    EntityType.ENTITY_BROKEN_GAPING_MAW,
    EntityType.ENTITY_GURGLING,
    EntityType.ENTITY_SPLASHER,
    EntityType.ENTITY_GRUB,
    EntityType.ENTITY_WALL_CREEP,
    EntityType.ENTITY_RAGE_CREEP,
    EntityType.ENTITY_BLIND_CREEP,
    EntityType.ENTITY_CONJOINED_SPITTY,
    EntityType.ENTITY_ROUND_WORM,
    EntityType.ENTITY_POOP,
    EntityType.ENTITY_RAGLING,
    EntityType.ENTITY_FLESH_MOBILE_HOST,
    EntityType.ENTITY_PSY_HORF,
    EntityType.ENTITY_FULL_FLY,
    EntityType.ENTITY_TICKING_SPIDER,
    EntityType.ENTITY_BEGOTTEN,
    EntityType.ENTITY_NULLS,
    EntityType.ENTITY_PSY_TUMOR,
    EntityType.ENTITY_FLOATING_KNIGHT,
    EntityType.ENTITY_NIGHT_CRAWLER,
    EntityType.ENTITY_DART_FLY,
    EntityType.ENTITY_CONJOINED_FATTY,
    EntityType.ENTITY_FAT_BAT,
    EntityType.ENTITY_IMP,
    EntityType.ENTITY_THE_HAUNT,
    EntityType.ENTITY_DINGLE,
    EntityType.ENTITY_MEGA_MAW,
    EntityType.ENTITY_GATE,
    EntityType.ENTITY_MEGA_FATTY,
    EntityType.ENTITY_CAGE,
    EntityType.ENTITY_MAMA_GURDY,
    EntityType.ENTITY_DARK_ONE,
    EntityType.ENTITY_ADVERSARY,
    EntityType.ENTITY_POLYCEPHALUS,
    EntityType.ENTITY_MR_FRED,
    EntityType.ENTITY_URIEL,
    EntityType.ENTITY_GABRIEL,
    EntityType.ENTITY_THE_LAMB,
    EntityType.ENTITY_MEGA_SATAN,
    EntityType.ENTITY_MEGA_SATAN_2,
    EntityType.ENTITY_ROUNDY,
    EntityType.ENTITY_BLACK_BONY,
    EntityType.ENTITY_BLACK_GLOBIN,
    EntityType.ENTITY_BLACK_GLOBIN_HEAD,
    EntityType.ENTITY_BLACK_GLOBIN_BODY,
    EntityType.ENTITY_SWARM,
    EntityType.ENTITY_MEGA_CLOTTY,
    EntityType.ENTITY_BONE_KNIGHT,
    EntityType.ENTITY_CYCLOPIA,
    EntityType.ENTITY_RED_GHOST,
    EntityType.ENTITY_FLESH_DEATHS_HEAD,
    EntityType.ENTITY_MOMS_DEAD_HAND,
    EntityType.ENTITY_DUKIE,
    EntityType.ENTITY_ULCER,
    EntityType.ENTITY_MEATBALL,
    EntityType.ENTITY_PITFALL,
    EntityType.ENTITY_MOVABLE_TNT,
    EntityType.ENTITY_ULTRA_COIN,
    EntityType.ENTITY_CORN_MINE,
    EntityType.ENTITY_HUSH_FLY,
    EntityType.ENTITY_HUSH_GAPER,
    EntityType.ENTITY_HUSH_BOIL,
    EntityType.ENTITY_GREED_GAPER,
    EntityType.ENTITY_MUSHROOM,
    EntityType.ENTITY_POISON_MIND,
    EntityType.ENTITY_STONEY,
    EntityType.ENTITY_BLISTER,
    EntityType.ENTITY_THE_THING,
    EntityType.ENTITY_MINISTRO,
    EntityType.ENTITY_PORTAL,
    EntityType.ENTITY_TARBOY,
    EntityType.ENTITY_FISTULOID,
    EntityType.ENTITY_GUSH,
    EntityType.ENTITY_LEPER,
    EntityType.ENTITY_STAIN,
    EntityType.ENTITY_BROWNIE,
    EntityType.ENTITY_FORSAKEN,
    EntityType.ENTITY_LITTLE_HORN,
    EntityType.ENTITY_RAG_MAN,
    EntityType.ENTITY_ULTRA_GREED,
    EntityType.ENTITY_HUSH,
    EntityType.ENTITY_HUSH_SKINLESS,
    EntityType.ENTITY_RAG_MEGA,
    EntityType.ENTITY_SISTERS_VIS,
    EntityType.ENTITY_BIG_HORN,
    EntityType.ENTITY_DELIRIUM,
    EntityType.ENTITY_MATRIARCH,
    EntityType.ENTITY_BLOOD_PUPPY,
    EntityType.ENTITY_QUAKE_GRIMACE,
    EntityType.ENTITY_BISHOP,
    EntityType.ENTITY_BUBBLES,
    EntityType.ENTITY_WRAITH,
    EntityType.ENTITY_WILLO,
    EntityType.ENTITY_BOMB_GRIMACE,
    EntityType.ENTITY_SMALL_LEECH,
    EntityType.ENTITY_DEEP_GAPER,
    EntityType.ENTITY_SUB_HORF,
    EntityType.ENTITY_BLURB,
    EntityType.ENTITY_STRIDER,
    EntityType.ENTITY_FISSURE,
    EntityType.ENTITY_POLTY,
    EntityType.ENTITY_PREY,
    EntityType.ENTITY_ROCK_SPIDER,
    EntityType.ENTITY_FLY_BOMB,
    EntityType.ENTITY_DANNY,
    EntityType.ENTITY_BLASTER,
    EntityType.ENTITY_BOUNCER,
    EntityType.ENTITY_QUAKEY,
    EntityType.ENTITY_GYRO,
    EntityType.ENTITY_FIRE_WORM,
    EntityType.ENTITY_HARDY,
    EntityType.ENTITY_FACELESS,
    EntityType.ENTITY_NECRO,
    EntityType.ENTITY_MOLE,
    EntityType.ENTITY_BIG_BONY,
    EntityType.ENTITY_GUTTED_FATTY,
    EntityType.ENTITY_EXORCIST,
    EntityType.ENTITY_CANDLER,
    EntityType.ENTITY_WHIPPER,
    EntityType.ENTITY_PEEPER_FATTY,
    EntityType.ENTITY_VIS_VERSA,
    EntityType.ENTITY_HENRY,
    EntityType.ENTITY_WILLO_L2,
    EntityType.ENTITY_PON,
    EntityType.ENTITY_REVENANT,
    EntityType.ENTITY_BOMBGAGGER,
    EntityType.ENTITY_GAPER_L2,
    EntityType.ENTITY_TWITCHY,
    EntityType.ENTITY_SPIKEBALL,
    EntityType.ENTITY_SMALL_MAGGOT,
    EntityType.ENTITY_ADULT_LEECH,
    EntityType.ENTITY_CHARGER_L2,
    EntityType.ENTITY_GASBAG,
    EntityType.ENTITY_COHORT,
    EntityType.ENTITY_FLOATING_HOST,
    EntityType.ENTITY_UNBORN,
    EntityType.ENTITY_PUSTULE,
    EntityType.ENTITY_CYST,
    EntityType.ENTITY_MORNINGSTAR,
    EntityType.ENTITY_MOCKULUS,
    EntityType.ENTITY_EVIS,
    EntityType.ENTITY_DARK_ESAU,
    EntityType.ENTITY_MOTHERS_SHADOW,
    EntityType.ENTITY_ARMYFLY,
    EntityType.ENTITY_MIGRAINE,
    EntityType.ENTITY_DRIP,
    EntityType.ENTITY_SPLURT,
    EntityType.ENTITY_CLOGGY,
    EntityType.ENTITY_FLY_TRAP,
    EntityType.ENTITY_FARTIGAN,
    EntityType.ENTITY_POOT_MINE,
    EntityType.ENTITY_DUMP,
    EntityType.ENTITY_GRUDGE,
    EntityType.ENTITY_BUTT_SLICKER,
    EntityType.ENTITY_BLOATY,
    EntityType.ENTITY_FLESH_MAIDEN,
    EntityType.ENTITY_NEEDLE,
    EntityType.ENTITY_DUST,
    EntityType.ENTITY_BABY_BEGOTTEN,
    EntityType.ENTITY_SWARM_SPIDER,
    EntityType.ENTITY_CULTIST,
    EntityType.ENTITY_VIS_FATTY,
    EntityType.ENTITY_DUSTY_DEATHS_HEAD,
    EntityType.ENTITY_SHADY,
    EntityType.ENTITY_CLICKETY_CLACK,
    EntityType.ENTITY_MAZE_ROAMER,
    EntityType.ENTITY_GOAT,
    EntityType.ENTITY_POOFER,
    EntityType.ENTITY_BALL_AND_CHAIN,
    EntityType.ENTITY_REAP_CREEP,
    EntityType.ENTITY_LIL_BLUB,
    EntityType.ENTITY_RAINMAKER,
    EntityType.ENTITY_VISAGE,
    EntityType.ENTITY_SIREN,
    EntityType.ENTITY_HERETIC,
    EntityType.ENTITY_HORNFEL,
    EntityType.ENTITY_GIDEON,
    EntityType.ENTITY_BABY_PLUM,
    EntityType.ENTITY_SCOURGE,
    EntityType.ENTITY_CHIMERA,
    EntityType.ENTITY_ROTGUT,
    EntityType.ENTITY_MOTHER,
    EntityType.ENTITY_MIN_MIN,
    EntityType.ENTITY_CLOG,
    EntityType.ENTITY_SINGE,
    EntityType.ENTITY_BUMBINO,
    EntityType.ENTITY_COLOSTOMIA,
    EntityType.ENTITY_TURDLET,
    EntityType.ENTITY_RAGLICH,
    EntityType.ENTITY_HORNY_BOYS,
    EntityType.ENTITY_CLUTCH,
    EntityType.ENTITY_DOGMA,
    EntityType.ENTITY_BEAST,
    EntityType.ENTITY_GENERIC_PROP,
    EntityType.ENTITY_FROZEN_ENEMY,
    EntityType.ENTITY_DUMMY,
    EntityType.ENTITY_SIREN_HELPER
}

local rng = RNG()

Test.RegisterTest("Spawning", {
    {
        action = "RESTART",
        id = PlayerType.PLAYER_CAIN
    },
    {
        action = "WAIT_FOR_SECONDS",
        seconds = 3
    },
    {
        action = "REPEAT",
        times = 10,
        steps = {
            {
                action = "SPAWN",
                type = function()
                    return enemyEntities[rng:RandomInt(#enemyEntities) + 1]
                end,
                position = function() return Isaac.GetRandomPosition() end
            },
            {
                action = "WAIT_FOR_SECONDS",
                seconds = 0.2
            }
        }
    }
})

Test.RegisterTest("Multiplayer", {
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

Test.RegisterTests("StinkyMod", {
    {
        name = "MyStinkyCard",
        steps = {
            {
                action = "GIVE_CARD",
                id = Card.CARD_JUSTICE
            },
            {
                action = "USE_CARD"
            }
        }
    },
    {
        name = "MyStinkyItem",
        steps = {
            {
                action = "GIVE_ITEM",
                id = CollectibleType.COLLECTIBLE_PLUM_FLUTE,
                charged = true
            },
            {
                action = "USE_ITEM"
            }
        }
    }
})

Test.RegisterTests("MyStinkyModOuter", {
    {
        name = "MyStinkyMod",
        steps = {
            {
                action = "GIVE_CARD",
                id = Card.CARD_JUSTICE
            },
            {
                action = "USE_CARD"
            }
        },
        instructions = {
            "Use the card",
            "Make sure pickups drop"
        }
    }
})