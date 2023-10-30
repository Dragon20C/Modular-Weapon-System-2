class_name Item_System extends Node


enum States {Connect,Exit,Disabled,Running,Hidden}
var State = States.Hidden

var view_model : Node3D
var view_animator : AnimationPlayer	

var Items : Array
var Current_Index : int = 0
var Current_Item : ActionInterface

func _init(_view_model : Node3D,_view_animator : AnimationPlayer):
	view_model = _view_model
	view_animator = _view_animator

func Add_Item(Item : ActionInterface):
	Items.append(Item)
	
func Remove_Item():
	pass

func start():
	if Items.size() > 0:
		Switch_Item(Items[Current_Index])
	else:
		State = States.Disabled

func SwitchInput(event):
	if event.is_action_pressed("scroll_up") and State == States.Running:
		Current_Index = min(Current_Index+1,Items.size()-1)
		Switch_Item(Items[Current_Index])

	elif event.is_action_pressed("scroll_down") and State == States.Running:
		Current_Index = max(Current_Index-1,0)
		Switch_Item(Items[Current_Index])

func Update():

	match State:
		# Have a state for unique retrival of nodes
		States.Connect:
			Current_Item.Connect_Nodes()
			State = States.Running
		# The running state so everything works
		States.Running:
			Current_Item.Action_1()
			Current_Item.Action_2()
			Current_Item.Action_3()
			Current_Item.Action_4()
		# A state to hide/ put away current item
		States.Hidden:
			pass
		# A state that when we want nothing to happen we switch to it
		States.Disabled:
			pass
	
func Switch_Item(Item : ActionInterface):
	if Item == null : return
	
	if Current_Item == Item : return
	State = States.Disabled
	
	if Current_Item != null:
		view_animator.play("Unequip")
		await view_animator.animation_finished
		view_model.get_child(0).queue_free()
	
	Current_Item = Item
	Instance_Item_Scene(Current_Item.Data.Scene)
	view_animator.play("Equip")
	await view_animator.animation_finished
	State = States.Connect

func Instance_Item_Scene(Item : PackedScene):
	var Scene = Item.instantiate()
	view_model.add_child(Scene)
	
func Check():
	if Items.size() > 0:
		Current_Index = min(Current_Index+1,Items.size()-1)
		Switch_Item(Items[Current_Index])
