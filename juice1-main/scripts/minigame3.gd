extends Node2D

var target_scene = "res://scenes/base2.tscn"

func _process(delta):
	change_scene()
func change_scene():
	if Global.crab1 ==true and Global.crab2  == true and Global.crab3 == true and Global.crab4 == true and Global.crab5 == true and Global.crab6==true:
		Global.crab1 = false
		Global.done3 = true
		print("hi")
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_file.bind(target_scene).call_deferred()
