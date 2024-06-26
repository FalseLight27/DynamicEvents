
function WarController:AssignActions(entity)
    entity.GetActions = function (user,firstFast)
        output = {}
        AddInteractorAction( output, firstFast, Action():hint("Start Battle"):action("use"):hintType( AHT_HOLD ):func(entity.OnStart):interaction(inr_talk))
        AddInteractorAction( output, firstFast, Action():hint("View Briefing"):action("use"):func(entity.OnBrief):interaction(inr_talk))
        AddInteractorAction( output, firstFast, Action():hint("View Scouting Information"):action("mount_horse"):func(entity.OnScout):interaction(inr_talk))
        AddInteractorAction( output, firstFast, Action():hint("Resolve battle without me"):action("mount_horse"):hintType( AHT_HOLD ):func(entity.Resolve):interaction(inr_talk))
        return output
    end
    entity.Properties.controller = self
    entity.OnStart = function (self, user)
        self.Properties.controller:StartBattle()
    end
    entity.OnBrief = function (self, user)
        self.Properties.controller:Brief()
    end
    entity.OnScout = function (self, user)
        self.Properties.controller:Scout()
    end
    entity.Resolve = function (self, user)
        self.Properties.controller:OffScreenBattle()
    end
end

--[==[

function WarController:AssignActionsLogiOfficer(entity)
    entity.GetActions = function (user,firstFast)
        output = {}
        AddInteractorAction( output, firstFast, Action():hint("Buy Extra Wave (150 Groschen)"):action("use"):func(entity.OnWave):interaction(inr_talk))
        AddInteractorAction( output, firstFast, Action():hint("Buy Archers (300 Groschen)"):action("use"):hintType( AHT_HOLD ):func(entity.OnArcher):interaction(inr_talk))
        AddInteractorAction( output, firstFast, Action():hint("Buy Halberdiers (300 Groschen)"):action("mount_horse"):func(entity.OnHalberd):interaction(inr_talk))
        return output
    end
    entity.Properties.controller = self
    entity.OnWave = function (self, user)
        if player.inventory:GetMoney() < 150 then
            Game.SendInfoText("You need 150 Groschen",false,nil,5)
        else
            RemoveMoneyFromInventory(player, 1500)
            Game.SendInfoText("Waves increased by 1",false,nil,5)
            self.Properties.controller.currentBattle.wavesleft = self.Properties.controller.currentBattle.wavesleft + 1
        end
    end
    entity.OnHalberd = function (self, user)
        if player.inventory:GetMoney() < 300 then
            Game.SendInfoText("You need 300 Groschen",false,nil,5)
        else
            RemoveMoneyFromInventory(player, 3000)
            Game.SendInfoText("Halberdiers per wave increased by 1",false,nil,5)
            self.Properties.controller.currentBattle.strengthPerWave[WarTroopTypes.halberd][WarConstants.rat_side] = self.Properties.controller.currentBattle.strengthPerWave[WarTroopTypes.halberd][WarConstants.rat_side] + 1
        end
    end
    entity.OnArcher = function (self, user)
        if player.inventory:GetMoney() < 300 then
            Game.SendInfoText("You need 300 Groschen",false,nil,5)
        else
            RemoveMoneyFromInventory(player, 3000)
            Game.SendInfoText("Archers per wave increased by 1",false,nil,5)
            self.Properties.controller.currentBattle.strengthPerWave[WarTroopTypes.bow][WarConstants.rat_side] = self.Properties.controller.currentBattle.strengthPerWave[WarTroopTypes.bow][WarConstants.rat_side] + 1
        end
    end
end

--]==]

