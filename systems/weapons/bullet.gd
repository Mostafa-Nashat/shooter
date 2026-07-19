class_name Bullet
extends Area2D

@export var bullet: Bullet_data

var despawn_timer: Timer

func add_hitbox():
	var hitbox := CollisionShape2D.new()
	var rectangle := RectangleShape2D.new()
	rectangle.size = bullet.hitbox_size
	hitbox.shape = rectangle
	add_child(hitbox)

func add_sprite():
	var sprite := Sprite2D.new()
	sprite.texture = bullet.sprite
	add_child(sprite)

func add_despawn_timer() -> void:
	var timer := Timer.new()
	timer.autostart = true
	timer.one_shot = true
	timer.wait_time = bullet.despawn_time
	add_child(timer)
	despawn_timer = timer

func _ready() -> void:
	if bullet.player_freindly:
		set_collision_mask_value(1, true)
	else:
		set_collision_mask_value(1, false)
		set_collision_mask_value(2, true)
	add_hitbox()
	add_sprite()
	add_despawn_timer()
	area_entered.connect(_on_hit)


func _physics_process(_delta: float) -> void:
	if despawn_timer.is_stopped():
		queue_free()
	move_local_x(bullet.velocity.x)
	move_local_y(bullet.velocity.y)

func _on_hit(area: Area2D):
		if !(area is Hurtbox):
			return
		var hurtbox: Hurtbox = area
		hurtbox.health.damage(bullet.damage)
		queue_free()
