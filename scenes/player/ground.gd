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
	
	var direction := Input.get_vector("left", "right", "front", "back").normalized()
	player.velocity = direction * player.SPEED
	
	if !player.sword or !player.sword.weapon or !player.sword.swing_animation.is_playing():
		player.arm.look_at_target(player.get_global_mouse_position(), player.MAX_HAND_SWING_SPEED)
	
	if direction.x < 0:
		player.transform.x = Vector2(-1, 0)
		player.camera.transform.x = Vector2(-1, 0)
	elif direction.x > 0:
		player.transform.x = Vector2(1, 0)
		player.camera.transform.x = Vector2(1, 0)
	
	player.allow_weapon_control()
	player.show_hud_elements()
	
	if Input.is_action_just_pressed("dash") and dash_stamina > 100:
		dash_stamina -= 100
		set_data_ui()
		state.switch_state("dash")
