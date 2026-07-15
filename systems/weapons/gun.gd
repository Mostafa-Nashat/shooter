class_name Gun
extends Weapon

@onready var gun: Gun_data = weapon 

func _setup() -> void:
	add_sprite(weapon.sprite, weapon.offset)
	
func _use(_user: Node) -> void:
	var bullet := Bullet.new()
	bullet.set_collision_mask_value(2, true)
	bullet.bullet = weapon.bullet
	bullet.rotation = global_rotation
	bullet.position = to_global(position + weapon.bullet.offset)
	get_tree().root.add_child(bullet)
	
	await  get_tree().create_timer(gun.cooldown).timeout
