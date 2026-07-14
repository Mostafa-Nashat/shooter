class_name Sword
extends Weapon

var sword: Sword_data
@export var hitbox: Area2D

func setup_hitbox() -> void:
	for child in hitbox.get_children():
		hitbox.remove_child(child)
	var collision_shape := CollisionShape2D.new()
	collision_shape.shape = sword.sword_shape
	hitbox.add_child(collision_shape)
	hitbox.position = sword.offset

func _setup() -> void:
	hitbox.area_entered.connect(_on_hit)
	if !(weapon is Sword_data):
		return
	sword = weapon
	add_sprite(weapon.sprite, weapon.offset)
	setup_hitbox()

func _use(_user: Node) -> void:
	pass

func _on_hit(area: Area2D):
	if area is Hurtbox:
		var hurtbox = area
		hurtbox.health.damage(sword.damage)
		print("hit")
