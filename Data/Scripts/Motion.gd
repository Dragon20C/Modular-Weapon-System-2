extends Node
@export_category("Motion Node")
@export_group("HeadBob State")
@export var enable_headbob : bool = true
@export var enable_stab : bool = true

@export_group("Values")
@export var Amplitude : float = 0.05
@export var Frequency : float = 2.5

@export_group("Nodes")
@export var Camera : Camera3D 
@export var Marker : Marker3D
@export var Player : CharacterBody3D
@export var feet_audio_player : AudioStreamPlayer3D

@export_group("Footstep")
var stepped : bool = false
@export var footstep_sounds : Array[AudioStreamWAV]

@export_group("View bobbing")
@export var enable_viewbobbing : bool = true
@export var ViewModel : Node3D
var view_time : float = 0.0
var effect_speed : float = 1.2
var effect_vertical : float = 0.02
var effect_hoizontal : float = 0.01

var time : float = 0.0

func _physics_process(delta):
		
	if enable_headbob:
		if Player.velocity.length() > 0 and Player.is_on_floor():
			time += delta * Player.velocity.length() * float(Player.is_on_floor())
			Camera.transform.origin = Camera.transform.origin.lerp(Motion(),15 * delta)
			#Camera.transform.origin = Motion()
			if enable_stab:
				Camera.look_at(Marker.global_position)
		else:
			RestartPosition(delta)
			
	if enable_viewbobbing:
		if Player.velocity.length() > 0 and Player.is_on_floor():
			view_time += delta * Player.velocity.length() * float(Player.is_on_floor())
			var y_axis = -abs(sin(view_time * effect_speed) * effect_vertical)
			var x_axis = cos(view_time * effect_speed / 2) * effect_hoizontal
			var vec = Vector3(x_axis,y_axis,0) 
			ViewModel.transform.origin = ViewModel.transform.origin.lerp(vec,15 * delta)
			#ViewModel.transform.origin.y = y_axis
			#ViewModel.transform.origin.x = x_axis
		else:
			RestartView(delta)
		
	

func Motion() -> Vector3:
	var Pos = Vector3.ZERO
	Pos.y += sin(time * Frequency) * Amplitude
	Pos.x += cos(time * Frequency / 2) * Amplitude * 2
	
	CanPlayFootStep(Pos.y)
	
	return Pos
	
func RestartPosition(delta):
	if Camera.transform.origin == Vector3.ZERO: return
	Camera.transform.origin = Camera.transform.origin.lerp(Vector3.ZERO,10 * delta)
	time = 0.0

func RestartView(delta):
	if ViewModel.transform.origin == Vector3.ZERO: return
	ViewModel.transform.origin = ViewModel.transform.origin.lerp(Vector3.ZERO,10 * delta)
	view_time = 0.0

func CanPlayFootStep(y_value : float):
	if y_value < 0 and !stepped:
		PlayFootStepSound()
		stepped = true
	elif y_value >0 and stepped:
		stepped = false

func PlayFootStepSound():
	var random_index : int = randi_range(0,footstep_sounds.size() - 1)
	feet_audio_player.stream = footstep_sounds[random_index]
	feet_audio_player.pitch_scale = randf_range(0.8,1.2)
	feet_audio_player.play()
