class_name RifleInterface extends ActionInterface

var Fire_Timer : Timer
var Raycaster : RayCast3D

var Fire_Rate : float
var Current_Magazine : int


func _init(_Data : BaseItem, _Manager : Item_Manager):
	Data = _Data
	Manager = _Manager
	Current_Magazine = Data.Ammo_Capacity

func Connect_Nodes():
	print("Gun Interface Connected")
	Raycaster = Manager.Raycaster
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

func Action_4():
	if Busy: return

func Fire():
	if Current_Magazine > 0:
		PlayFireSound()
		Current_Magazine -= 1
		Fire_Timer.start()
		Animator.seek(0)
		Animator.play("Fire")
		print(Current_Magazine)
		#raycaster.force_raycast_update()

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
