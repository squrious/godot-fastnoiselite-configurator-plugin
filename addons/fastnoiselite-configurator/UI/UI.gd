extends Control

var storage: Storage = Storage.new()
var settings: Settings
var preview_texture: PreviewTexture

const SETTINGS_FILE = 'settings.dat'
const TEXTURE_RESOURCE = 'noise.tres'

@onready var noise_settings = $HSplitContainer/TabContainer/Noise
@onready var tool_settings = $HSplitContainer/TabContainer/Tool

@onready var viewport = $HSplitContainer/Viewport/TextureRect

@onready var debug_panel = $DebugInfo

func _ready():
	# Tools settings
	settings = storage.loadSettings(SETTINGS_FILE)

	# Rendered preview_texture
	preview_texture = storage.loadTexture(TEXTURE_RESOURCE)

	# Configure viewport texture
	viewport.texture = preview_texture

	noise_settings.value = get_settings_from_texture(preview_texture)
	tool_settings.value = settings.tool
	
	noise_settings.connect("value_changed", func(v): 
		draw_preview()
		storage.saveTexture(TEXTURE_RESOURCE, preview_texture)
	)
	
	debug_panel.visible = settings.tool.show_compute_time
	tool_settings.connect("value_changed", func(v): 
		settings.tool = v
		debug_panel.visible = v.show_compute_time

		storage.saveSettings(SETTINGS_FILE, settings)
	)

	tool_settings.connect("reset", func():
		preview_texture.reset()
		noise_settings.value = get_settings_from_texture(preview_texture)
	)
	
	tool_settings.connect("save_resource", func(path: String):
		ResourceSaver.save(preview_texture.noise, path)
	)

	tool_settings.connect("load_resource", func(path: String): 
		var noise = ResourceLoader.load(path, "FastNoiseLite")
		preview_texture.noise = noise
		noise_settings.value = get_settings_from_texture(preview_texture)
		draw_preview()
	)

	draw_preview()

func draw_preview():
	var time = Time.get_ticks_msec();
	var texture_parameters = get_texture_parameters(noise_settings.value)
	
	preview_texture.apply_settings(texture_parameters)
	await viewport.texture.changed

	var elapsed_time = Time.get_ticks_msec() - time;
	debug_panel.compute_time = elapsed_time;

	tool_settings.snippet_parameters = texture_parameters.noise

func get_texture_parameters(settings: Dictionary):
	return {
		"noise": {
			"noise_type" 					: settings.noise_type,
			"seed"  						: settings.seed,
			"frequency" 					: settings.frequency,
			"domain_warp_enabled" 			: settings.domain_warp.enabled,
			"domain_warp_amplitude" 		: settings.domain_warp.amplitude,
			"domain_warp_fractal_gain"  	: settings.domain_warp.fractal_gain,
			"domain_warp_fractal_type"  	: settings.domain_warp.fractal_type,
			"domain_warp_frequency" 		: settings.domain_warp.frequency,
			"domain_warp_fractal_octaves" 	: settings.domain_warp.fractal_octaves,
			"domain_warp_type" 			    : settings.domain_warp.type,
			"fractal_type" 				    : settings.fractal.type,
			"fractal_gain" 				    : settings.fractal.gain,
			"fractal_lacunarity" 			: settings.fractal.lacunarity,
			"fractal_octaves" 				: settings.fractal.octaves,
			"fractal_ping_pong_strength" 	: settings.fractal.ping_pong_strength,
			"fractal_weighted_strength" 	: settings.fractal.weighted_strength,
			"cellular_distance_function" 	: settings.cellular.distance_function,
			"cellular_jitter" 				: settings.cellular.jitter,
			"cellular_return_type" 		    : settings.cellular.return_type,
		},
		"width": settings.size.x,
		"height": settings.size.y
	}

func get_settings_from_texture(texture: PreviewTexture) -> Dictionary:
	return {
		"noise_type": texture.noise.noise_type,
		"seed": texture.noise.seed,
		"frequency": texture.noise.frequency,		
		"size": {
			"x": texture.width,
			"y": texture.height
		},
		"domain_warp": {
			"enabled": texture.noise.domain_warp_enabled,
			"amplitude": texture.noise.domain_warp_amplitude,
			"fractal_gain": texture.noise.domain_warp_fractal_gain,
			"fractal_type": texture.noise.domain_warp_fractal_type,
			"fractal_octaves": texture.noise.domain_warp_fractal_octaves,
			"frequency": texture.noise.domain_warp_frequency,
			"type": texture.noise.domain_warp_type,
		},
		"fractal": {
			"type": texture.noise.fractal_type,
			"gain": texture.noise.fractal_gain,
			"lacunarity": texture.noise.fractal_lacunarity,
			"octaves": texture.noise.fractal_octaves,
			"ping_pong_strength": texture.noise.fractal_ping_pong_strength,
			"weighted_strength": texture.noise.fractal_weighted_strength,
		}, 
		"cellular": {
			"distance_function": texture.noise.cellular_distance_function,
			"jitter": texture.noise.cellular_jitter,
			"return_type": texture.noise.cellular_return_type
		}
	}
