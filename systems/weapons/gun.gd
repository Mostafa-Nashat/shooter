class_name Gun
extends Weapon

var cooldown_timer: Timer

func _start() -> void:
	var sprite_node = Sprite2D.new()
	sprite_node.texture = weapon.sprite
	position = weapon.offset
	add_child(sprite_node)
	
	var timer := Timer.new()
	timer.wait_time = weapon.cooldown
	timer.autostart = false
	timer.one_shot = true
	add_child(timer)
	cooldown_timer = timer
	

func _physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and cooldown_timer.is_stopped():
		cooldown_timer.start()
		var bullet := Bullet.new()
		bullet.bullet = weapon.bullet
		bullet.rotation = global_rotation
		bullet.position = to_global(position + weapon.bullet.offset)
		get_tree().root.add_child(bullet)
