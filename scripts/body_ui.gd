extends PanelContainer

signal set_initial_force(value : bool)

@onready var checkButton = $MarginContainer/HBoxContainer/CheckButton
@onready var textureRect = $MarginContainer/HBoxContainer/MarginContainer/TextureRect

@export var texture : Texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setTexture(texture)
	setCheckButton(true)


func setCheckButton(value: bool) -> void:
	checkButton.button_pressed = value

func setTexture(texture : Texture) -> void:
	textureRect.texture = texture

func _on_check_button_toggled(toggled_on: bool) -> void:
	emit_signal("set_initial_force", toggled_on) 
