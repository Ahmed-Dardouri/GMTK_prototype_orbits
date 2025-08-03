extends Area2D

signal failed()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		emit_signal("failed")
		


func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		emit_signal("failed")
