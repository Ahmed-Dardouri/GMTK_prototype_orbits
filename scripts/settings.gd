extends Control

signal back
signal music_set(value: float)
signal sfx_set(value: float)

@onready var music_slider := $PanelContainer/VBoxContainer/Musicpanel/MarginContainer/Music_hbox/Music_slider
@onready var sfx_slider := $PanelContainer/VBoxContainer/Sfxpanel/MarginContainer/Sfx_hbox/Sfx_slider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	emit_signal("back")


func _on_music_slider_value_changed(value: float) -> void:
	emit_signal("music_set", value)


func _on_sfx_slider_value_changed(value: float) -> void:
	emit_signal("sfx_set", value)
	
	
func set_sfx_slider(value: float):
	sfx_slider.value = value


func set_music_slider(value: float):
	music_slider.value = value
