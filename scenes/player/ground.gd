extends State

var player: Player
var dash_stamina: float = 300
@export var stamina_revovery_per_secound: float = 100


func _on_dash_stamina_timer_timout():
	print("+")

func _start():
	player = state.node

func set_data_ui() -> void:
	player.hud.set_progress_bar(dash_stamina, player.stamina)
	

func _update():
	if dash_stamina >= 300:
		dash_stamina = 300
	else:
		dash_stamina += stamina_revovery_per_secound * get_physics_process_delta_time()
		set_data_ui()
	
	

	

	player.allow_movement_control()	
	player.allow_weapon_control()
	player.show_hud_elements()
	
	if Input.is_action_just_pressed("dash") and dash_stamina > 100:
		dash_stamina -= 100
		set_data_ui()
		state.switch_state("dash")
	
	if Input.is_action_just_pressed("build"):
		state.switch_state("build")
