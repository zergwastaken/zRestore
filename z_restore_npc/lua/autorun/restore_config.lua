-- YOUR SERVER NAME GOES HERE
servername = "" -- leave this blank if you don't want it to show anything

-- MODEL YOU WANT FOR THE NPC
restore_npc_model = "" -- leave this blank if you want it to just be randomized through the default medic models

-- IF YOUR NOT USING DARKRP SET THIS TO FALSE AND IT WILL NOT CHARGE PLAYERS FOR GETTING THERE HEALTH AND ARMOR MAXED
restore_npc_darkrp = true -- set this to true if your using darkrp

-- SET THIS TO FALSE IF YOU DON'T WANT TO DISPLAY THE LOCALPLAYER TAB WHERE IT SHOWS UR CURRENT ARMOR / HEALTH
restore_player_tab = true 

-- SET THIS TO THE PRICE YOU WANT MAX HEALTH TO COST
restore_npc_health_price = "500"

-- SET THIS TO THE PRICE YOU WANT MAX ARMOR TO COST
restore_npc_armor_price = "1000"

--[[
Don't Change anything below unless you know what you're doing
well I mean be my guest I could care less if you mess it up.... :)
]]

Restore_Person = {}
Restore_Person[1] = {
	Name = "Health",
	desc = "Restores you back to max health",
	Icon = Material("materials/zerg/v2.png"),
	price = restore_npc_health_price
}

Restore_Person[2] = {
	Name = "Armor",
	desc = "Gives you max armor :)",
	Icon = Material("materials/zerg/v1.png"),
	price = restore_npc_armor_price
}