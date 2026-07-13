extends State

var enemy: Enemy
var player: Player

func get_player() -> Player:
	var players :Array[Node] = get_tree().get_nodes_in_group("player")
	if len(players) == 0:
		return null
	var returned_player: Player = players[0]
	return returned_player


@onready var delay = $delay

func _start():
	enemy = state.node
	player = get_player()
	delay.start()
	enemy.arm.visible = true


func _update():
	if !player:
		return
	enemy.velocity = Vector2.ZERO
	enemy.arm.look_at_target(player.global_position, enemy.MAX_HAND_SWING_SPEED)
	if !delay.is_stopped():
		return
	delay.start()
	enemy.gun.use()
	var player_distance = player.global_position - enemy.global_position
	if player_distance.length() > 70:
		state.switch_state("chasing")
