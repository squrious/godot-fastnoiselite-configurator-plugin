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
			"control": $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Type/OptionButton,
			"values": TYPE
		},
		"gain": {
			"control": $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Gain/SpinBox,
		},
		"lacunarity": {
			"control": $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Lacunarity/SpinBox,
		},
		"octaves": {
			"control": $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Octaves/SpinBox,
		},
		"ping_pong_strength": {
			"control": $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/PingPongStrength/SpinBox,
		},
		"weighted_strength": {
			"control": $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/WeightedStrength/SpinBox,
		},
	}
	
	self.connect("value_changed", func(v):
		if (!v.has("type")): return
		
		for p in ["gain", "lacunarity", "octaves", "weighted_strength"]: mapping[p]["control"].get_parent().visible = v.type != TYPE.NONE
		
		
		$MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/PingPongStrength.visible = v.type == TYPE.PING_PONG
	)
	
	
	
