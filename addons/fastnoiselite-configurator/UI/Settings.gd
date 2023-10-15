@tool
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


static func loadFile(file: String) -> Settings:
	var settings = Settings.new()
	
	if not FileAccess.file_exists(file):
		return settings

	var fd = FileAccess.open(file, FileAccess.READ)

	var data = fd.get_var()

	merge_data(settings.storage, data)

	fd.close()	
	return settings


func saveFile(file: String):
	var fd = FileAccess.open(file, FileAccess.WRITE)	
	fd.store_var(storage)
	fd.close()

func reset_noise_settings():
	Settings.merge_data(storage.noise, (Settings.new()).noise)

static func merge_data(target: Dictionary, from: Dictionary):
	for key in from.keys():
		if target.has(key): 
			if from[key] is Dictionary:
				merge_data(target[key], from[key])
			else:
				target[key] = from[key]
	pass

