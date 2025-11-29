extends Area2D
@onready var animated_sprite1 = $AnimatedSprite2D


func _ready():
	animated_sprite1.play("default")




func _on_body_entered(body):
	if "Player" in body.name:
		body.take_damage(100)
		body.burn()
	if body.is_in_group("enemies") and !body.is_in_group("enemymaxx"):
		body.take_damage(body.health)
		
