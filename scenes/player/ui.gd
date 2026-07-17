class_name UI_manager
extends Control

func correct_first_frame(container: BoxContainer, left_frame: Texture2D):
	var first_frame: TextureRect = container.get_child(0)
	first_frame.texture = left_frame

func correct_middle_frames(container: BoxContainer, center_frame: Texture2D):
	var number_of_frames: int = container.get_child_count()
	for index in range(1, number_of_frames):
		var middle_frame: TextureRect = container.get_child(index)
		middle_frame.texture = center_frame

func add_weapon(
	container: BoxContainer,
 	texture: Texture,
	frames: Frames,
	offset: Vector2 = Vector2.ZERO,
	):
	var number_of_frames := container.get_child_count()
	var frame := TextureRect.new()
	if number_of_frames == 0:
		frame.texture = frames.single
	elif number_of_frames == 1:
		correct_first_frame(container, frames.left)
		frame.texture = frames.right
	else:
		correct_middle_frames(container, frames.center)
		frame.texture = frames.right
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
	container.add_child(frame)

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
