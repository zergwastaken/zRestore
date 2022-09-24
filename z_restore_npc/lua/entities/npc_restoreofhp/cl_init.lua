include("shared.lua")

surface.CreateFont("HEALTH_NPC", {font = "Circular Std Bold", size = 200})
local offset = Vector(0, 0, 80)

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:DrawTranslucent()
	self:DrawModel()

	local origin = self:GetPos()
	if (LocalPlayer():GetPos():Distance(origin) >= 768) then
		return end

	local pos = origin + offset
	local ang = (LocalPlayer():EyePos() - pos):Angle()
	ang.p = 0
	ang:RotateAroundAxis(ang:Right(), 90)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 180)

	local text = "Health / Armor"

	cam.Start3D2D(pos, ang, 0.03)
		surface.SetFont("HEALTH_NPC")
		local wi, he = surface.GetTextSize(text)
		local pad = 16
		wi = wi + pad * 2
		he = he + pad * 2

		draw.RoundedBox(8, -wi * 0.5, -pad, wi, he, Color(45, 45, 45))

		draw.SimpleText(text, "HEALTH_NPC", 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	cam.End3D2D()
end