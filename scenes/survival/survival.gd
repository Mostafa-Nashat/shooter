extends Level


@export var wave_spawner: WaveSpawner

@export var player: Player

var death_screen: PackedScene = preload("res://scenes/survival_death_screen/survival_death_screen.tscn")

var hud := preload("res://scenes/survival/survival_hud.tscn").instantiate()

func _ready() -> void:
	player.hud.add_child(hud)


func _process(_delta: float) -> void:
	hud.enemies_left = wave_spawner.enemy_count
	hud.wave = wave_spawner.wave
	if wave_spawner.enemy_count == 0:
		hud.enemy_counter.visible = false
	else:
		hud.enemy_counter.visible = true

func _on_player_died() -> void:
	var death_screen_node := death_screen.instantiate()
	death_screen_node.died_on_wave = wave_spawner.wave
	get_tree().change_scene_to_node(death_screen_node)
