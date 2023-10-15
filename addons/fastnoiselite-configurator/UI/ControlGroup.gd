@tool
extends Node

class_name ControlGroup

signal value_changed(value: Variant)

@onready
var mapping: Dictionary

func _configure():
	pass

var _storage = {}

func _set(property, v):
	if !mapping.has(property): 
		return false

	_storage[property] = v

	var config = mapping[property]
	var control = config["control"]

	if control is MenuButton or control is OptionButton:
		var values = config["values"] if config.has("values") else {}
		var key = values.find_key(v)
		if (null == key):
			push_warning("Unknown key \"%s\"" % key)
			control.text = "<empty>"
		else:
			control.text = key.capitalize()

	emit_signal("value_changed", value)

	return true

func _get(property):
	if property in mapping.keys():
		return _storage.get(property) 

var value: Dictionary:
	set(v): 
		for property in v.keys():
			if mapping.has(property):
				_set_control_value(property, v[property])
				self[property] = v[property]
			else:
				push_warning("Ignored value %s for property \"%s\"" % [property, v])
	get: 
		return _storage.duplicate(true)

func _ready():
	_configure()
	for property in mapping.keys(): _configure_control(property)

func _set_control_value(property: String, v: Variant):
	var control = mapping[property]["control"]
	
	if control is CheckButton:
		control.button_pressed = v
	elif control is SpinBox:
		control.set_value_no_signal(v)
	elif control is MenuButton or control is OptionButton:
		var popup = control.get_popup()
		for i in popup.item_count: popup.set_item_checked(i, false)
		popup.set_item_checked(popup.get_item_index(v), true)
	elif control is ControlGroup:
		control.value = v
	else:
		push_warning("Unhandled control")

func _configure_control(property: String):
	var config = mapping[property]
	var control = config["control"]
	
	if control is CheckButton:
		_configure_toggle(control, property)
	elif control is SpinBox:
		_configure_spin_box(control, property)
	elif control is MenuButton or control is OptionButton:
		_configure_selector_popup(control.get_popup(), property, config["values"] if config.has("values") else {})
	elif control is ControlGroup:
		control.connect("value_changed", func(v): self[property] = v)
	else:
		push_warning("Unhandled control")
	
func _configure_spin_box(spin_box: SpinBox, property: String):
	spin_box.connect("value_changed", func(v): self[property] = v)
	
func _configure_toggle(toggle_button: CheckButton, property: String):
	toggle_button.connect("toggled", func(v): self[property] = v)

func _configure_selector_popup(popup: PopupMenu, property: String, values: Dictionary):
	popup.clear()
	for key in values: popup.add_radio_check_item(key.capitalize(), values[key])

	popup.connect("id_pressed", func(v): self[property] = v)

