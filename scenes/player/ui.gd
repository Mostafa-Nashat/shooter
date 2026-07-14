class_name UI_manager
extends Node2D

@export_group("weapons")
@export var weapons: Node2D
@export var left_frame_sprite: Texture2D
@export var middle_frame_sprite: Texture2D
@export var right_frame_sprite: Texture2D
@export var single_frame_sprite: Texture2D
@export var frame_size: Vector2 = Vector2(16, 16)
@export_group("health")
@export var health_bar: Node2D
@export var heart_texture: Texture2D
@export var heart_distance: float

var number_of_weapon_frames: int = 0

func correct_first_weapon_frame() -> void:
	var nodes: Array[Node] = weapons.get_children()
	var first_frame: Sprite2D = nodes[0]
	first_frame.texture = left_frame_sprite

func correct_middle_weapon_frames() -> void:
	var nodes: Array[Node] = weapons.get_children()
	for index in len(nodes):
		if index == 0:
			continue
		var frame: Sprite2D = nodes[index]
		frame.texture = middle_frame_sprite

func add_weapon_display(sprite: Texture2D) -> void:
	var frame := Sprite2D.new()
	if number_of_weapon_frames == 0:
		frame.texture = single_frame_sprite
	elif number_of_weapon_frames == 1:
		frame.texture = right_frame_sprite
		correct_first_weapon_frame()
	else:
		correct_middle_weapon_frames() 
		
		frame.texture = right_frame_sprite
	var icon := Sprite2D.new()
	icon.texture = sprite
	icon.region_enabled = true
	icon.region_rect.size = frame_size
	icon.z_as_relative = false
	frame.add_child(icon)
	frame.z_index = 1
	frame.position.x = number_of_weapon_frames * frame_size.x
	weapons.add_child(frame)
	number_of_weapon_frames += 1


func add_hearts(health: int):
	for index in range(health):
		var heart_sprite := Sprite2D.new()
		heart_sprite.texture = heart_texture
		heart_sprite.position.x = index * heart_distance
		health_bar.add_child(heart_sprite)
