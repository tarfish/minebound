extends StaticBody2D

@export var speed: float = 100.0
@export var direction: Vector2 = Vector2.LEFT
@export var max_distance: float = 900

var moving := false
var start_position: Vector2
var moving_forward := true

func _ready():
	start_position = position

func _process(delta):
	if moving:
		
		position += direction * speed * delta if moving_forward else -direction * speed * delta

		
		if position.distance_to(start_position) >= max_distance:
			moving_forward = not moving_forward  
			start_position = position  

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		moving = true
