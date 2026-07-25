class_name Gun
extends Weapon

@onready var gun: Gun_data = weapon 
var base_bullet = Bullet.new()

func _setup() -> void:
	add_sprite(weapon.sprite, weapon.offset)
	
func _use(_user: Node) -> void:

	for index: float in gun.count:
		var bullet: Bullet = base_bullet.duplicate()
		bullet.set_collision_mask_value(2, true)
		bullet.bullet = weapon.bullet
		bullet.position = to_global(position + weapon.bullet.offset)
		var offset := lerpf(-gun.spread, gun.spread, index/(gun.count - 1))
		bullet.rotation = global_rotation + deg_to_rad(offset)
		get_tree().root.add_child(bullet)
	
	await  get_tree().create_timer(gun.cooldown).timeout
