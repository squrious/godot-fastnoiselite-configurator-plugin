extends NoiseTexture2D

class_name PreviewTexture

func reset():
	noise = FastNoiseLite.new()
	width = 512
	height = 512	

func apply_settings(settings: Dictionary) -> void:
	var noise = FastNoiseLite.new()
	var noise_parameters = settings.noise
	for key in noise_parameters: noise.set(key, noise_parameters[key])

	self.height = settings.height
	self.width = settings.width
	self.noise = noise
