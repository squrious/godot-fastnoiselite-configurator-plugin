extends ControlGroup

signal reset

@onready var reset_button = $MarginContainer/VBoxContainer/ResetButton
@onready var reset_confirmation = $MarginContainer/VBoxContainer/ResetButton/ConfirmationDialog

@onready var copy_code_snippet_button = $MarginContainer/VBoxContainer/VBoxContainer/CodeSnippet/CopyButton
@onready var code_snippet_label = $MarginContainer/VBoxContainer/VBoxContainer/CodeSnippet

var snippet_parameters: Dictionary:
	set(v):
		code_snippet_label.text = _format_paramaters(v)

var code_snippet: String:
	set(v):
		code_snippet_label.text = v
	get: 
		return code_snippet_label.text


func _configure():
	mapping = {
		"show_compute_time": {
			"control": $MarginContainer/VBoxContainer/DebugPanelButton
		}
	}
	
	reset_button.connect("pressed", func(): reset_confirmation.show())
	reset_confirmation.connect("confirmed", func(): emit_signal("reset"))

	copy_code_snippet_button.connect("pressed", func():
		DisplayServer.clipboard_set(code_snippet_label.text)
	)


func _format_paramaters(noise_parameters: Dictionary) -> String:
	var output = "{\n"
	for key in noise_parameters.keys():
		var value = noise_parameters[key]
		var modifier
		output += "\t\"%s\": " % key
		if value is int:
			output += "%d" % value
		elif value is float:
			output += "%f" % value
		elif value is bool:
			output += "%s" % "true" if value else "false"
		else: 
			output += "%s" % value
			push_warning("Unknown type for key %s" % key)
		output += ",\n"
	output += "}"

	return output
