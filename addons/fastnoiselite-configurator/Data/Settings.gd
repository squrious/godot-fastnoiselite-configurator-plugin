extends Object

class_name Settings

var storage: Dictionary = {
	"noise": {
		"noise_type": FastNoiseLite.TYPE_PERLIN,
		"seed": 0,
		"frequency": 0.01,		
		"size": {
			"x": 512,
			"y": 512
		},
		"domain_warp": {
			"enabled": false,
			"amplitude": 30.0,
			"fractal_gain": 0.5,
			"fractal_type": FastNoiseLite.DOMAIN_WARP_FRACTAL_NONE,
			"fractal_octaves": 5,
			"frequency": 0.05,
			"type": FastNoiseLite.DOMAIN_WARP_SIMPLEX,
		},
		"fractal": {
			"type": FastNoiseLite.FRACTAL_FBM,
			"gain": 0.5,
			"lacunarity": 2.0,
			"octaves": 5,
			"ping_pong_strength": 2.0,
			"weighted_strength": 0.0,
		}, 
		"cellular": {
			"distance_function": FastNoiseLite.DISTANCE_EUCLIDEAN,
			"jitter": 0.45,
			"return_type": FastNoiseLite.RETURN_DISTANCE
		}
	},
	"tool": {
		"show_compute_time": true
	}
}

func _set(property, value):
	if (property in storage.keys()):
		storage[property] = value
		return true
	return false

func _get(property):
	if (property in storage.keys()):
		return storage[property]


func merge(data: Dictionary) -> void:
	_merge_data(storage, data);

func reset_noise_parameters() -> void:
	_merge_data(self.noise, (Settings.new()).noise)

func get_noise_parameters() -> Dictionary:
	return {
		"noise_type" 					: self.noise.noise_type,
		"seed"  						: self.noise.seed,
		"frequency" 					: self.noise.frequency,
		"domain_warp_enabled" 			: self.noise.domain_warp.enabled,
		"domain_warp_amplitude" 		: self.noise.domain_warp.amplitude,
		"domain_warp_fractal_gain"  	: self.noise.domain_warp.fractal_gain,
		"domain_warp_fractal_type"  	: self.noise.domain_warp.fractal_type,
		"domain_warp_frequency" 		: self.noise.domain_warp.frequency,
		"domain_warp_fractal_octaves" 	: self.noise.domain_warp.fractal_octaves,
		"domain_warp_type" 			    : self.noise.domain_warp.type,
		"fractal_type" 				    : self.noise.fractal.type,
		"fractal_gain" 				    : self.noise.fractal.gain,
		"fractal_lacunarity" 			: self.noise.fractal.lacunarity,
		"fractal_octaves" 				: self.noise.fractal.octaves,
		"fractal_ping_pong_strength" 	: self.noise.fractal.ping_pong_strength,
		"fractal_weighted_strength" 	: self.noise.fractal.weighted_strength,
		"cellular_distance_function" 	: self.noise.cellular.distance_function,
		"cellular_jitter" 				: self.noise.cellular.jitter,
		"cellular_return_type" 		    : self.noise.cellular.return_type,
	}
	
static func _merge_data(target: Dictionary, from: Dictionary) -> void:
	for key in from.keys():
		if target.has(key): 
			if from[key] is Dictionary:
				_merge_data(target[key], from[key])
			else:
				target[key] = from[key]

