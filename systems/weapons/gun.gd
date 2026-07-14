class_name Gun
extends Weapon


var cooldown_timer: Timer

func _setup() -> void:
	add_sprite(weapon.sprite, weapon.offset)
	var timer := Timer.new()
	timer.wait_time = weapon.cooldown
	timer.autostart = false
	timer.one_shot = true
	cooldown_timer = timer
	add_child(timer)
	
func _use(_user: Node) -> void:
	if  cooldown_timer.is_stopped():
		cooldown_timer.start() 
		
		var bullet := Bullet.new()
		bullet.set_collision_mask_value(2, true)
		bullet.bullet = weapon.bullet
		bullet.rotation = global_rotation
		bullet.position = to_global(position + weapon.bullet.offset)
		get_tree().root.add_child(bullet)
	await  get_tree().create_timer(0.2).timeout
