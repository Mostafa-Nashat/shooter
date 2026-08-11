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
				values.append(event.as_text()[0]) 
				break
	node.set(property, text.format(values)) 
