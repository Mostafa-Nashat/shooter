class_name Sword
extends Weapon

var sword: Sword_data
@export var hitbox: Area2D
@export var player_friendly: bool
@export var animation_player: AnimationPlayer
var library_name: String = "sword"

signal hit
signal kill

func setup_hitbox() -> void:
	for child in hitbox.get_children():
		hitbox.remove_child(child)
	var collision_shape := CollisionShape2D.new()
	collision_shape.shape = sword.sword_shape
	hitbox.add_child(collision_shape)
	hitbox.position = sword.offset

func _setup() -> void:
	hitbox.monitoring = false
	hitbox.area_entered.connect(_on_hit)
	if !(weapon is Sword_data):
		return
	sword = weapon
	add_sprite(weapon.sprite, weapon.offset)
	setup_hitbox()
	if player_friendly:
		hitbox.set_collision_mask_value(1, true)
		hitbox.set_collision_mask_value(2, false)
	else:
		hitbox.set_collision_mask_value(1, false)
		hitbox.set_collision_mask_value(2, true)

func _use(_user: Node) -> void:
	animation_player.play("sword_animations/swing")
	await animation_player.animation_finished
	animation_player.play("sword_animations/RESET")
	hitbox.monitoring = false

func _on_hit(area: Area2D):
	if area is Hurtbox:
		hit.emit()
		var hurtbox = area
		hurtbox.health.died.connect(_on_kill)
		hurtbox.health.damage(sword.damage, self)

func _on_kill(_killer: Node2D):
	kill.emit()
