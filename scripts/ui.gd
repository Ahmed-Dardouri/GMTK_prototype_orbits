extends Control

signal next_level_request


@onready var god : Node2D = %god
@onready var bodies_ui = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/bodies_ui
@onready var play_button = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Button
@onready var counter_label = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Label
@onready var next_lvl = $PanelContainer/MarginContainer/VBoxContainer/level_up_button

var button_Start_text = "Start"
var button_Stop_text = "Stop"
const COUNTER_WIN_CON = 5
var timer_sigmal_emitted : bool = false
var simulation_ongoing : bool = false

var game_mngr : Node

var counter_value : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_counter_value(delta)
	check_timer()
	pass


func _on_button_button_down() -> void:
	if god.play_stop():
		start_simulation()
	else:
		reset_simulation()
	
	
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
			


func start_simulation() -> void:
	counter_value = 0
	simulation_ongoing = true
	timer_sigmal_emitted = false
	play_button.text = button_Stop_text
	counter_label.add_theme_color_override("font_color", Color.WHITE)
	
func reset_simulation() -> void:
	counter_value = 0
	simulation_ongoing = false
	timer_sigmal_emitted = false
	play_button.text = button_Start_text
	counter_label.add_theme_color_override("font_color", Color.WHITE)

func update_counter_value(delta : float) -> void:
	if simulation_ongoing:
		counter_value += delta
		counter_label.text = counter_float2str(counter_value)
	else:
		counter_value = 0

func counter_float2str(counter_value_param: float) -> String:
	var counter_string = "%02d.%02d" % [
		int(counter_value_param),
		int((counter_value_param - int(counter_value_param)) * 100)
	]
	return counter_string

func check_timer() -> void:
	if counter_value > COUNTER_WIN_CON && timer_sigmal_emitted == false:
		timer_sigmal_emitted = true
		counter_label.add_theme_color_override("font_color", Color.GREEN)
		next_lvl.disabled = false

func _on_level_up_button_button_down() -> void:
	emit_signal("next_level_request")
	next_lvl.disabled = true
