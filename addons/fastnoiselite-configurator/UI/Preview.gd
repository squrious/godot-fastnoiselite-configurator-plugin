@tool
extends TextureRect

func drawFromSettings(settings: Settings):
	var noise = FastNoiseLite.new()
	var noise_parameters = settings.get_noise_parameters()
	for key in noise_parameters: noise.set(key, noise_parameters[key])

	var image = noise.get_image(settings.noise.size.x, settings.noise.size.y)
	
	texture = ImageTexture.create_from_image(image)

