@tool
class_name UI_manager
extends Control

@export var camera: Camera2D
@export_group("weapons")
@export var weapons_container: BoxContainer
@export var left_frame: Texture2D
@export var center_frame: Texture2D
@export var right_frame: Texture2D
@export var single_frame: Texture2D
@export_group("hearts") 
@export var hearts_container: BoxContainer
@export var heart_texture: Texture2D
@export_group("bullets")
@export var bullet_container: BoxContainer
@export var bullet_texture: Texture2D
@export_group("stamina")
@export var stamina: ProgressBar

func correct_first_frame():
	var first_frame: TextureRect = weapons_container.get_child(0)
	first_frame.texture = left_frame

func correct_middle_frames(number_of_frames):
	for index in range(1, number_of_frames):
		var middle_frame: TextureRect = weapons_container.get_child(index)
		middle_frame.texture = center_frame

func add_weapon(texture: Texture, offset: Vector2 = Vector2.ZERO):
	var number_of_frames := weapons_container.get_child_count()
	var frame := TextureRect.new()
	if number_of_frames == 0:
		frame.texture = single_frame
	elif number_of_frames == 1:
		correct_first_frame()
		frame.texture = right_frame
	else:
		correct_middle_frames(number_of_frames)
		frame.texture = right_frame
	frame.z_index = 1
	var icon := TextureRect.new()
	var atlas_texture := AtlasTexture.new()
	atlas_texture.atlas = texture
	
	atlas_texture.margin = Rect2(offset, Vector2.ZERO)
	atlas_texture.region = Rect2(Vector2.ZERO, atlas_texture.get_size() +  offset)
	icon.texture = atlas_texture
	icon.z_index = 0
	icon.z_as_relative = false
	frame.add_child(icon)
	weapons_container.add_child(frame)

func set_items_in_box(count: int, texture: Texture2D, box: BoxContainer):
	var number_of_items := box.get_child_count()
	if count == number_of_items:
		return
	if count < number_of_items:
		var items := box.get_children()
		for index in range(number_of_items - count):
			var item: Node = items.pop_back()
			box.remove_child(item)
	if count > number_of_items:
		for index in range(count - number_of_items):
			var item_texture := TextureRect.new()
			item_texture.texture = texture
			item_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			box.add_child(item_texture)

func set_progress_bar(value: float, bar: ProgressBar):
	bar.value = value

func _ready() -> void:
	size.x = ProjectSettings.get_setting("display/window/size/viewport_width")
	size.y = ProjectSettings.get_setting("display/window/size/viewport_height")
	position.x = -size.x / 2
	position.y = -size.y / 2
