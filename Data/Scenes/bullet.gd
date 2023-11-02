class_name Bullet extends Node3D

const SPEED : float = 40.0
@onready var Ray : RayCast3D = get_node("RayCast3D")
@onready var BulletDecal : PackedScene = preload("res://Data/Scenes/BulletHoleDecal.tscn")

func _process(delta):
	position += transform.basis * Vector3(0,0, - SPEED) * delta
	
	if Ray.is_colliding():
		spawn_decal(Ray.get_collision_point(),Ray.get_collision_normal())
		queue_free()

func _on_timer_timeout():
	queue_free()

func spawn_decal(position: Vector3, normal: Vector3):
	var decal = BulletDecal.instantiate()
	get_tree().get_root().add_child(decal)
	decal.global_transform.origin = position
	
	# Check if normal is not down or up then we do look at
	if normal != Vector3.UP and normal != Vector3.DOWN:
		decal.look_at(position + normal,Vector3.UP)
		decal.transform = decal.transform.rotated_local(Vector3.RIGHT, PI/2.0)
	# Else we check if its up and we do a 180 to get it to rotate correctly!
	elif normal == Vector3.UP:
		decal.transform = decal.transform.rotated_local(Vector3.RIGHT, PI)
		
	decal.rotate(normal, randf_range(0, 2*PI))
	
	get_tree().create_timer(10).timeout.connect(func destory_decal(): decal.queue_free())
