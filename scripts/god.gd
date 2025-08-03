extends Node2D

signal simulation_stopped
signal simulation_started

@onready var god = $"."
const GRAVITY = 200
var simulation_ongoing := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if simulation_ongoing == true:
		apply_gravity_to_all()


func apply_gravity_to_all() -> void:
	for body in god.get_children():
		apply_gravity(body)
		pass

func apply_gravity(celestial_body : CharacterBody2D):
	for other_body in god.get_children():
		if(celestial_body != other_body):
			var direction = other_body.position - celestial_body.position
			var distance = celestial_body.position.distance_to(other_body.position)
			var force = GRAVITY * celestial_body.MASS * other_body.MASS / (distance)
			var force_vector = force * direction.normalized()
			celestial_body.apply_godly_force(force_vector)
	pass


func start_simulation() -> void:
	simulation_ongoing = true
	for body in god.get_children():
		body.start_simulation()
	emit_signal("simulation_started")
	
func stop_simulation() -> void:
	simulation_ongoing = false
	for body in god.get_children():
		body.stop_simulation()
	emit_signal("simulation_stopped")


func play_stop() -> bool:
	if simulation_ongoing:
		stop_simulation()
		return false
	else:
		start_simulation()
		return true

func failed() -> void:
	stop_simulation()
	
