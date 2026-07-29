extends State

@export var stun_time: float
@export var stun_affect_frequency: float
@export var knock_speed: float
var player: Player

func _start():
	player = state.node
	player.hurtbox.set_deferred("monitorable", false)
	await get_tree().create_timer(stun_time).timeout	
	state.switch_state("ground")

func _update():
	player.velocity.x = lerpf(player.stun_direction.x * knock_speed, 0, 0.8)
	player.velocity.y = lerpf(player.stun_direction.y * knock_speed, 0, 0.8)
	player.show_hud_elements()

func _end():
	player.hurtbox.set_deferred("monitorable", true)
