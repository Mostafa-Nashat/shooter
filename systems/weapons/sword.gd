class_name Sword
extends Weapon

var sword: Sword_data

func add_hitbox() -> void:
	var hitbox := Area2D.new()
	var colidershape := CollisionShape2D.new()
	var rectangle := RectangleShape2D.new()
	rectangle.size = sword.sword_size
	colidershape.shape = rectangle
	colidershape.position = sword.offset
	hitbox.add_child(colidershape)
	add_child(hitbox)

func _start() -> void:
	if !(weapon is Sword_data):
		return
	sword = weapon
	add_hitbox()
	add_sprite(weapon.sprite, weapon.offset)

func _use(_user: Node) -> void:
	pass
