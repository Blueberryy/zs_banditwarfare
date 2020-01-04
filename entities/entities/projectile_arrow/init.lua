AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')
ENT.Damage = 100

function ENT:Initialize()
	self.Touched = {}
	self.Damaged = {}

	self:SetModel("models/Items/CrossbowRounds.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetTrigger(true)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)

	self:Fire("kill", "", 15)
	self:EmitSound("weapons/crossbow/bolt_fly4.wav")
end

local temp_pen_ents = {}
local temp_me = NULL
local myteammates = {}
function ENT:PenUpdate(ent)
	if ent == temp_me or temp_pen_ents[ent] or table.HasValue(myteammates,ent) then
		return false
	end

	return true
end

function ENT:PhysicsUpdate(phys)
	local vel = self.PreVel or phys:GetVelocity()
	if self.PreVel then self.PreVel = nil end

	temp_me = self
	temp_pen_ents = {}
	myteammates = self.Owner:IsPlayer() and team.GetPlayers(self.Owner:Team()) or {}
	for i = 1, 5 do
		if not self.NoColl then
			local velnorm = vel:GetNormalized()

			local ahead = (vel:LengthSqr() * FrameTime()) / 1200
			local fwd = velnorm * ahead
			local start = self:GetPos() - fwd
			local side = vel:Angle():Right() * 5

			local proj_trace = {mask = MASK_SHOT, filter = self.PenUpdate}

			proj_trace.start = start - side
			proj_trace.endpos = start - side + fwd

			local tr = util.TraceLine(proj_trace)

			proj_trace.start = start + side
			proj_trace.endpos = start + side + fwd

			local tr2 = util.TraceLine(proj_trace)
			local trs = {tr, tr2}

			for _, trace in pairs(trs) do
				if trace.Hit and not self.Touched[trace.Entity] then
					local ent = trace.Entity
					if ent ~= owner and (ent:IsPlayer() and ent:Team() ~= self.Team and ent:Alive()) then
						self.Touched[trace.Entity] = trace
						temp_pen_ents[trace.Entity] = true
					end

					break
				end
			end
		end
	end
end

function ENT:Think()
	-- Do this out of the physics collide hook.

	if self.Done and not self.NoColl then
		local data = self.PhysicsData
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:EnableMotion(false)
		end

		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		self:SetPos(data.HitPos)
		self:SetAngles(data.HitNormal:Angle())

		if self.ParentEnt then
			self:SetParent(self.ParentEnt)
		end
		self.NoColl = true
	end

	self:NextThink(CurTime())

	local owner = self:GetOwner()
	if not owner:IsValid() then owner = self end

	for ent, tr in pairs(self.Touched) do
		if not self.Damaged[ent] then
			self.Damaged[ent] = true

			local damage = (self.Damage or 100) / (table.Count(self.Damaged) ^ 0.13)

			ent:TakeDamage(damage, owner, self)
			ent:EmitSound("weapons/crossbow/hitbod"..math.random(2)..".wav")
			util.Blood(ent:WorldSpaceCenter(), math.max(0, 30 - table.Count(self.Damaged) * 2), -self:GetForward(), math.Rand(100, 300), true)

		end
	end
	return true
end

function ENT:PhysicsCollide(data, phys)
	if self.Done then return end
	self.Done = true
	self.PhysicsData = data

	self:Fire("kill", "", 6)
	self:EmitSound("physics/metal/sawblade_stick"..math.random(3)..".wav", 75, 60)

	local hitent = data.HitEntity
	if hitent and hitent:IsValid() then
		local hitphys = hitent:GetPhysicsObject()
		if hitphys:IsValid() and hitphys:IsMoveable() then
			self:SetParent(hitent)
		end
	end
end