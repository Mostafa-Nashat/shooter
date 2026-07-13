class_name Gun
extends Weapon

var cooldown_timer: Timer

func _start() -> void:
	add_sprite(weapon.sprite, weapon.offset)
	
	var timer := Timer.new()
	timer.wait_time = weapon.cooldown
	timer.autostart = false
	timer.one_shot = true
	add_child(timer)
	cooldown_timer = timer
	
func _use() -> void:
	if  cooldown_timer.is_stopped():
		cooldown_timer.start() 
		
		var bullet := Bullet.new()
		bullet.bullet = weapon.bullet
		bullet.rotation = global_rotation
		bullet.position = to_global(position + weapon.bullet.offset)
		get_tree().root.add_child(bullet)
	
