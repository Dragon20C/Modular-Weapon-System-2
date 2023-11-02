class_name GunInterface extends ObjectInterface


var Fire_Timer : Timer
var Raycaster : RayCast3D
var Bullet_Scene : PackedScene
var Fire_Rate : float
var Current_Magazine : int

enum ADS_States {Into,Out,ADS,Idle}
var ADS_State = ADS_States.Idle
var Aiming : bool = false

func _init(_Data : ObjectData, _Manager : WeaponManager):
	Data = _Data
	Manager = _Manager
	Current_Magazine = Data.Ammo_Capacity

func Connect_Nodes():
	print("Gun Interface Connected")
	Raycaster = Manager.View_Node.get_child(0).get_child(0).get_node("Ray")
	Bullet_Scene = Manager.Bullet_Instace
	print(Raycaster)
	Fire_Timer = Manager.Weapon_Timer
	Fire_Rate = 1.0 / (Data.RPM / 60.0)
	Fire_Timer.wait_time = Fire_Rate
	Animator = Manager.View_Node.get_child(0).get_node("Animations")
	AudioPlayer = Manager.Audio_Emitter

# These functions is used to add input for the specific action
# example if this was a gun action it would have reload and shoot
func Action_1():
	if Busy: return
	
	if Data.action_type == 1:
		if Input.is_action_pressed("left_click") and Fire_Timer.is_stopped():
			Fire()
	elif  Data.action_type == 2:
		if Input.is_action_just_pressed("left_click") and Fire_Timer.is_stopped():
			Fire()

	
func Action_2():
	if Busy: return
	
	if Input.is_action_just_pressed("r_key"):
		Reload()

func Action_3():
	if Busy: return
	
	if Input.is_action_pressed("right_click"):
		Aiming = true
	else:
		Aiming = false
		
	match  ADS_State:
		ADS_States.Into:
			Manager.View_Animator.play("Aim")
			await Manager.View_Animator.animation_finished
			ADS_State = ADS_States.ADS
		ADS_States.Out:
			Manager.View_Animator.play_backwards("Aim")
			await Manager.View_Animator.animation_finished
			ADS_State = ADS_States.Idle
		ADS_States.ADS:
			if !Aiming:
				ADS_State = ADS_States.Out
		ADS_States.Idle:
			if Aiming:
				ADS_State = ADS_States.Into
				
	
	
	

func Action_4():
	if Busy: return

func Fire():
	if Current_Magazine > 0:
		Instance_Bullet()
		PlayFireSound()
		Current_Magazine -= 1
		Fire_Timer.start()
		Animator.seek(0)
		Animator.play("Fire")
		print(Current_Magazine)

func PlayFireSound():
	if AudioPlayer.stream != Data.Audio["Fire"]:
		AudioPlayer.stream = Data.Audio["Fire"]
	AudioPlayer.play()

func Reload():
	Busy = true
	if Current_Magazine == Data.Ammo_Capacity:
		Busy = false
		return
	print("reloading!")
	Animator.play("Reload")
	await Animator.animation_finished
	replenish_ammo()
	Busy = false

func replenish_ammo():
	print("reload finished!")
	Current_Magazine = Data.Ammo_Capacity

func Instance_Bullet():
	var instance = Bullet_Scene.instantiate()
	instance.position = Raycaster.global_position
	instance.transform.basis = Raycaster.global_transform.basis
	Manager.get_tree().get_root().add_child(instance)
	#Manager.get_parent().get_parent().add_child(instance)
