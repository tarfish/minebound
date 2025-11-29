extends CharacterBody2D
var player: CharacterBody2D
const speed = 30
var attack = false


func _process(_delta):
	$AnimatedSprite2D.play("idle")
	


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		set_process(false)
		Global.plantkill = true
		attack = true
		$AnimatedSprite2D.play("attacking")
	

	

	
	


func _on_animated_sprite_2d_animation_finished():
	if attack == true:
		attack = false
		Global.plantanimationdone = true
		$AnimatedSprite2D.play("idle")
		get_tree().reload_current_scene()
		
