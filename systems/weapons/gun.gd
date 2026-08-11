class_name Gun
extends Weapon

@onready var gun: Gun_data = weapon 
@export var audio: AudioStreamPlayer2D
var base_bullet = Bullet.new()

func _setup() -> void:
	audio.stream = gun.audio
	add_sprite(weapon.sprite, weapon.offset)

func update():
	add_sprite(gun.sprite, gun.offset)

func _use(_user: Node) -> void:
	audio.play()
	for index: float in gun.count:
		var bullet: Bullet = base_bullet.duplicate()
		bullet.set_collision_mask_value(2, true)
		bullet.bullet = gun.bullet
		bullet.position = to_global(position + weapon.bullet.offset)
		var offset := lerpf(-gun.spread, gun.spread, (index+1)/gun.count)
		bullet.rotation = global_rotation + deg_to_rad(offset)
		get_tree().root.add_child(bullet)
	
	await  get_tree().create_timer(gun.cooldown).timeout
