-- Constant struct -- REMEMBER player:GetWorldPos()

-- Current implementation flow: method to update playerpos + method to check playerpos --> method to spawn entities -->
--> method that defines spawned entities


EventConstants = {
    --cSaveLockName = "warmodsavelock",
    --cMarshalName = "warmodmarshal",
    -- todo: inconsistent naming schema, change to camel case
    rat_side = 1,
    cuman_side = 2,
	bandit_side = 3,
    troopCost = 100,
    waveCost = 200,
    numWaves = 8,
    corpseTime = 15000, --15 seconds
    victoryTime = 20000, -- 20 seconds
    waveInterval = 90000, -- 5 seconds PREVIOUSLY 75000/75 SECONDS
    
    -- todo: put this in another data structure that will help set up a whole encampment
    campMesh = "objects/structures/tent_cuman/tent_cuman_v6_b.cgf",
    squadNumberVariance = 1,
    
    eventChance = 40 -- clamp this to 0 to 100
}

WarEncampmentMeshes = {
    { -- tent
        mesh = "objects/structures/tent_cuman/tent_cuman_v6_b.cgf",
        class = "BasicEntity",
        offset = { x = 0, y = 0, z = 0 },
        orientation = { x = 1, y = 0, z = 0}
    },
    { -- table or something
        mesh = "objects/structures/tent_cuman/tent_cuman_v6_b.cgf",
        class = "BasicEntity",
        offset = { x = 0, y = 0, z = 0 },
        orientation = { x = 1, y = 0, z = 0}
    },
    { -- weapons rack
        mesh = "objects/structures/tent_cuman/tent_cuman_v6_b.cgf",
        class = "BasicEntity",
        offset = { x = 0, y = 0, z = 0 },
        orientation = { x = 1, y = 0, z = 0}
    },
}

WarEvents = {
    cumanMoreArchers = 1,
    ratMoreArchers = 1,
    lessWaves = 2,
    --cumanAmbush = 3,
    --rattayAmbush = 4
}

WarRewards = {
    base = 250,
    perWave = 150,
    perKill = 6,
}

EventTroopTypes = {
    commander = 0,
    knight = 1,
    halberd = 2,
    aux = 3,
    bow = 4,
    halberd_light = 5,
    aux_light = 6
}

-- is this still worth it? event system can substitute some of this
BattleTypes = {
    Attack = 0,
    Defend = 1,
    Field = 2,
    Ambush = 3
}

EventGuids = {
    knight = {},
    halberd = {},
    aux = {},
    bow = {}
}

WarDifficulty = {
    low = 0,
    medium = 40,
    hard = 80,
    veryhard = 120,
    impossible = 160
}

WarStrengthPerWave = {
    cumanStrengthPerWave = 42,
    rattayStrengthPerWave = 35,
}
-- Defaults
-- Cumans get another knight because the rattay get the player, the ultimate knight
WarStrengthPerWave[EventTroopTypes.knight] = {}
WarStrengthPerWave[EventTroopTypes.knight][EventConstants.rat_side] = 3
WarStrengthPerWave[EventTroopTypes.knight][EventConstants.cuman_side] = 5
WarStrengthPerWave[EventTroopTypes.halberd] = {}
WarStrengthPerWave[EventTroopTypes.halberd][EventConstants.rat_side] = 16
WarStrengthPerWave[EventTroopTypes.halberd][EventConstants.cuman_side] = 11
WarStrengthPerWave[EventTroopTypes.aux] = {}
WarStrengthPerWave[EventTroopTypes.aux][EventConstants.rat_side] = 6
WarStrengthPerWave[EventTroopTypes.aux][EventConstants.cuman_side] = 9
WarStrengthPerWave[EventTroopTypes.bow] = {}
WarStrengthPerWave[EventTroopTypes.bow][EventConstants.rat_side] = 10
WarStrengthPerWave[EventTroopTypes.bow][EventConstants.cuman_side] = 17

