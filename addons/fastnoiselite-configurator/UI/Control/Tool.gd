@tool
extends ControlGroup

signal reset

@onready var reset_button = $VBoxContainer/ResetButton
@onready var reset_confirmation = $VBoxContainer/ResetButton/ConfirmationDialog

@onready var copy_code_snippet_button = $VBoxContainer/CodeSnippet/CopyButton
@onready var code_snippet_label = $VBoxContainer/CodeSnippet

var code_snippet: String:
	set(v):
		code_snippet_label.text = v
	get: 
		return code_snippet_label.text


func _configure():
	mapping = {
		"show_compute_time": {
			"control": $VBoxContainer/DebugPanelButton
		}
	}
	
	reset_button.connect("pressed", func(): reset_confirmation.show())
	reset_confirmation.connect("confirmed", func(): emit_signal("reset"))

	copy_code_snippet_button.connect("pressed", func():
		DisplayServer.clipboard_set(code_snippet)
	)
