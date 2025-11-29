extends Area2D

@export var target_scene: String = "res://scenes/base2.tscn"
@onready var anim_sprite = $AnimatedSprite2D
func _ready():
	connect("body_entered", _on_body_entered)
	anim_sprite.play("default")
	

func _on_body_entered(body):
	if body.is_in_group("player"):  
			
			call_deferred("change_scene")
func change_scene():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file(target_scene)
