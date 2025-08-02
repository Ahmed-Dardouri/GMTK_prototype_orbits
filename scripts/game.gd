extends Node

@onready var god := $god
@onready var sandbox := $sandbox
@onready var bodies := $Bodies

var level :int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_sandbox_signals()
	assert(god != null, "There is no GOD!")
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
	set_UI()

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
	pass
