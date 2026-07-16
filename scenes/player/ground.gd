extends State

var player: Player

func _start():
	player = state.node

func _update():
	var direction := Input.get_vector("left", "right", "front", "back").normalized()
	player.velocity = direction * player.SPEED
	
	player.arm.look_at_target(player.get_global_mouse_position(), player.MAX_HAND_SWING_SPEED)
	
	if direction.x < 0:
		player.transform.x = Vector2(-1, 0)
		player.ui_manager.transform.x = Vector2(-1, 0)
	elif direction.x > 0:
		player.transform.x = Vector2(1, 0)
		player.ui_manager.transform.x = Vector2(1, 0)
	
	player.allow_weapon_control()
	
	if Input.is_action_just_pressed("dash"):
		state.switch_state("dash")
