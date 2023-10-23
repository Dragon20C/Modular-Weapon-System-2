class_name Item_Manager extends Node

@export_category("Defualt")
@export var View_Node : Node3D
@export var View_Animator : AnimationPlayer
@export var Audio_Emitter : AudioStreamPlayer3D
@export var Item_Data : Dictionary
@export_group("Extras")
@export var Raycaster : RayCast3D
@export var Weapon_Timer : Timer

var System : Item_System

func _input(event):
	System.SwitchInput(event)


func _ready():
	System = Item_System.new(View_Node, View_Animator)
	setup()
	System.start()

func setup():
	# Add ActionInterfaces here and we should add it to the system
	var ak47 = RifleInterface.new(Item_Data.get("Ak_47"),self)
	var M1911 = RifleInterface.new(Item_Data.get("M1911"),self)
	
	System.Add_Item(ak47)
	System.Add_Item(M1911)

# Input should be handled outside of the system since functions like phyisc/process
# no longer work when setup like this

func _physics_process(delta):
	System.Update()
