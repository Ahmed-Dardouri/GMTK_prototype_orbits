extends Control

@onready var god : Node2D = %god
@onready var bodies_ui = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/bodies_ui
@onready var play_button = $PanelContainer/MarginContainer/VBoxContainer/Button

var button_Start_text = "Start"
var button_Stop_text = "Stop"

var game_mngr : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_down() -> void:
	god.play_stop()
	toggle_play_button_text()
	
func set_UI_bodies(bodies : Array[Node]):
	if bodies.size() > 0:
		empty_bodies_ui()
		for body in bodies:
			bodies_ui_append(body)

func empty_bodies_ui() -> void:
	for ui in bodies_ui.get_children():
		ui.queue_free()

func bodies_ui_append(body: Node) -> void:
		var body_ui = preload("res://scenes/body_ui.tscn").instantiate()
		body_ui.texture = body.sprite_texture
		body_ui.set_initial_force.connect(body.enable_initial_force)
		bodies_ui.add_child(body_ui)
			
func toggle_play_button_text() -> void:
	if play_button.text == button_Start_text:
		play_button.text = button_Stop_text
	else:
		play_button.text = button_Start_text
