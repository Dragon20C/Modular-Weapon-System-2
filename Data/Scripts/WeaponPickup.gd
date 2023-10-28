extends Interaction

@export var Data : BaseItem
@export_enum("Rifle") var Type: String


func Weapon_pickup():
	print("Weapon Picked up")
	match Type:
		"Rifle":
			LinkStation.Weapon_Manager.System.Add_Item(RifleInterface.new(Data,LinkStation.Weapon_Manager))
			LinkStation.Weapon_Manager.System.Check()
			
	queue_free()

func Interact():
	Weapon_pickup()
