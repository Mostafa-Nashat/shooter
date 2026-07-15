extends State

var enemy: Enemy

func _update():
	print(enemy.position)
func _start():
	enemy = state.node

func _end():
	pass
