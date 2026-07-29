extends State

@export var stun_time: float = 0.5
@export var stun_affect_frequency: float = 0.2
@export var knock_back_power: float = 200.0
@export var invicibility_time := 0.5
var player: Enemy

func knock_back() -> void:
	player.velocity.x = lerpf(player.velocity.x, 0, 0.005)
	player.velocity.y = lerpf(player.velocity.y, 0, 0.999)

func stun_affect() -> Tween:
	var tween := get_tree().create_tween()
	tween.set_loops()
	tween.tween_property(player, "modulate", Color(2.0, 2.0, 2.0, 1.0), stun_affect_frequency/2)
	tween.tween_property(player, "modulate", Color(1.0, 1.0, 1.0, 1.0), stun_affect_frequency/2)
	return tween

func _start():
	player = state.node
	player.velocity = player.stun_direction * knock_back_power
	player.hurtbox.set_deferred("monitorable", false)
	var tween := stun_affect()
	await get_tree().create_timer(stun_time).timeout
	player.modulate = Color(1.0, 1.0, 1.0, 1.0)
	get_tree().create_timer(invicibility_time).timeout.connect(stop_invincibility.bind(tween))
	state.switch_state("chasing")

func stop_invincibility(tween: Tween) -> void:
	player.hurtbox.set_deferred("monitorable", true)
	tween.kill()
	

func _update():
	knock_back()
