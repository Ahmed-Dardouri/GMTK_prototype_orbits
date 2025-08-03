extends CharacterBody2D


@export var MASS := 100
@export var sprite_texture : Texture
@export var collision_disabled : bool = true

@onready var arrow := $Arrow
@onready var button := $Button
@onready var sprite := $Sprite2D
@onready var Collision_shape : CollisionShape2D = $CollisionShape2D
signal collided


var drooped_pos : Vector2 = Vector2.ZERO

var simulation_started := false
var drag_drop : bool = false

var sum_acceleration : Vector2 = Vector2.ZERO
var acceleration : Vector2 = Vector2.ZERO



func _ready() -> void:
	var scale_multiplier : float = sqrt(MASS/100.0) / 4
	sprite.texture = sprite_texture
	sprite.scale *= 0.28

	
	Collision_shape.disabled = collision_disabled
	drooped_pos = position
	scale *= scale_multiplier
	
	arrow.scale /= scale_multiplier*2

	set_arrow_visibile(true)

func _physics_process(delta: float) -> void:
	if simulation_started:
		velocity += sum_acceleration * delta
		sum_acceleration = Vector2.ZERO
		move_and_slide()
		check_collisions()

func _process(delta: float) -> void:
	if drag_drop == true && simulation_started == false:
		global_position = get_global_mouse_position()

func apply_godly_force(force: Vector2):
	sum_acceleration += force / MASS

func _on_button_button_down() -> void:
	drag_drop = true
	pass # Replace with function body.

func _on_button_button_up() -> void:
	drag_drop = false
	drooped_pos = position
	pass # Replace with function body.

func start_simulation() -> void:
	simulation_started = true
	if arrow != null :
		sum_acceleration += arrow.force_vector *100
		set_arrow_visibile(false)
	button.visible = false
	
func stop_simulation() -> void:
	position = drooped_pos
	simulation_started = false
	set_arrow_visibile(true)
	button.visible = true
	velocity = Vector2.ZERO
	
func set_arrow_visibile(value : bool) -> void:
	if arrow.enable_force :
		arrow.visible = value
	else:
		arrow.visible = false

func enable_initial_force(value : bool) -> void:
	arrow.set_force(value)
	set_arrow_visibile(value)


func check_collisions() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is CharacterBody2D:
			emit_signal("collided")
