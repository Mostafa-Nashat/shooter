extends State

var blader: Blader

func get_player() -> Player:
	var player_node: Player = get_tree().get_first_node_in_group("player")
	return player_node


@export var delay: Timer

func _start():
	blader = state.node
	delay.start()

func _update():
	if delay.is_stopped():
		await blader.sword.use()
		delay.start()
	var player := get_player()
	blader.navigator.target_position = player.global_position
	var player_distance := blader.navigator.distance_to_target()
	if player_distance > blader.attack_radius:
		state.switch_state("chasing")
	var direction := blader.get_next_direction()
	blader.velocity = direction * blader.SPEED
	
