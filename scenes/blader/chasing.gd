extends State


var enemy: Enemy
var blader: Blader

func get_player() -> Player:
	var player_node: Player = get_tree().get_first_node_in_group("player")
	return player_node


var player: Player

func _start():
	enemy = state.node
	blader = state.node
	player = get_player()
	enemy.arm.rotation_degrees = 0

func _update() -> void:
	if !player:
		return
	var direction = enemy.get_next_direction()
	if direction.x < 0:
		enemy.transform.x = Vector2(-1, 0)
	elif direction.x > 0:
		enemy.transform.x = Vector2(1, 0)
	
	if direction:
		enemy.animation.play(&"movement/walk_with_free_arm")
	
	enemy.go_to(player.global_position, enemy.SPEED)
	if enemy.navigator.distance_to_target() < blader.attack_radius:
		state.switch_state("swing")
