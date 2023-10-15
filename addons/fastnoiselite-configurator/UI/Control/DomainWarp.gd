@tool
extends ControlGroup

enum FRACTAL_TYPE {
	NONE = FastNoiseLite.DOMAIN_WARP_FRACTAL_NONE,
	PROGRESSIVE = FastNoiseLite.DOMAIN_WARP_FRACTAL_PROGRESSIVE,
	INDEPENDENT = FastNoiseLite.DOMAIN_WARP_FRACTAL_INDEPENDENT,
}

enum TYPE {
	SIMPLEX = FastNoiseLite.DOMAIN_WARP_SIMPLEX,
	SIMPLEX_REDUCED = FastNoiseLite.DOMAIN_WARP_SIMPLEX_REDUCED,
	BASIC_GRID = FastNoiseLite.DOMAIN_WARP_BASIC_GRID
}

func _configure():
	mapping = {
		"enabled": {
			"control": $VBoxContainer/Enabled,
		},
		"amplitude": {
			"control": $VBoxContainer/Amplitude/SpinBox,
		},
		"fractal_gain": {
			"control": $VBoxContainer/FractalGain/SpinBox,
		},
		"fractal_type": {
			"control": $VBoxContainer/FractalType/OptionButton,
			"values": FRACTAL_TYPE,
		},
		"frequency": {
			"control": $VBoxContainer/Frequency/SpinBox,
		},
		"fractal_octaves": {
			"control": $VBoxContainer/FractalOctaves/SpinBox,
		},
		"type": {
			"control": $VBoxContainer/Type/OptionButton,
			"values": TYPE
		}
	}
	
	set_options_visibility($VBoxContainer/Enabled.button_pressed)
	$VBoxContainer/Enabled.connect("toggled", func(pressed): 
		set_options_visibility(pressed)
	)
	
	

func set_options_visibility(visible: bool):
	var props = [
		"amplitude",
		"fractal_gain",
		"fractal_type",
		"fractal_octaves",
		"frequency",
		"type"
	]
	
	for p in props:
		mapping[p]["control"].get_parent().visible = visible
	
