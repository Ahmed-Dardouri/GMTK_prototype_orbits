extends Control

signal play
signal exit

@onready var play_button := $PanelContainer/VBoxContainer/Play_Button
@onready var ctrl_button := $PanelContainer/VBoxContainer/Controls_Button
@onready var exit_button := $PanelContainer/VBoxContainer/Exit_Button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_button_down() -> void:
	emit_signal("play")
	pass # Replace with function body.
