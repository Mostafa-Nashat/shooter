class_name State
extends Node

var state: State_machine

func _ready() -> void:
	if get_parent() is State_machine:
		state = get_parent()

func _start():
	pass

func _end():
	pass

func _update():
	pass

func _setup() -> void:
	pass
