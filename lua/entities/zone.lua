--salut


AddCSLuaFile()
DEFINE_BASECLASS( "base_gmodentity" )

ENT.PrintName = "toolname"

function ENT:SetupDataTables()



end

function ENT:Initialize()

	if ( CLIENT ) then return end

	print( self )

end

function ENT:GetOverlayText()

	local txt = "salut mec"

	return txt

end

function ENT:OnTakeDamage( dmginfo )

end

function ENT:PhysicsSimulate( phys, deltatime )

end
