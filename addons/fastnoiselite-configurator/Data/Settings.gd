extends Object

class_name Settings

var storage: Dictionary = {
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

static func _merge_data(target: Dictionary, from: Dictionary) -> void:
	for key in from.keys():
		if target.has(key): 
			if from[key] is Dictionary:
				_merge_data(target[key], from[key])
			else:
				target[key] = from[key]

