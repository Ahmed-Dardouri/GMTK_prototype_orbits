extends Node

@onready var god := $god
@onready var sandbox := $sandbox
@onready var bodies := $Bodies
@onready var ui := $UI
@onready var timer := $Timer

const MAX_LEVEL = 6
var level :int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_god_signals()
	connect_ui_signals()
	connect_sandbox_signals()
	start_level()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_god() -> Node2D:
	return god

func connect_sandbox_signals() -> void:
	for box in sandbox.get_children():
		box.failed.connect(god.failed)

func start_level()-> void:
	set_god_children()
	timer.start()
	

func hide_bodies() -> void:
	for body in bodies.get_children():
		body.visible = false

func clone_body(source: CharacterBody2D) -> Node2D:
	var new_body = preload("res://scenes/celestialBody.tscn").instantiate()
	new_body.global_position = source.global_position
	new_body.rotation = source.rotation
	
	new_body.MASS = source.MASS
	new_body.sprite_texture = source.sprite_texture
	
	new_body.collision_disabled = false
	
	return new_body

func set_god_children() -> void:
	for god_child in god.get_children():
		god_child.queue_free()
	
	for index in range(level + 2):
		var new_body = clone_body(bodies.get_child(index))
		god.add_child(new_body)

	for god_child in god.get_children():
		god_child.visible = true

func set_UI() -> void:
	ui.set_UI_bodies(god.get_children())
	ui.reset_simulation()

func pass_level():
	if level < MAX_LEVEL:
		level += 1

func connect_ui_signals():
	ui.next_level_request.connect(load_next_level)
	
func connect_god_signals():
	god.simulation_started.connect(simulation_started_handler)
	god.simulation_stopped.connect(simulation_stopped_handler)

func simulation_started_handler():
	pass

func simulation_stopped_handler():
	ui.reset_simulation()
	
func load_next_level():
	pass_level()
	start_level()


func _on_timer_timeout() -> void:
	set_UI()
