@tool
extends Control

var settings: Settings

const CONFIG_FILE = "user://fastnoiselite-configurator.data"

enum NOISE_TYPE {
	VALUE = FastNoiseLite.TYPE_VALUE,
	CUBIC = FastNoiseLite.TYPE_VALUE_CUBIC,
	PERLIN = FastNoiseLite.TYPE_PERLIN,
	CELLULAR = FastNoiseLite.TYPE_CELLULAR,
	SIMPLEX = FastNoiseLite.TYPE_SIMPLEX,
	SIMPLEX_SMOOTH = FastNoiseLite.TYPE_SIMPLEX_SMOOTH,
}

@onready var noise_settings = $HSplitContainer/TabContainer/Noise
@onready var tool_settings = $HSplitContainer/TabContainer/Tool

@onready var viewport = $HSplitContainer/Viewport/TextureRect

@onready var debug_panel = $DebugInfo

func _ready():	
	settings = Settings.loadFile(CONFIG_FILE)
	
	noise_settings.value = settings.noise
	tool_settings.value = settings.tool
	
	noise_settings.connect("value_changed", func(v): 
		settings.noise = v
		
		draw_preview()
		
		settings.saveFile(CONFIG_FILE)
	)
	
	debug_panel.visible = settings.tool.show_compute_time
	tool_settings.connect("value_changed", func(v): 
		settings.tool = v

		debug_panel.visible = v.show_compute_time

		settings.saveFile(CONFIG_FILE)
	)
	tool_settings.connect("reset", func():
		settings.reset_noise_settings()
		noise_settings.value = settings.noise
		pass
	)
	draw_preview()


func draw_preview():
	var noise = FastNoiseLite.new()
	var noise_parameters = get_noise_parameters()
	for key in noise_parameters: noise.set(key, noise_parameters[key])

	var time = Time.get_ticks_msec();
	var image = noise.get_image(settings.noise.size.x, settings.noise.size.y)
	
	viewport.texture = ImageTexture.create_from_image(image)
	
	var elapsed_time = Time.get_ticks_msec() - time;
	debug_panel.compute_time = elapsed_time;
	tool_settings.code_snippet = format_settings(noise_parameters)

func format_settings(noise_parameters: Dictionary):
	var output = "{\n"
	for key in noise_parameters.keys():
		var value = noise_parameters[key]
		var modifier
		output += "\t\"%s\": " % key
		if value is int:
			output += "%d" % value
		elif value is float:
			output += "%f" % value
		elif value is bool:
			output += "%s" % "true" if value else "false"
		else: 
			output += "%s" % value
			push_warning("Unknown type for key %s" % key)
		output += ",\n"
	output += "}"

	return output

func get_noise_parameters():
	return {
		"noise_type" 					: settings.noise.noise_type,
		"seed"  						: settings.noise.seed,
		"frequency" 					: settings.noise.frequency,
		"domain_warp_enabled" 			: settings.noise.domain_warp.enabled,
		"domain_warp_amplitude" 		: settings.noise.domain_warp.amplitude,
		"domain_warp_fractal_gain"  	: settings.noise.domain_warp.fractal_gain,
		"domain_warp_fractal_type"  	: settings.noise.domain_warp.fractal_type,
		"domain_warp_frequency" 		: settings.noise.domain_warp.frequency,
		"domain_warp_fractal_octaves" 	: settings.noise.domain_warp.fractal_octaves,
		"domain_warp_type" 			    : settings.noise.domain_warp.type,
		"fractal_type" 				    : settings.noise.fractal.type,
		"fractal_gain" 				    : settings.noise.fractal.gain,
		"fractal_lacunarity" 			: settings.noise.fractal.lacunarity,
		"fractal_octaves" 				: settings.noise.fractal.octaves,
		"fractal_ping_pong_strength" 	: settings.noise.fractal.ping_pong_strength,
		"fractal_weighted_strength" 	: settings.noise.fractal.weighted_strength,
		"cellular_distance_function" 	: settings.noise.cellular.distance_function,
		"cellular_jitter" 				: settings.noise.cellular.jitter,
		"cellular_return_type" 		    : settings.noise.cellular.return_type,
	}

