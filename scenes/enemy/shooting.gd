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
	enemy.gun.start()
	delay.start()

func _update():
	if !player:
		return
	enemy.arm.look_at_target(20, player.global_position)
	enemy.gun.update()
	if !delay.is_stopped():
		return
	delay.start()
	enemy.gun.use()
	
