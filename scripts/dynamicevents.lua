DynamicEvents = {
    cUniqueIdName="EventControlleridunique",
    currController = nil
}

function DynamicEvents.calculateDistance(point1, point2)
    local dx = point2.x - point1.x
    local dy = point2.y - point1.y
    local dz = point2.z - point1.z
    return math.sqrt(dx * dx + dy * dy + dz * dz)
end

--[==[

function DynamicEvents:CreateSkirmish()
--(position, objective)
    --if self.marshal == nil then
        --local spawnParams = {}
        --spawnParams.class = "NPC"
        --spawnParams.orientation = { x = 0, y = 0, z = 0 }
        --local vec = { x = 2979.425, y = 801.855, z = 111.145 }
		
		-- EVENT 1: FORK IN FOREST ROAD SOUTH OF SASAU

		System.LogAlways("Checking for ideal skirmish conditions")
		
		---[==[
		local success, errorOrResult = pcall(function()
			
			System.LogAlways("$5 [EventController] has been successfully created.")
		end)

		if not success then
			System.LogAlways("Error in DynamicEvents.create: " .. tostring(errorOrResult))
			System.LogAlways("StackTrace: " .. debug.traceback(errorOrResult, 2))
		end
		
		
		if event1Dist > 4 and event1Dist < 30  and spawnChance <= 100
        -- if player is farther than 30 meters from Event center but no closer than 4 meters, spawnChance check will initiate
		-- eventually change this to a foreach
			
		local position1a = getrandomposnear(event1Rat, 5.0)
		local position2a = getrandomposnear(event1Rat, 5.0)
		local position3a = getrandomposnear(event1Rat, 5.0)
		
		local position1b = getrandomposnear(event1Cuman, 10.0)
		local position2b = getrandomposnear(event1Cuman, 10.0)
		local position3b = getrandomposnear(event1Cuman, 10.0)

        --EventController:Spawn(EventConstants.rat_side, position1a, event1Center, EventTroopTypes.aux) -- PLANNED METHODOLOGY
        --EventController:Spawn(EventConstants.rat_side, position2a, event1Center, EventTroopTypes.aux) -- enumerate positions
        --EventController:Spawn(EventConstants.rat_side, position3a, event1Center, EventTroopTypes.aux) -- deliberately spawn troops on positions, skip the mumbo jumbo that base mod uses
		
		System.LogAlways("PLAYER IN ZONE: SPAWNED THREE RATTAY SWORDSMEN")
		
        --EventController:Spawn(EventConstants.cuman_side, position1b, event1Center, EventTroopTypes.aux) -- start with one event location and adjust accordingly
        --EventController:Spawn(EventConstants.cuman_side, position2b, event1Center, EventTroopTypes.aux) -- find out how the script calls its methods (maybe use ChatGPT; use original files)
        --EventController:Spawn(EventConstants.cuman_side, position3b, event1Center, EventTroopTypes.aux) -- see if it'll work performantly if all spawns are just active all the time
		
		System.LogAlways("PLAYER IN ZONE: SPAWNED THREE CUMAN SWORDSMEN")
		
		System.LogAlways("SKIRMISH CREATED SUCCESSFULLY")
		message = "ENCOUNTERED EVENT"
		Game.SendInfoText(message,false,nil,5)
		
		--return true
		
		else
		
		System.LogAlways("CONDITIONS NOT MET: NO SKIRMISH")
		
		--return false

		end
        --self:CreateLogiOfficer(position)
        --self:CreateWarCamp(position)
        --self:AssignActions(entity)
        --self:AssignQuest()
    
end

--]==]

function DynamicEvents.create()
    


	local success, errorOrResult = pcall(function()
        local spawnParams = {}
		spawnParams.class = "EventController"
		spawnParams.orientation = { x = 0, y = 0, z = 1 }
		spawnParams.properties = {}
		spawnParams.name = DynamicEvents.cUniqueIdName
		local entity = System.SpawnEntity(spawnParams)		
		DynamicEvents.currController = entity
		System.LogAlways("$5 [EventController] has been successfully created.")
    end)

    if not success then
        System.LogAlways("Error in DynamicEvents.create: " .. tostring(errorOrResult))
        System.LogAlways("StackTrace: " .. debug.traceback(errorOrResult, 2))
    end
	
end

function DynamicEvents.Update() --check Player position every 7 seconds
	System.LogAlways("Executing DynamicEvents.Update()")
	spawnChance = math.random(1, 100)
	System.LogAlways("Spawn chance: " .. spawnChance)	
	
	playerPos = player:GetWorldPos()
	System.LogAlways("Player Position: " .. tostring(playerPos.x) .. ", " .. tostring(playerPos.y) .. ", " .. tostring(playerPos.z))
	
	event1Dist = DynamicEvents.calculateDistance (EventLocations.event1Center, playerPos) --check player distance from Event locations
																			--every 7 seconds
																			--function EventController:CreateSkirmish
																			--will read Dist floats and control spawning 
																			
	
	
	
	System.LogAlways("Event 1 Distance: " .. event1Dist)
	
	--self:CreateSkirmish()
	
	--[==[
	
	--]==]	
		--System.LogAlways("PLAYER IN ZONE: SPAWNED THREE CUMAN SWORDSMEN")
		
		--System.LogAlways("SKIRMISH CREATED SUCCESSFULLY")
		--message = "ENCOUNTERED EVENT"
		--Game.SendInfoText(message,false,nil,5)
		
		--return true
		
		--else
		
		System.LogAlways("CONDITIONS NOT MET: NO SKIRMISH")
	
--[==[ 

	local eventController = DynamicEvents.currController

	
	if eventController ~= nil then
	
	System.LogAlways("Current Controller identified")
	
		if eventController:CreateSkirmish() == nil then
		
			System.LogAlways("No valid method")
			
		else

        eventController:CreateSkirmish()

		end
        

	elseif eventController == nil then
	
        System.LogAlways("No valid controller")
		
	else 
		
		System.LogAlways("Skirmish creation failed or conditions not met")
		
    end
	
	local entities = System.GetEntitiesByClass("EventController")
    for key, value in pairs(entities) do
        System.RemoveEntity(value.id)
    end
--]==]
	                  	
	
	Script.SetTimer(7000, function()
        DynamicEvents.Update()
    end)																		
																			
end

function DynamicEvents.start()
    local success, errorOrResult = pcall(function()
        System.LogAlways("Executing DynamicEvents:start()")
        math.randomseed(os.time())
        System.LogAlways("math randomseed done")

        --DynamicEvents.Update(currController)
		DynamicEvents.Update()
		-- pass entity current controller between start and update

        System.LogAlways("FL AMBUSHES AND SKIRMISHES MOD STARTED")
    end)

    if not success then
        System.LogAlways("Error in DynamicEvents.start: " .. tostring(errorOrResult))
        System.LogAlways("StackTrace: " .. debug.traceback(errorOrResult, 2))
    end
end

function DynamicEvents.FG_Init()
    System.LogAlways("FG_Init awake")
	
--[==[ 
	allcontrollers = System.GetEntitiesByClass("EventController")
    local key, value = next(allcontrollers)
    local entity = value
	System.LogAlways("FG_Init p1")
    if entity == nil then
        DynamicEvents.create()
		
		--allcontrollers = System.GetEntitiesByClass("EventController")
		--local key, value = next(allcontrollers)
		--local entity = value
		--System.LogAlways("Number of EventControllers: " .. tostring(#allcontrollers))
		
		--DynamicEvents.currController = entity
	System.LogAlways("FG_Init p2")	
    else
        System.LogAlways("Found existing EventController")
        DynamicEvents.currController = entity
		System.LogAlways("Number of EventControllers: " .. tostring(#allcontrollers))
    end

--]==]
    
	--System.LogAlways("Current active controller is" .. tostring(DynamicEvents.currController))
	Script.SetTimer(2000, function()
        DynamicEvents.start()
		--pass entity current controller to start function
    end)
	
    System.LogAlways("$5 Started dynamicevents")
end

function DynamicEvents.endearly()
    DynamicEvents.currController.currentBattle.cumanCommander.soul:DealDamage(200,200)
end

function DynamicEvents.clearcamp()
    local entity = System.GetEntityByName("warcamp")
    if entity ~= nil then
        System.RemoveEntity(entity.id)
    end
end

function DynamicEvents.uninstall()
    local entities = System.GetEntitiesByClass("EventController")
    for key, value in pairs(entities) do
        System.RemoveEntity(value.id)
    end
end

--[==[

for key, value in pairs(entity) do
    System.LogAlways("Entity Property: " .. key .. " = " .. tostring(value))
	end

--]==]



System.AddCCommand("dynamicevents_uninstall", "DynamicEvents.uninstall()", "[Debug] test follower")
System.AddCCommand("dynamicevents", "DynamicEvents.create()", "[Debug] test follower")
System.AddCCommand("dynamicevents_kill", "DynamicEvents.endearly()", "[Debug] test follower")
System.AddCCommand("dynamicevents_clearcamp", "DynamicEvents.clearcamp()", "[Debug] test follower")
