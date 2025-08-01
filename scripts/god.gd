extends Node
@onready var god = $"."
const GRAVITY = 40000
var simulation_started := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if simulation_started == true:
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
			var force = GRAVITY * celestial_body.MASS * other_body.MASS / (distance * distance)
			var force_vector = force * direction.normalized()
			celestial_body.apply_godly_force(force_vector)
	pass

func start_simulation() -> void:
	simulation_started = true
	for body in god.get_children():
		body.start_simulation()
		
func stop_simulation() -> void:
	simulation_started = false
	for body in god.get_children():
		body.stop_simulation()


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			if simulation_started:
				stop_simulation()
			else:
				start_simulation()
