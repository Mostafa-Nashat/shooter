class_name ControlsTextSetter
extends DynamicTextSetter

@export_multiline() var text: String
@export var actions: Array[StringName]

func _ready() -> void:
	var values: Array[String]
	for action in actions:	
		var events := InputMap.action_get_events(action)
		for event in events:
			if event is InputEventKey:
				values.append(event.as_text().get_slice(" ", 0)) 
				break
			elif event is InputEventMouse:
				if event.as_text().contains("Left Mouse Button"):
					values.append("LMB")
					break
				elif event.as_text().contains("Right Mouse Button"):
					values.append("RMB")
					break
	node.set(property, text.format(values)) 
