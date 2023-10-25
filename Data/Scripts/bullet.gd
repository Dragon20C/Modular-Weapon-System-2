class_name Bullet extends Node3D

const SPEED : float = 40.0
@onready var Ray : RayCast3D = get_node("RayCast3D")

func _process(delta):
	position += transform.basis * Vector3(0,0, - SPEED) * delta
	
	if Ray.is_colliding():
		queue_free()

func _on_timer_timeout():
	queue_free()
