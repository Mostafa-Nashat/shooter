class_name UI_manager
extends Node

@export var sword_sprite_display: Sprite2D
@export var gun_sprite_display: Sprite2D

func set_sword_sprite(sprite: Texture2D) -> void:
	sword_sprite_display.texture = sprite

func set_gun_sprite(sprite: Texture2D) -> void:
	gun_sprite_display.texture = sprite
