@tool
extends EditorPlugin

const SCENE_NAME = "res://addons/fastnoiselite-configurator/fastnoiselite-configurator.tscn"
const MENU_NAME = "Open FastNoiseLite Configurator"
const COMMAND_NAME = "addons/open_fastnoiselite_configurator"

func _enter_tree():
	add_tool_menu_item(MENU_NAME, run_configurator)
	get_editor_interface().get_command_palette().add_command(MENU_NAME, COMMAND_NAME, run_configurator)

func _exit_tree():
	remove_tool_menu_item(MENU_NAME)
	get_editor_interface().get_command_palette().remove_command(COMMAND_NAME)

func run_configurator():
	get_editor_interface().play_custom_scene(SCENE_NAME)
