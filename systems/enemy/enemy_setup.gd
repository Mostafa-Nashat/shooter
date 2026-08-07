class_name EnemySetup
extends Setup

func callback(enemy: Enemy) -> void:
	enemy.died.connect(wave_spawner.enemy_died.emit)
