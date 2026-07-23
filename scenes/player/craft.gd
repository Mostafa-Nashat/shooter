extends State

var player: Player

func _start():
	player = state.node
	
	player.bullets.visible = false
	player.hearts.visible = false
	player.weapons.visible = false
	player.stamina.visible = false
	player.inventory.visible = true

func _update():
	if Input.is_action_just_pressed("inventory"):
		state.switch_state("ground")

func _end():
	
	player.bullets.visible = true
	player.hearts.visible = true
	player.weapons.visible = true
	player.stamina.visible = true
	player.inventory.visible = false
	
