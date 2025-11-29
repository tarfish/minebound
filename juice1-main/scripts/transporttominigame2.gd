extends Area2D
@onready var anim_sprite = $AnimatedSprite2D
@export var target_scene: String 

func _ready():
	connect("body_entered", _on_body_entered)
	anim_sprite.play("default")
	 
	

	

func _on_body_entered(body):
	if body.is_in_group("player"):  
			call_deferred("change_scene")
func change_scene():
	print(Global.done1)
	if Global.done3 == false:
		target_scene = "res://scenes/minigame3.tscn"
	if Global.done3 == true and Global.done4 == false:
		target_scene = "res://scenes/minigame4.tscn"
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file(target_scene)
