extends State


var enemy: Enemy

func get_player() -> Player:
	var player_node: Player = get_tree().get_first_node_in_group("player")
	return player_node


var player: Player

func _start():
	enemy = state.node
	player = get_player()

func _update() -> void:
	if !player:
		return
	print(player)
	enemy.navigator.target_position = player.global_position
	var velocity_direction := (enemy.navigator.get_next_path_position() - enemy.global_position).normalized()
	print(velocity_direction)
	enemy.velocity = velocity_direction * enemy.SPEED
	if enemy.navigator.distance_to_target() < 100:
		state.switch_state("shooting")
	
