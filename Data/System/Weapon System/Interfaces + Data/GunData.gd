class_name GunObject extends ObjectData

@export_group("Gun")
@export_enum("Automatic", "Semi-automatic", "Shotgun") var action_type: String
@export var Shotgun_Spread : float
@export var Ammo_Capacity : int
@export var Magazine_Max : int
@export var RPM : float
@export var Reload_Speed : float
