extends Area2D

@export var rise_speed: float = 15.0 
@export var max_height: float = -1000.0 
@onready var animate_2d = $AnimatedSprite2D 

var rising = false

func _ready():
	animate_2d.play("default")


func start_rising():
	rising = true  

func _process(delta):
	if rising:
		if position.y > max_height:
			position.y -= rise_speed * delta  
		else:
			rising = false  
func _on_Lava_body_entered(body):
	if body.name == "Player": 
		body.take_damage(body.health) 
		body.burn()
