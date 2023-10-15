@tool
extends ControlGroup

enum NOISE_TYPE {
	VALUE = FastNoiseLite.TYPE_VALUE,
	CUBIC = FastNoiseLite.TYPE_VALUE_CUBIC,
	PERLIN = FastNoiseLite.TYPE_PERLIN,
	CELLULAR = FastNoiseLite.TYPE_CELLULAR,
	SIMPLEX = FastNoiseLite.TYPE_SIMPLEX,
	SIMPLEX_SMOOTH = FastNoiseLite.TYPE_SIMPLEX_SMOOTH,
}

@onready var cellular_control = $ScrollContainer/VBoxContainer/Cellular

func _configure():
	mapping = {
		"seed": {
			"control": $ScrollContainer/VBoxContainer/Seed/HBoxContainer/SpinBox
		},
		"noise_type": {
			"control": $ScrollContainer/VBoxContainer/Type/OptionButton,
			"values": NOISE_TYPE,
		},
		"frequency": {
			"control": $ScrollContainer/VBoxContainer/Frequency/SpinBox
		},		
		"size": {
			"control": $ScrollContainer/VBoxContainer/Size,
		},
		"domain_warp": {
			"control": $ScrollContainer/VBoxContainer/DomainWarp,
		},
		"fractal": {
			"control": $ScrollContainer/VBoxContainer/Fractal,
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

