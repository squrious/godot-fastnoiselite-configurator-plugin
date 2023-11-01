extends ControlGroup

enum NOISE_TYPE {
	VALUE = FastNoiseLite.TYPE_VALUE,
	CUBIC = FastNoiseLite.TYPE_VALUE_CUBIC,
	PERLIN = FastNoiseLite.TYPE_PERLIN,
	CELLULAR = FastNoiseLite.TYPE_CELLULAR,
	SIMPLEX = FastNoiseLite.TYPE_SIMPLEX,
	SIMPLEX_SMOOTH = FastNoiseLite.TYPE_SIMPLEX_SMOOTH,
}

@onready var cellular_control = $MarginContainer/VBoxContainer/Cellular

func _configure():
	mapping = {
		"seed": {
			"control": $MarginContainer/VBoxContainer/Seed/HBoxContainer/SpinBox
		},
		"noise_type": {
			"control": $MarginContainer/VBoxContainer/Type/OptionButton,
			"values": NOISE_TYPE,
		},
		"frequency": {
			"control": $MarginContainer/VBoxContainer/Frequency/SpinBox
		},		
		"size": {
			"control": $MarginContainer/VBoxContainer/Size,
		},
		"domain_warp": {
			"control": $MarginContainer/VBoxContainer/DomainWarp,
		},
		"fractal": {
			"control": $MarginContainer/VBoxContainer/Fractal,
		},
		"cellular": {
			"control": cellular_control,
		},
	}

	self.connect("value_changed", func(_v): _set_options_visibility())

func _set_options_visibility():
	match value.noise_type:
		FastNoiseLite.TYPE_CELLULAR: 
			cellular_control.show()
		_: 
			cellular_control.hide()

