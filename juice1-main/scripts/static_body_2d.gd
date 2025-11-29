extends StaticBody2D

@onready var anim_player = $AnimationPlayer

func _ready():
	if get_tree().current_scene.name == "Main":
		anim_player.play("zjump")
		
