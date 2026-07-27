class_name ItemDrop
extends Resource

@export var item: ItemData
@export_range(0, 1.0, 0.1, "or_greater", "or_less", "prefer_slider") var weight: float
