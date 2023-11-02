extends Interaction

@export var Data : ObjectData
@export_enum("Rifle") var Type: String


func Weapon_pickup():
	print("Weapon Picked up")
	match Type:
		"Rifle":
			LinkStation.Weapon_Manager.System.Add_Weapon(GunInterface.new(Data,LinkStation.Weapon_Manager))
			LinkStation.Weapon_Manager.System.Check()
			
	queue_free()

func Interact():
	Weapon_pickup()