function EventController:CreateSkirmish()
--(position, objective)
    --if self.marshal == nil then
        --local spawnParams = {}
        --spawnParams.class = "NPC"
        --spawnParams.orientation = { x = 0, y = 0, z = 0 }
        --local vec = { x = 2979.425, y = 801.855, z = 111.145 }
		
		-- EVENT 1: FORK IN FOREST ROAD SOUTH OF SASAU

		System.LogAlways("Checking for ideal skirmish conditions")
		
		--[==[
		local success, errorOrResult = pcall(function()
			
			System.LogAlways("$5 [EventController] has been successfully created.")
		end)

		if not success then
			System.LogAlways("Error in DynamicEvents.create: " .. tostring(errorOrResult))
			System.LogAlways("StackTrace: " .. debug.traceback(errorOrResult, 2))
		end
		--]==]
		
		if event1Dist > 4 and event1Dist < 30  and spawnChance <= 100
        -- if player is farther than 30 meters from Event center but no closer than 4 meters, spawnChance check will initiate
		-- eventually change this to a foreach
			
		local position1a = getrandomposnear(event1Rat, 5.0)
		local position2a = getrandomposnear(event1Rat, 5.0)
		local position3a = getrandomposnear(event1Rat, 5.0)
		
		local position1b = getrandomposnear(event1Cuman, 10.0)
		local position2b = getrandomposnear(event1Cuman, 10.0)
		local position3b = getrandomposnear(event1Cuman, 10.0)

        self.Spawn(EventConstants.rat_side, position1a, event1Center, EventTroopTypes.aux) -- PLANNED METHODOLOGY
        self.Spawn(EventConstants.rat_side, position2a, event1Center, EventTroopTypes.aux) -- enumerate positions
        self.Spawn(EventConstants.rat_side, position3a, event1Center, EventTroopTypes.aux) -- deliberately spawn troops on positions, skip the mumbo jumbo that base mod uses
		
		System.LogAlways("PLAYER IN ZONE: SPAWNED THREE RATTAY SWORDSMEN")
		
        self.Spawn(EventConstants.cuman_side, position1b, event1Center, EventTroopTypes.aux) -- start with one event location and adjust accordingly
        self.Spawn(EventConstants.cuman_side, position2b, event1Center, EventTroopTypes.aux) -- find out how the script calls its methods (maybe use ChatGPT; use original files)
        self.Spawn(EventConstants.cuman_side, position3b, event1Center, EventTroopTypes.aux) -- see if it'll work performantly if all spawns are just active all the time
		
		System.LogAlways("PLAYER IN ZONE: SPAWNED THREE CUMAN SWORDSMEN")
		
		System.LogAlways("SKIRMISH CREATED SUCCESSFULLY")
		
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

--[==[

function WarController:CreateLogiOfficer(position)
    if self.logiOfficer == nil then
        local spawnParams = {}
        spawnParams.class = "NPC"
        spawnParams.orientation = { x = 0, y = 0, z = 0 }
        local vec = {}
        vec.x = position.x + 1
        vec.y = position.y + 2
        vec.z = position.z
        spawnParams.position = vec
        spawnParams.properties = {}
        spawnParams.properties.sharedSoulGuid = "3c122d09-c4db-4673-989c-b9594427cd2e"
        spawnParams.name = "logiofficer"
        local entity = System.SpawnEntity(spawnParams)
        entity.lootable = false
        entity.AI.invulnerable = true
        self.logiOfficer = entity
        System.LogAlways("$5 Created Logi Officer")
        self:AssignActionsLogiOfficer(entity)
    end
end

function WarController:CreateWarCamp(position)
    local spawnParams = {}
    spawnParams.class = "BasicEntity"
    spawnParams.orientation = { x = 0, y = 0, z = 0 }
    local vec = {}
    vec.x = position.x + 0.3
    vec.y = position.y + 0.3
    vec.z = position.z
    spawnParams.name = "warcamp"
    spawnParams.position = vec
    spawnParams.properties = {}
    local modelPath = WarConstants.campMesh
    spawnParams.properties.object_Model = modelPath
    -- should be generated on load
    -- as this makes it easier to modify if needed
    spawnParams.properties.bSaved_by_game = 0
    
    local entity = System.SpawnEntity(spawnParams)
    self.warcamp = entity
end

--]==]
