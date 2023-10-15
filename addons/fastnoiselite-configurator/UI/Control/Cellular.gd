@tool
extends ControlGroup

enum DISTANCE_FUNCTION {
	EUCLIDIAN = FastNoiseLite.DISTANCE_EUCLIDEAN,
	EUCLIDIAN_SQUARED = FastNoiseLite.DISTANCE_EUCLIDEAN_SQUARED,
	MANHATTAN = FastNoiseLite.DISTANCE_MANHATTAN,
	HYBRID = FastNoiseLite.DISTANCE_HYBRID,
}

enum RETURN_TYPE {
	CELL_VALUE = FastNoiseLite.RETURN_CELL_VALUE,
	DISTANCE = FastNoiseLite.RETURN_DISTANCE,
	DISTANCE2 = FastNoiseLite.RETURN_DISTANCE2,
	DISTANCE2_ADD = FastNoiseLite.RETURN_DISTANCE2_ADD,
	DISTANCE2_SUB = FastNoiseLite.RETURN_DISTANCE2_SUB,
	DISTANCE2_MUL = FastNoiseLite.RETURN_DISTANCE2_MUL,
	DISTANCE2_DIV = FastNoiseLite.RETURN_DISTANCE2_DIV,
}

func _configure():
	mapping = {
		"distance_function": {
			"control": $VBoxContainer/DistanceFunction/OptionButton,
			"values": DISTANCE_FUNCTION
		},
		"jitter": {
			"control": $VBoxContainer/Jitter/SpinBox
		},
		"return_type": {
			"control": $VBoxContainer/ReturnType/OptionButton,
			"values": RETURN_TYPE
		}
			
	}
