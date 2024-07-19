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
	self.SNDTurret:SetSoundLevel( 100 )
	self.SNDTurret:SetParent( self, ID )

	self:AddEngine( Vector(-75,0,80), Angle(0,-90,0) )
	self:AddFuelTank( Vector(-110,0,80), Angle(0,0,0), 1000, LVS.FUELTYPE_PETROL )

	//FRONT ARMOR
	self:AddArmor( Vector(100,0,40), Angle( 0,0,0 ), Vector(-25,-40,-15), Vector(30,40,40), 1000, self.FrontArmor )

	//LEFT ARMOR
	self:AddArmor( Vector(15,50,55), Angle( 0,0,0 ), Vector(-130,-5,0), Vector(70,5,25), 900, self.SideArmor )

	//RIGHT ARMOR
	self:AddArmor( Vector(15,-50,55), Angle( 0,0,0 ), Vector(-130,-5,0), Vector(70,5,25), 900, self.SideArmor )

	//BACK ARMOR
	self:AddArmor( Vector(-130,0,40), Angle( 0,0,0 ), Vector(-15,-50,-15), Vector(15,50,40), 800, self.BackArmor )


	//TURRET ARMOR
	local TurretArmor = self:AddArmor( Vector(0,-2.5,75), Angle(0,0,0), Vector(-55,-57,0), Vector(65,57,75), 2000, self.TurretArmor )
	TurretArmor.OnDestroyed = function( ent, dmginfo ) if not IsValid( self ) then return end self:SetTurretDestroyed( true ) end
	TurretArmor.OnRepaired = function( ent ) if not IsValid( self ) then return end self:SetTurretDestroyed( false ) end
	TurretArmor:SetLabel( "Turret" )
	self:SetTurretArmor( TurretArmor )

	self:AddTrailerHitch( Vector(-129,0,40), LVS.HITCHTYPE_MALE )
end
