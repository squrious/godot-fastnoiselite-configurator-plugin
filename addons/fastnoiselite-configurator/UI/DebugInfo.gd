@tool
extends PanelContainer

@onready var compute_time_label = $VBoxContainer/ComputeTime

var compute_time = 0:
	set(v):
		compute_time = v
		compute_time_label.text = _format_time(v)

func _format_time(ms: int):	
	var hours = ((ms / (60 * 60 * 1000)))
	ms -= hours * (60 * 60 * 1000)
	
	var minutes = ms / (60 * 1000)
	ms -= minutes * (60 * 1000)
	
	var seconds = ms / 1000
	ms -= seconds * 1000
	
	var string_parts = PackedStringArray([])

	if hours > 0: string_parts.append("%d hours" % hours)
	if minutes > 0: string_parts.append("%d minutes" % minutes)

	string_parts.append("%d,%d seconds" % [seconds, ms])
	return "Computed in " + " ".join(string_parts)
		
