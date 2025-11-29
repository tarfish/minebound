extends StaticBody2D

@export var speed: float = 100.0
@export var direction: Vector2 = Vector2.LEFT
@export var max_distance: float = 700
var moving := false
var start_position: Vector2
func _process(delta):
	if moving:
		position += direction * speed * delta
		if position.distance_to(start_position) >= max_distance:
			moving = false
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"): 
		moving = true
