extends State

func get_player() -> Player:
	var player_node: Player = get_tree().get_first_node_in_group("player")
	return player_node

var enemy: Frager
var player: Player

func throw() -> void:
	enemy.throw_animation.play("wind_up")
	var animation_multipliyer := enemy.throw_animation.current_animation_length / enemy.wind_up_time
	enemy.throw_animation.speed_scale = animation_multipliyer
	await enemy.throw_animation.animation_finished
	enemy.throw_animation.speed_scale = 1
	enemy.throw_animation.play("throw")
	await enemy.throw_animation.animation_finished
	var direction := (player.global_position - enemy.frag_thrower.global_position).normalized()
	enemy.frag_thrower.throw(direction, enemy.power, enemy)
	enemy.throw_animation.play("RESET")
	await get_tree().create_timer(enemy.throw_delay).timeout
	throw()
	

func _start():
	player = get_player()
	enemy = state.node	
	enemy.velocity = Vector2.ZERO
	throw()
	

func _update():
	var distance_to_player := (player.global_position - enemy.global_position).length()
	if distance_to_player > 150:
		state.switch_state("chasing")
