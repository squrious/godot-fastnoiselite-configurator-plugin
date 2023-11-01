extends Object

class_name Storage

const PLUGIN_DATA_DIR = 'user://addons/fastnoiselite-configurator'

var root_dir

func _init():
	if not (DirAccess.dir_exists_absolute(PLUGIN_DATA_DIR)):
		DirAccess.make_dir_recursive_absolute(PLUGIN_DATA_DIR)

func saveSettings(path: String, settings: Settings):
	path = _get_plugin_file_path(path, true)
	var fd = FileAccess.open(path, FileAccess.WRITE)
	fd.store_var(settings.storage)
	fd.close()

func loadSettings(path: String) -> Settings:
	var settings = Settings.new();
	path = _get_plugin_file_path(path)
	if FileAccess.file_exists(path):
		var fd = FileAccess.open(path, FileAccess.READ)
		var data = fd.get_var()
		fd.close()
		settings.merge(data)

	return settings;


func _get_plugin_file_path(path: String, create_directory: bool = false) -> String:
	path = PLUGIN_DATA_DIR.path_join(path);	
	if create_directory:
		var dir = path.get_base_dir();
		if not (DirAccess.dir_exists_absolute(dir)):
			DirAccess.make_dir_recursive_absolute(dir)
	return path


