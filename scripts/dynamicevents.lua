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

function DynamicEvents.FG_Init()
    allcontrollers = System.GetEntitiesByClass("EventController")
    local key, value = next(allcontrollers)
    local entity = value
    if entity == nil then
        DynamicEvents.create()
		
		allcontrollers = System.GetEntitiesByClass("EventController")
		local key, value = next(allcontrollers)
		local entity = value
		System.LogAlways("Number of EventControllers: " .. tostring(#allcontrollers))
		
		DynamicEvents.currController = entity
		
    else
        System.LogAlways("Found existing EventController")
        DynamicEvents.currController = entity
    end    
	System.LogAlways("Current active controller is" .. tostring(DynamicEvents.currController))
	Script.SetTimer(2000, function()
        DynamicEvents.start()
		--pass entity current controller to start function
    end)
	
    System.LogAlways("$5 Started dynamicevents")
end

function DynamicEvents.start()
    local success, errorOrResult = pcall(function()
        System.LogAlways("Executing EventController:start()")
        math.randomseed(os.time())
        System.LogAlways("math randomseed done")

        DynamicEvents.Update(currController)
		-- pass entity current controller between start and update

        System.LogAlways("FL AMBUSHES AND SKIRMISHES MOD STARTED")
    end)

    if not success then
        System.LogAlways("Error in DynamicEvents.start: " .. tostring(errorOrResult))
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
	                  	
	
	Script.SetTimer(7000, function()
        DynamicEvents.Update(currController)
    end)																		
																			
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

function DynamicEvents.create()
    local spawnParams = {}
    spawnParams.class = "EventController"
    spawnParams.orientation = { x = 0, y = 0, z = 1 }
    spawnParams.properties = {}
    spawnParams.name = DynamicEvents.cUniqueIdName
    local entity = System.SpawnEntity(spawnParams)
    System.LogAlways("$5 [EventController] has been successfully created.")
    DynamicEvents.currController = entity		
end

System.AddCCommand("dynamicevents_uninstall", "DynamicEvents.uninstall()", "[Debug] test follower")
System.AddCCommand("dynamicevents", "DynamicEvents.create()", "[Debug] test follower")
System.AddCCommand("dynamicevents_kill", "DynamicEvents.endearly()", "[Debug] test follower")
System.AddCCommand("dynamicevents_clearcamp", "DynamicEvents.clearcamp()", "[Debug] test follower")
