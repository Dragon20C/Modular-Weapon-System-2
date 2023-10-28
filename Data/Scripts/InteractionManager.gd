class_name InteractionManager extends Node


@export var Raycast : RayCast3D

func _process(delta):
	if Input.is_action_just_pressed("e_key"):
		if Raycast.is_colliding() and Raycast.get_collider() is Interaction:
			Raycast.get_collider().Interact()
			print("Interacted!")


	
