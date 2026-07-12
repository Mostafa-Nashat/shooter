class_name State_machine
extends Node

@export var node: Node

var states: Array[State]
var current_state: State

func _ready() -> void:
	for child in get_children(false):
		if child is State:
			states.append(child)

func default_state(state_name: String):
	for state in states:
		if state.name == state_name:
			state._start()
			current_state = state

func update():
	current_state._update()

func switch_state(state_name: String):
	var new_state: State
	for state in states:
		if state.name == state_name:
			new_state = state
	current_state._end()
	new_state._start()
	current_state = new_state
