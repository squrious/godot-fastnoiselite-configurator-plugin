@tool
extends ControlGroup

enum TYPE {
	NONE = FastNoiseLite.FRACTAL_NONE,
	FBM = FastNoiseLite.FRACTAL_FBM,
	RIDGED = FastNoiseLite.FRACTAL_RIDGED,
	PING_PONG = FastNoiseLite.FRACTAL_PING_PONG
}

func _configure():
	mapping = {
		"type": {
			"control": $VBoxContainer/Type/OptionButton,
			"values": TYPE
		},
		"gain": {
			"control": $VBoxContainer/Gain/SpinBox,
		},
		"lacunarity": {
			"control": $VBoxContainer/Lacunarity/SpinBox,
		},
		"octaves": {
			"control": $VBoxContainer/Octaves/SpinBox,
		},
		"ping_pong_strength": {
			"control": $VBoxContainer/PingPongStrength/SpinBox,
		},
		"weighted_strength": {
			"control": $VBoxContainer/WeightedStrength/SpinBox,
		},
	}
	
	self.connect("value_changed", func(v):
		if (!v.has("type")): return
		
		for p in ["gain", "lacunarity", "octaves", "weighted_strength"]: mapping[p]["control"].get_parent().visible = v.type != TYPE.NONE
		
		
		$VBoxContainer/PingPongStrength.visible = v.type == TYPE.PING_PONG
	)
	
	
	
