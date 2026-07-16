extends State

var player: Player
var direction: Vector2

@export var SPEED_MULTIPLYER: float = 2
@export var timer: Timer
@export var fade_affect: GPUParticles2D
@export_range(0.01, 1, 0.01) var zoom: float = 0.98


func _start():
	player = state.node
	var direction := Input.get_vector("left", "right", "front", "back").normalized()
	if direction == Vector2.ZERO:
		direction = Vector2.LEFT
	timer.start()
	player.velocity = direction * player.SPEED * SPEED_MULTIPLYER
	fade_affect.emitting = true
	var zoom_tween := get_tree().create_tween().set_ease(Tween.EASE_IN)
	zoom_tween.tween_property(
		player.camera, 
		"zoom", 
		Vector2(zoom, zoom),
		timer.wait_time / 2
	)
	
func _update():
	player.arm.look_at_target(player.get_global_mouse_position(), player.MAX_HAND_SWING_SPEED)
	player.allow_weapon_control()
	player.show_hud_elements()
	if timer.is_stopped():
		fade_affect.emitting = false
		var zoom_tween := get_tree().create_tween().set_ease(Tween.EASE_OUT)
		zoom_tween.tween_property(
		player.camera, 
		"zoom", 
		Vector2(1.0, 1.0),
		timer.wait_time / 2
		)
		state.switch_state("ground")
		return
	
