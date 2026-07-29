extends Polygon2D


func _ready() -> void:
	var tween := get_tree().create_tween().set_loops(10)
	tween.tween_property(self, "modulate", Color(0 ,0, 0, 255), 0.5)
	tween.tween_callback(func(): print("hello"))
	tween.tween_property(self, "modulate", Color(255 ,255, 255, 255), 0.5)

func _process(delta: float) -> void:
	print(modulate)
