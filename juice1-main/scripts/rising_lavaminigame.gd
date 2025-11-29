extends Area2D

@export var rise_speed: float = 5  # speed in pixels per second
@export var max_height: float = -1000.0 
@onready var animate_2d = $AnimatedSprite2D 
@onready var animate_2d2 = $AnimatedSprite2D2
@onready var animate_2d3 = $AnimatedSprite2D3
@onready var animate_2d4 = $AnimatedSprite2D4
@onready var animate_2d5 = $AnimatedSprite2D5
@onready var animate_2d6 = $AnimatedSprite2D6
@onready var animate_2d7 = $AnimatedSprite2D7# top point where lava stops rising (adjust as needed)
var rising = true

func _ready():
	animate_2d.play("default")
	animate_2d2.play("default")
	animate_2d3.play("default")
	animate_2d4.play("default")
	animate_2d5.play("default")
	animate_2d6.play("default")
	animate_2d7.play("default")
# This function is called when the player triggers the lava
func start_rising():
	rising = true  # Enable lava rising

func _process(delta):
	if rising:
		if position.y > max_height:
			position.y -= rise_speed * delta  # Move lava up
		else:
			rising = false  # Stop rising once the max height is reached
func _on_Lava_body_entered(body):
	if body.name == "Player": 
		body.take_damage(body.health) 
		body.burn()
