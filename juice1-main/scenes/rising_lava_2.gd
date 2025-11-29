extends Area2D

@export var rise_speed: float = 13.0  
@export var max_height: float = -1500.0 
@onready var animate_2d = $AnimatedSprite2D
var rising = true

func _ready():
	animate_2d.play("default")



func _process(delta):
	if rising:
		if position.x > max_height:
			position.x += rise_speed * delta  
		else:
			rising = false 
func _on_Lava_body_entered(body):
	if body.name == "Player": 
		body.take_damage(body.health) 
		body.burn()
