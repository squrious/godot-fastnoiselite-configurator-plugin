extends ControlGroup

signal reset
signal save_resource(path: String)
signal load_resource(path: String)

@onready var reset_button = $MarginContainer/VBoxContainer/ResetButton
@onready var reset_confirmation = $MarginContainer/VBoxContainer/ResetButton/ConfirmationDialog

@onready var save_resource_button = $MarginContainer/VBoxContainer/SaveResourceButton
@onready var save_resource_dialog = $MarginContainer/VBoxContainer/SaveResourceButton/FileDialog

@onready var load_resource_button = $MarginContainer/VBoxContainer/LoadResourceButton
@onready var load_resource_dialog = $MarginContainer/VBoxContainer/LoadResourceButton/FileDialog

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

	save_resource_button.connect("pressed", func(): 
		save_resource_dialog.current_file = "noise.tres"
		save_resource_dialog.show()
	)
	save_resource_dialog.connect("file_selected", func(path):
		emit_signal("save_resource", path)
	)
	
	load_resource_button.connect("pressed", func(): 
		load_resource_dialog.show()
	)
	load_resource_dialog.connect("file_selected", func(path):
		emit_signal("load_resource", path)
	)
	
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
