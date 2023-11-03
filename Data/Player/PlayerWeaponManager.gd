extends WeaponManager


@export_group("Extras")
@export var Weapon_Timer : Timer
@onready var Bullet_Instace : PackedScene = preload("res://Data/Scenes/bullet.tscn")


var System : WeaponSystem

func _input(event):
	System.SwitchInput(event)


func _ready():
	LinkStation.Weapon_Manager = self
	System = WeaponSystem.new(View_Node, View_Animator)
	setup()
	System.start()

func setup():
	var AK47 = GunInterface.new(Object_Data.get("AK47"),self)
	var Remington = GunInterface.new(Object_Data.get("Remington"),self)
	
	System.Add_Weapon(AK47)
	System.Add_Weapon(Remington)


# Input should be handled outside of the system since functions like phyisc/process
# no longer work when setup like this

func _physics_process(delta):
	System.Update()
