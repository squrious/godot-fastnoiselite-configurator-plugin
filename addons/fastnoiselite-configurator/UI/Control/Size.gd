@tool
extends ControlGroup

func _configure():
	mapping = {
		"x": {
			"control": $VBoxContainer/X/SpinBox,
		},
		"y": {
			"control": $VBoxContainer/Y/SpinBox,
		}
	}
