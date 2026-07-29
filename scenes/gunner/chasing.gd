extends State


var enemy: Gunner

func get_player() -> Player:
	var player_node: Player = get_tree().get_first_node_in_group("player")
	return player_node


var player: Player

func _start():
	enemy = state.node
	player = get_player()
	enemy.arm.rotation_degrees = 0

func get_next_direction() -> Vector2:
	var direction := (enemy.navigator.get_next_path_position() - enemy.global_position).normalized()
	return direction

func go_to(target: Vector2, speed: float) -> void:
	enemy.navigator.target_position = target
	var velocity_direction := (enemy.navigator.get_next_path_position() - enemy.global_position).normalized()
	enemy.velocity = velocity_direction * speed

func _update() -> void:
	if !player:
		return
	var direction = get_next_direction()
	if direction.x < 0:
		enemy.transform.x = Vector2(-1, 0)
	elif direction.x > 0:
		enemy.transform.x = Vector2(1, 0)
	
	if direction:
		enemy.animation.play(&"movement/walk")
		
	
	go_to(player.global_position, enemy.SPEED)
	if enemy.navigator.distance_to_target() < enemy.shooting_radius:
		state.switch_state("shooting")
