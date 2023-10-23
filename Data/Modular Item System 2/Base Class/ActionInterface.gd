class_name ActionInterface extends Node

# Will have the manager set its self to the interfaces
var Manager : Item_Manager
# Weapon/item Data
var Data : BaseItem
# Sound player
var AudioPlayer : AudioStreamPlayer3D
# Animator
var Animator : AnimationPlayer
# A way to disable the action to avoid shooting and reloading at the same time
var Busy : bool = false

func _init(_Data : BaseItem, _Manager : Item_Manager):
	Data = _Data
	Manager = _Manager

# Functions for entering and exiting the interface.
# example witching weapons we want to play the animation for it.
func On_init():
	print("Action Interface initialized")

# These functions is used to add input for the specific action
# example if this was a gun action it would have reload and shoot
func Action_1():
	if Busy: return

func Action_2():
	if Busy: return

func Action_3():
	if Busy: return

func Action_4():
	if Busy: return
