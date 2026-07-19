extends Node2D

@export var spawner: Enemy_Spawner

var blader := preload("res://scenes/blader/blader.tscn")

func spawn() -> void:
	var blader_node := blader.instantiate()
	spawner.spawn(self, blader_node) 

func _ready() -> void:
	spawner.enemy_died.connect(func(): print("died"))
	while(true):
		await  get_tree().create_timer(2.0).timeout
		spawn()
