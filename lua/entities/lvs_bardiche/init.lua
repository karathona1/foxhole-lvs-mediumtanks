AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "sh_turret.lua" )
AddCSLuaFile( "sh_tracks.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_optics.lua" )
AddCSLuaFile( "cl_tankview.lua" )
include("shared.lua")
include("sh_turret.lua")
include("sh_tracks.lua")


function ENT:OnSpawn( PObj )
	local DriverSeat = self:AddDriverSeat( Vector(10,0,20), Angle(0,-90,0) )
	DriverSeat.HidePlayer = true

	local GunnerSeat = self:AddPassengerSeat( Vector(10,0,50), Angle(0,-90,0) )
	GunnerSeat.HidePlayer = false
	self:SetGunnerSeat( GunnerSeat )

	local ID = self:LookupAttachment( "muzzle_end" )
	local Muzzle = self:GetAttachment( ID )
	self.SNDTurret = self:AddSoundEmitter( self:WorldToLocal( Muzzle.Pos ), "vehicles/LightTankColonialShot01.wav", "vehicles/LightTankColonialShot02.wav" )
	self.SNDTurret:SetSoundLevel( 95 )
	self.SNDTurret:SetParent( self, ID )

	self:AddEngine( Vector(-84,0,85), Angle(0,-90,0) )
	self:AddFuelTank( Vector(-150,0,50), Angle(0,0,0), 1000, LVS.FUELTYPE_PETROL )

	//FRONT ARMOR
	self:AddArmor( Vector(100,0,55), Angle( -50,0,0 ), Vector(-10,-60,-35), Vector(20,60,35), 1250, self.FrontArmor )

	//LEFT ARMOR
	self:AddArmor( Vector(5,60,55), Angle( 0,0,0 ), Vector(-130,-5,0), Vector(70,5,35), 1000, self.SideArmor )

	//RIGHT ARMOR
	self:AddArmor( Vector(5,-63,55), Angle( 0,0,0 ), Vector(-130,-5,0), Vector(70,5,35), 1000, self.SideArmor )

	//BACK ARMOR
	self:AddArmor( Vector(-140,0,40), Angle( 0,0,0 ), Vector(-15,-50,-15), Vector(15,50,45), 1000, self.BackArmor )


	//TURRET ARMOR
	local TurretArmor = self:AddArmor( Vector(5,-2.5,75), Angle(0,0,0), Vector(-45,-45,0), Vector(55,45,45), 2000, self.TurretArmor )
	TurretArmor.OnDestroyed = function( ent, dmginfo ) if not IsValid( self ) then return end self:SetTurretDestroyed( true ) end
	TurretArmor.OnRepaired = function( ent ) if not IsValid( self ) then return end self:SetTurretDestroyed( false ) end
	TurretArmor:SetLabel( "Turret" )
	self:SetTurretArmor( TurretArmor )
end

-- set material on death
function ENT:OnDestroyed()
	self:SetMaterial("props/metal_damaged")
end
