extends TextureRect

func drawFromSettings(settings: Settings):
	var noise = FastNoiseLite.new()
	var noise_parameters = settings.get_noise_parameters()
	for key in noise_parameters: noise.set(key, noise_parameters[key])
	texture = NoiseTexture2D.new()
	texture.height = settings.noise.size.y
	texture.width = settings.noise.size.x
	texture.noise = noise

	await texture.changed
