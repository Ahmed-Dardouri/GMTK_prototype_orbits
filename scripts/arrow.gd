extends Node2D
@onready var button := $Button
@onready var line := $Line2D
@onready var base := $base

var force_vector : Vector2 = Vector2.ZERO
@export var enable_force := true

var drag_drop : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_force(enable_force)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if drag_drop:
		button.global_position = get_global_mouse_position()
		line.points[0] = button.position
	pass


func _on_button_button_down() -> void:
	drag_drop = true
	pass # Replace with function body.


func _on_button_button_up() -> void:
	set_force(enable_force)
	drag_drop = false
	pass # Replace with function body.

func set_force(value: bool) -> void:
	enable_force = value
	if enable_force :
		force_vector = button.global_position - base.global_position
	else:
		force_vector = Vector2.ZERO
