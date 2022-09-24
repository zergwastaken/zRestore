util.AddNetworkString("give_full_health")
util.AddNetworkString("give_full_armor")

net.Receive("give_full_health", function(len, ply)

	local id = net.ReadInt(32)
	local itemData = Restore_Person[id]
	if not itemData then return end


	if restore_npc_darkrp then

		local canAfford = ply:canAfford(itemData.price)
		if not canAfford then
			ply:ChatPrint("You can't afford this item!")
			ply:EmitSound("player/suit_denydevice.wav", 75, 100)
			return
		end

		if servername != "" then
			if itemData.Name == "Health" then
				if ply:Health() == ply:GetMaxHealth() then
		    		ply:ChatPrint( servername .. " | You already have max health, silly.")
					ply:EmitSound("player/suit_denydevice.wav", 75, 100)
				else
					ply:SetHealth( ply:GetMaxHealth() )
					ply:EmitSound("items/medshot4.wav", 75, 100)
		    		ply:ChatPrint( servername .. " | Your health has been healed!")
		    		ply:addMoney(-itemData.price)
		    	end
			elseif itemData.Name == "Armor" then
				if ply:Armor() == ply:GetMaxArmor() then
		    		ply:ChatPrint( servername .. " | You already have max armor, silly.")
					ply:EmitSound("player/suit_denydevice.wav", 75, 100)
				else
					ply:SetArmor( ply:GetMaxArmor() )
					ply:EmitSound("items/suitchargeno1.wav", 75, 100)
			    	ply:ChatPrint( servername .. " | You now have max armor.")
			    	ply:addMoney(-itemData.price)
			    end
			end
		else
			if itemData.Name == "Health" then
				if ply:Health() == ply:GetMaxHealth() then
		    		ply:ChatPrint( "You already have max health, silly.")
					ply:EmitSound("player/suit_denydevice.wav", 75, 100)
				else
					ply:SetHealth( ply:GetMaxHealth() )
					ply:EmitSound("items/medshot4.wav", 75, 100)
		    		ply:ChatPrint("Your health has been healed!")
		    		ply:addMoney(-itemData.price)
		    	end
			elseif itemData.Name == "Armor" then
				if ply:Armor() == ply:GetMaxArmor() then
		    		ply:ChatPrint("You already have max armor, silly.")
					ply:EmitSound("player/suit_denydevice.wav", 75, 100)
				else
					ply:SetArmor( ply:GetMaxArmor() )
					ply:EmitSound("items/suitchargeno1.wav", 75, 100)
			    	ply:ChatPrint("You now have max armor.")
			    	ply:addMoney(-itemData.price)
			    end

			end
		end
	else
		if servername != "" then
			if itemData.Name == "Health" then
				if ply:Health() == ply:GetMaxHealth() then
		    		ply:ChatPrint( servername .. " | You already have max health, silly.")
					ply:EmitSound("player/suit_denydevice.wav", 75, 100)
				else
					ply:SetHealth( ply:GetMaxHealth() )
					ply:EmitSound("items/medshot4.wav", 75, 100)
		    		ply:ChatPrint( servername .. " | Your health has been healed!")
		    	end
			elseif itemData.Name == "Armor" then
				if ply:Armor() == ply:GetMaxArmor() then
		    		ply:ChatPrint( servername .. " | You already have max armor, silly.")
					ply:EmitSound("player/suit_denydevice.wav", 75, 100)
				else
					ply:SetArmor( ply:GetMaxArmor() )
					ply:EmitSound("items/suitchargeno1.wav", 75, 100)
			    	ply:ChatPrint( servername .. " | You now have max armor.")
			    end
			end
		else
			if itemData.Name == "Health" then
				if ply:Health() == ply:GetMaxHealth() then
		    		ply:ChatPrint( "You already have max health, silly.")
					ply:EmitSound("player/suit_denydevice.wav", 75, 100)
				else
					ply:SetHealth( ply:GetMaxHealth() )
					ply:EmitSound("items/medshot4.wav", 75, 100)
		    		ply:ChatPrint("Your health has been healed!")
		    	end
			elseif itemData.Name == "Armor" then
				if ply:Armor() == ply:GetMaxArmor() then
		    		ply:ChatPrint("You already have max armor, silly.")
					ply:EmitSound("player/suit_denydevice.wav", 75, 100)
				else
					ply:SetArmor( ply:GetMaxArmor() )
					ply:EmitSound("items/suitchargeno1.wav", 75, 100)
			    	ply:ChatPrint("You now have max armor.")
			    end

			end
		end
	end

end)
