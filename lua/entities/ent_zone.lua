AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName = "Cube"
ENT.Spawnable = true

ENT.Mins = Vector( -16, -16, -16 )
ENT.Maxs = Vector(	16,	16,	16 )

function ENT:Initialize()
	self.PhysCollide = CreatePhysCollideBox( self.Mins, self.Maxs )
	self:SetCollisionBounds( self.Mins, self.Maxs )

	if SERVER then
		self:PhysicsInitBox( self.Mins, self.Maxs )
		self:SetSolid( SOLID_VPHYSICS )
		self:PhysWake()
	end

	if CLIENT then
		self:SetRenderBounds( self.Mins, self.Maxs )
	end

	self:EnableCustomCollisions( true )
	self:DrawShadow( false )
end

-- Handles collisions against traces. This includes player movement.
function ENT:TestCollision( startpos, delta, isbox, extents )
	if not IsValid( self.PhysCollide ) then
		return
	end

	-- TraceBox expects the trace to begin at the center of the box, but TestCollision is bad
	local max = extents
	local min = -extents
	max.z = max.z - min.z
	min.z = 0

	local hit, norm, frac = self.PhysCollide:TraceBox( self:GetPos(), self:GetAngles(), startpos, startpos + delta, min, max )

	if not hit then
		return
	end

	return {
		HitPos = hit,
		Normal = norm,
		Fraction = frac,
	 }

end

function ENT:Draw()
	render.DrawWireframeBox( self:GetPos(), self:GetAngles(), self.Mins, self.Maxs, Color( 255, 0, 0 ), true )
end

list.Set( "ENT", "ent_zone", {
	Name = "Cube",
	Class = "ent_zone"
} )