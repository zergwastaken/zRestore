

local restore_npc_background = Color(45, 45, 45)
local frame_accent = Color(50, 50, 50)
local restore_header_background = Color(60, 60, 60)
local frame_health_col = Color(255, 100, 100)
local frame_armor_col = Color(100, 100, 255)

surface.CreateFont("restore_header_font", {font = "Circular Std Bold", size = 40})

surface.CreateFont("CLOSE_BUTTON", {font = "Circular Std Bold", size = 50})

surface.CreateFont("purchase_font", {font = "Circular Std Bold", size = 20})

surface.CreateFont("hp_ar", {font = "Circular Std Bold", size = 25})

local zrestore_purchase_text = ""


local ply = LocalPlayer()

local scrw, scrh = ScrW(), ScrH()

function RestoreMenu()


	if not LocalPlayer():Alive() then return false end
	if IsValid(hp_restore) then return end


	local hp_restore = vgui.Create("DFrame")
	hp_restore:SetSize(600, scrh / 2)
	hp_restore:MakePopup()
	hp_restore:Center()
	hp_restore:SetTitle("")
	hp_restore:SetDraggable(false)
	hp_restore:ShowCloseButton(false)

	hp_restore.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, restore_npc_background )
		draw.RoundedBox(0, 0, 0, w, 40, restore_header_background )
		if servername != "" then
			draw.SimpleText(servername .. " | Health Restore", "restore_header_font", 10, 0 , Color( 255, 255, 255 ), TEXT_ALIGN_LEFT)
		else 
			draw.SimpleText( "Health Restore", "restore_header_font", 10, 0 , Color( 255, 255, 255 ), TEXT_ALIGN_LEFT)
		end
	end
	local Party_CloseButton = vgui.Create("DButton", hp_restore)
	Party_CloseButton:SetSize(40,40)
	Party_CloseButton:SetPos(hp_restore:GetWide() - 40, 0)
	Party_CloseButton:SetText("")
	Party_CloseButton.Paint = function(self, w, h)
		if self:IsHovered() then
			draw.SimpleText("⨉", "CLOSE_BUTTON", w / 2, - 10 , Color( 255, 100, 100 ), TEXT_ALIGN_CENTER)
		else
			draw.SimpleText("⨉", "CLOSE_BUTTON", w / 2, - 10 , Color( 255, 255, 255 ), TEXT_ALIGN_CENTER)
		end
	end
	function Party_CloseButton:DoClick()
		hp_restore:Remove()
	end

	local tab_w, tabh = hp_restore:GetWide() - 10, 100

	local hp_w = hp_restore:GetWide() - tabh - 30


	if restore_player_tab then
		local ply_tab = vgui.Create( "DPanel", hp_restore)
		ply_tab:SetSize( tab_w, tabh)
		ply_tab:Dock(TOP)
		ply_tab:DockMargin(0,20,0,0)
		ply_tab.Paint = function(self, w, h)
	    	draw.RoundedBox(0, 0, 0, w, h, restore_header_background )
	    	draw.RoundedBox(0, 0, 0, ply_tab:GetTall(), ply_tab:GetTall(), frame_accent )
	    	draw.SimpleText( LocalPlayer():Nick(), "restore_header_font", ply_tab:GetTall() + 10 , 0 , Color( 255, 255, 255 ), TEXT_ALIGN_LEFT)

			draw.RoundedBox(5, tabh + 10, 50 , hp_w, 10, frame_accent)
			draw.RoundedBox(5, tabh + 10, 50 , math.min(LocalPlayer():Health() / LocalPlayer():GetMaxHealth() * hp_w , hp_w ), 10, frame_health_col)
	        draw.SimpleText( "Health: " .. LocalPlayer():Health(), "hp_ar", ply_tab:GetTall() + 10 , 35 , Color( 255, 255, 255 ), TEXT_ALIGN_LEFT)


			draw.RoundedBox(5, tabh + 10, 80 , hp_w, 10, frame_accent)
			draw.RoundedBox(5, tabh + 10, 80 , math.min(LocalPlayer():Armor() / LocalPlayer():GetMaxArmor() * hp_w , hp_w ), 10, frame_armor_col)
	    	draw.SimpleText( "Armor: " .. LocalPlayer():Armor(), "hp_ar", ply_tab:GetTall() + 10 , 65 , Color( 255, 255, 255 ), TEXT_ALIGN_LEFT)
		end

		local ply_model = vgui.Create( "DModelPanel", ply_tab)
		ply_model:SetSize(tabh - 10, tabh - 10)
		ply_model:SetPos( 5, 5)
		ply_model:SetModel(LocalPlayer():GetModel())
		function ply_model:LayoutEntity( Entity ) return end

		local headpos = ply_model.Entity:GetBonePosition(ply_model.Entity:LookupBone("ValveBiped.Bip01_Head1"))
		ply_model:SetLookAt(headpos)

		ply_model:SetCamPos(headpos-Vector(-15, 0, 0))

		ply_model.Entity:SetEyeTarget(headpos-Vector(-15, 0, 0))
	end

	for i = 1, table.Count(Restore_Person) do

		local purchase_tab = vgui.Create( "DPanel", hp_restore)
		purchase_tab:SetSize( tab_w, tabh)
		purchase_tab:Dock(TOP)
		if restore_player_tab then
			purchase_tab:DockMargin(0,10,0,0)
		else
			purchase_tab:DockMargin(0,20,0,0)
		end
		purchase_tab.Paint = function(self, w, h)

	    	draw.RoundedBox(0, 0, 0, w, h, restore_header_background )
	    	draw.RoundedBox(0, 0, 0, purchase_tab:GetTall(), purchase_tab:GetTall(), frame_accent )
    		draw.SimpleText(Restore_Person[i].Name, "restore_header_font", tabh + 10 , 0 , Color( 255, 255, 255 ), TEXT_ALIGN_LEFT)
    		draw.SimpleText(Restore_Person[i].desc, "hp_ar", tabh + 10 , 30 , Color( 255, 255, 255 ), TEXT_ALIGN_LEFT)
    		if restore_npc_darkrp then
    			draw.SimpleText( "Price: " .. Restore_Person[i].price, "hp_ar", tabh + 10 , 50 , Color( 255, 255, 255 ), TEXT_ALIGN_LEFT)
    		end


	        surface.SetDrawColor(255,255,255, 255)
	        surface.SetMaterial(Restore_Person[i].Icon)
	        surface.DrawTexturedRect( 5, 5, tabh - 10, tabh - 10)

		end

		if restore_npc_darkrp then
			zrestore_purchase_text = "PURCHASE"
		else
			zrestore_purchase_text = "GIVE"
		end

		surface.SetFont("purchase_font")
		local blank_w, blank_h = surface.GetTextSize(zrestore_purchase_text)


		local purchase_button = vgui.Create( "DButton", purchase_tab)
		purchase_button:SetSize(tabh - 10, tabh - 10)
		purchase_button:SetPos(tab_w - tabh + 5, 5)
		purchase_button:SetText("")
		purchase_button.Paint = function(self, w, h)
	    	draw.RoundedBox(5, 0, 0, w, h, frame_accent )
    			draw.SimpleText(zrestore_purchase_text, "purchase_font", w /2 , h/2 - blank_h / 2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER)
	    	if purchase_button:IsHovered() then
	    		draw.RoundedBox(5, 0, 0, w, h, Color(0, 0, 0, 100) )
	    	end
		end

		function purchase_button:DoClick()
			net.Start("give_full_health")
			net.WriteInt(i, 32)
			net.SendToServer()
		end
	end

end

net.Receive("OpenRestoreMenu", function(len) RestoreMenu() end)
