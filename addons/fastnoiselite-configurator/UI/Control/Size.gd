extends ControlGroup

func _configure():
	mapping = {
		"x": {
			"control": $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/X/SpinBox,
		},
		"y": {
			"control": $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Y/SpinBox,
		}
	}
