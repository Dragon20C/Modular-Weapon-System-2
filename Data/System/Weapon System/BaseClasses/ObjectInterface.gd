class_name ObjectInterface extends Node

# Will have the manager set its self to the interfaces
var Manager : WeaponManager
# Weapon/item Data
var Data : ObjectData
# Sound player
var AudioPlayer : AudioStreamPlayer3D
# Animator
var Animator : AnimationPlayer
# A way to disable the action to avoid shooting and reloading at the same time
var Busy : bool = false

func _init(_Data : ObjectData, _Manager : WeaponManager):
	Data = _Data
	Manager = _Manager

# Functions for entering and exiting the interface.
# example witching weapons we want to play the animation for it.
func Connect_Nodes():
	print("Object Interface initialized")

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
