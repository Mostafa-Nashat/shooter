extends State


var enemy: Enemy

func get_player() -> Player:
	var player_node: Player = get_tree().get_first_node_in_group("player")
	return player_node


var player: Player

func _start():
	enemy = state.node
	player = get_player()
	enemy.arm.visible = false
	enemy.arm.rotation_degrees = 0

func go_to(target: Vector2, speed: float) -> void:
	enemy.navigator.target_position = target
	var velocity_direction := (enemy.navigator.get_next_path_position() - enemy.global_position).normalized()
	enemy.velocity = velocity_direction * speed

func _update() -> void:
	if !player:
		return
	
	go_to(player.global_position, enemy.SPEED)
	if enemy.navigator.distance_to_target() < 80:
		state.switch_state("shooting")
