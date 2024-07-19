
include("entities/lvs_tank_wheeldrive/modules/cl_tankview.lua")

function ENT:TankViewOverride( ply, pos, angles, fov, pod )
	if ply == self:GetDriver() and not pod:GetThirdPersonMode() then
		local ID = self:LookupAttachment( "muzzle_cannon" )

		local Muzzle = self:GetAttachment( ID )

		if Muzzle then
			pos =  Muzzle.Pos - Muzzle.Ang:Up() * 12 - Muzzle.Ang:Forward() * -30 - Muzzle.Ang:Right() * 5
		end

	end

	return pos, angles, fov
end

function ENT:CalcViewPassenger( ply, pos, angles, fov, pod )
	if pod == self:GetGunnerSeat() and not pod:GetThirdPersonMode() then
		local ID = self:LookupAttachment( "turret" )

		local Muzzle = self:GetAttachment( ID )

		if Muzzle then
			pos =  Muzzle.Pos - Muzzle.Ang:Up() * 0 - Muzzle.Ang:Forward() * -15 - Muzzle.Ang:Right() * 38
		end
	end

	return LVS:CalcView( self, ply, pos, angles, fov, pod )
end