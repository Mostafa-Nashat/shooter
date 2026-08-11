class_name WeaponComposer
extends Node2D


var weapons: Array[Weapon]
@export var default: Weapon
@onready var old_weapon := default


func append_weapons() -> void:
	for child in get_children():
		if child is Weapon:
			weapons.append(child)

func enable_defualt() -> void:
	for weapon in weapons:
		if weapon == default and !weapon.enabled:
			weapon.enabled = true
			return
		if weapon.enabled:
			weapon.enabled = false
			return

func equip(weapon: Weapon) -> void:
	if old_weapon:
		old_weapon.enabled = false
	old_weapon = weapon
	

func connect_weapon_signals() -> void:
	for weapon in weapons:
		weapon.got_enabled.connect(equip)

func _ready() -> void:
	append_weapons()
	enable_defualt()