EventGuids[EventTroopTypes.knight] = {}
EventGuids[EventTroopTypes.knight][EventConstants.rat_side] = "41429725-5368-3cb1-6440-2e2e02b4fc97"
EventGuids[EventTroopTypes.knight][EventConstants.cuman_side] = "49c00005-e5e9-ee50-7370-8bc12c8ad29f"
EventGuids[EventTroopTypes.halberd] = {}
EventGuids[EventTroopTypes.halberd][EventConstants.rat_side] = "43b48356-ecf4-5e6e-bce4-1d98ed745baa"
EventGuids[EventTroopTypes.halberd][EventConstants.cuman_side] = "4957c994-1489-f528-130c-a00b9838a4a5"
EventGuids[EventTroopTypes.aux] = {}
EventGuids[EventTroopTypes.aux][EventConstants.rat_side] = "4aa17e70-525a-1e83-d32f-adf2f8c60daf"
EventGuids[EventTroopTypes.aux][EventConstants.cuman_side] = "4c4f6e9d-aa80-4f1b-a9d9-62573e6de2a7"
EventGuids[EventTroopTypes.bow] = {}
EventGuids[EventTroopTypes.bow][EventConstants.rat_side] = "822cfefc-4d92-4fa4-824a-f772b511eeca"
EventGuids[EventTroopTypes.bow][EventConstants.cuman_side] = "8f876dd6-9457-4072-b8f8-693de5debaad"


EventLocations = {
    
        --center = {x = 3136.570,y= 854.815,z= 122.557}, rat = {x = 2995.868,y = 809.014,z = 113.108}, cuman = {x = 3136.570,y= 854.815,z= 122.557}, camp = { x = 2979.425, y = 801.855, z = 110.145 },
		event1Center = {x = 1298.108,y= 1598.815,z= 40.4371},
		event1Cuman = {x = 1307.381,y= 1575.64,z= 38.8291},
        event1Rat = {x = 1307.381,y= 1575.64,z= 38.8291},
        --name="Event1",
        --resourceNode = false,
        --influence = 12,
    
    
}

-- If your Regional Influence gets too low, enemy starts doing raids on towns and cities 
-- DYNAMIC EVENTS: IF WARMOD IS INSTALLED, THIS WILL ALSO RESULT IN DYNAMIC CUMAN AND BANDIT SPAWNS AROUND THESE AREAS
WarRaidLocations = {
    {
        rat = {x =2558.429,y =463.0462,z = 68.1582}, cuman = {x =2370.252,y=558.5708,z=32.163 }, camp = { x =2552.782, y = 512.0674, z = 72.5 },
        name="Castle Pirkstein and Rattay",
        resourceNode = false,
        influence = 15,
    },
    {
        rat = {x =911.6,y =1703.476,z = 43.7582}, cuman = {x =805.8848,y=1708.74,z=59.8 }, camp = { x =908, y = 1697.313, z = 42.7 },
        name="Sasau Monastary",
        resourceNode = false,
        influence = 15,
    }
}

-- If your Regional Influence gets too high, you start making assaults on enemy camps
WarAssaultLocations = {
    {
        rat = {x =866.8859,y =3199.533,z = 23.8}, cuman = {x =870.2924,y=3336.631,z=24.963 }, camp = { x =854.09, y = 3177.754, z = 32.4 },
        name="Skalitz Camp Assault",
        resourceNode = false,
        influence = 15,
    }
}

EventLocationstest = {
    {
        center = { x=47.969, y=43.522, z=33.583}, rat = { x=27.969, y=43.522, z=33.583}, cuman = { x=67.969, y=43.522, z=33.583}, camp = { x=47.969, y=43.522, z=33.583},
        name="Test battleground",
        influence = 10
    }
}

Side = {
    strength = 500,
    money = 100000,
    controlledLocations = {}
}

Battle = {
    center = nil,
    rat_point = nil,
    cuman_point = nil,
    locations = nil,
    
    wavesleft = EventConstants.numWaves,
    rattayStrengthPerWave = WarStrengthPerWave.rattayStrengthPerWave,
    cumanStrengthPerWave = WarStrengthPerWave.cumanStrengthPerWave,
    strengthPerWave = {},
    rattayTroops = {},
    cumanTroops = {},
    
    troops = {},
    numCuman = 0,
    numRattay = 0,
    
    kills = 0,
    
    ratCommander = nil,
    cumanCommander = nil,
    
    currentEvent = nil,
    isDefense = false,
    isAssault = false,
    
}

EventController = {
    Rattay = Side,
    Cuman = Side,
    needReload = false,
    -- only 1 battle can occur at a time
    inBattle = false,
    readyForNewBattle = true,
    currentBattle = Battle,
    -- important - this can refer to different structures, war locations, war raid locations, etc
    nextBattleLocation = nil,
    

    -- in gametime
    timeBattleStarted = 0, 
    -- try not to repeat the same location multiple times
    -- misnomer because its really a key
    ignoreLocationIdx = -1,
    marshal = nil,
    logiOfficer = nil,
    regionalInfluence = 50,
    
}