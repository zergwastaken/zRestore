AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("OpenRestoreMenu")

health_restore_models = {
	"models/Humans/Group03m/Female_01.mdl",
	"models/Humans/Group03m/Female_02.mdl",
	"models/Humans/Group03m/Female_03.mdl",
	"models/Humans/Group03m/Female_04.mdl",
	"models/Humans/Group03m/Female_06.mdl",
	"models/Humans/Group03m/Female_07.mdl",
	"models/Humans/Group03m/Male_01.mdl",
	"models/Humans/Group03m/male_02.mdl",
	"models/Humans/Group03m/male_03.mdl",
	"models/Humans/Group03m/Male_04.mdl",
	"models/Humans/Group03m/Male_05.mdl",
	"models/Humans/Group03m/male_06.mdl",
	"models/Humans/Group03m/male_07.mdl",
	"models/Humans/Group03m/male_08.mdl",
	"models/Humans/Group03m/male_09.mdl",
}


function ENT:Initialize()
	if restore_npc_model != "" then
		hehe_models = restore_npc_model 
	else 
		hehe_models = table.Random(health_restore_models)
	end

	self:SetModel(hehe_models)
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	
	self:SetMaxYawSpeed(90)
end

function ENT:Use(activator, caller)
    if not activator:IsPlayer() then return end
    if activator.CantUse then return end
    activator.CantUse = true
    timer.Simple(1, function() activator.CantUse = false end)
    net.Start("OpenRestoreMenu")
    net.Send(activator)
end
