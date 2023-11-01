extends Control


var storage: Storage = Storage.new()
var settings: Settings


const SETTINGS_FILE = 'settings.dat'

@onready var noise_settings = $HSplitContainer/TabContainer/Noise
@onready var tool_settings = $HSplitContainer/TabContainer/Tool

@onready var viewport = $HSplitContainer/Viewport/TextureRect

@onready var debug_panel = $DebugInfo

func _ready():
	settings = storage.loadSettings(SETTINGS_FILE)
	
	noise_settings.value = settings.noise
	tool_settings.value = settings.tool
	
	noise_settings.connect("value_changed", func(v): 
		settings.noise = v
		
		draw_preview()
		
		storage.saveSettings(SETTINGS_FILE, settings)
	)
	
	debug_panel.visible = settings.tool.show_compute_time
	tool_settings.connect("value_changed", func(v): 
		settings.tool = v

		debug_panel.visible = v.show_compute_time

		storage.saveSettings(SETTINGS_FILE, settings)
	)
	tool_settings.connect("reset", func():
		settings.reset_noise_parameters()
		noise_settings.value = settings.noise
	)

	draw_preview()


func draw_preview():
	var time = Time.get_ticks_msec();

	await viewport.drawFromSettings(settings);

	var elapsed_time = Time.get_ticks_msec() - time;
	
	debug_panel.compute_time = elapsed_time;
	tool_settings.snippet_parameters = settings.get_noise_parameters()
