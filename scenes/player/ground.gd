extends State

var player: Player

func _start():
	player = state.node

func _update():
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
	
	if Input.is_action_just_pressed("dash"):
		state.switch_state("dash")
