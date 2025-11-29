extends CharacterBody2D




var activation_range: float = 100

const speed = 150
var is_frog_chase: bool = true
@onready var healthBar = $HealthBar
@onready var detection_area = $DetectionArea  
@export var target_scene: String = "res://scenes/base.tscn"
var health := 250
var health_max = 250
var health_min = 0 

var dead: bool = false
var taking_damage: bool = false
var damage_to_deal = 20
var is_dealing_damage: bool = false

var dir: Vector2
const gravity = 900
var knockback_force = -20
var is_roaming: bool = true

var player: CharacterBody2D
var player_in_area = false  

func _ready():
	healthBar.set_health_bar(health, health_max)
	


func take_damage(damage: int):
	if health > 0:
		
		health -= damage
		healthBar.change_health(-10)
		$AnimatedSprite2D.play("hurt")
		set_physics_process(false)
	
	if health <= 0:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		change_scene()
		self.queue_free()

func _process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0
	
	player = Global.playerBody
	move(delta)
	handle_animation()
	move_and_slide()
	
	
func move(delta):
	if !dead:
		if !is_frog_chase:
			velocity += dir * speed * delta
		elif is_frog_chase and !taking_damage and player_in_area and player:
			var dir_to_player = position.direction_to(player.position) * speed
			velocity.x = dir_to_player.x+ 30
			dir.x = sign(velocity.x)  
		elif taking_damage:
			var knockback_dir = position.direction_to(player.position) * knockback_force
			velocity.x = knockback_dir.x
		
		else:
			velocity.x = 0  
		is_roaming = true
	elif dead:
		velocity.x = 0

func handle_animation():
	var anim_sprite = $AnimatedSprite2D
	if !dead and !taking_damage and !is_dealing_damage:
		anim_sprite.play("walk" if player_in_area else "idle")  
		if dir.x == 1:
			anim_sprite.scale.x = 1
			
		elif dir.x == -1:
			anim_sprite.scale.x = -1
	elif !dead and taking_damage and !is_dealing_damage:
		anim_sprite.play("hurt")
		await get_tree().create_timer(0.8).timeout
		taking_damage = false
	
	elif dead and is_roaming:
		
		print("hi")
		is_roaming = false
		anim_sprite.play("death")
		await get_tree().create_timer(1.0).timeout
		handle_death()

func handle_death():
	
	self.queue_free()
	
	

func _on_detection_timer_timeout():
	$DirectionTimer.wait_time = choose([1.5,2.0,2.5])
	if !is_frog_chase:
		dir = choose([Vector2.RIGHT , Vector2.LEFT])
		velocity.x = 0

func choose(array):
	array.shuffle()
	return array.front()
	
func change_scene():

	get_tree().change_scene_to_file(target_scene)

@export var damage_to_player := 10
@onready var attack_area = $AttackArea  

func _on_attack_area_body_entered(body):
	if body.is_in_group("player"):  
		body.take_damage(damage_to_player)


func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		player_in_area = true
		is_dealing_damage=false
		player = body

func _on_detection_area_body_exited(body):
	if body.is_in_group("player"):
		player_in_area = false
		player = null 

func _on_area_2d_body_entered(_body):
	is_dealing_damage = true
	


func _on_area_2d_body_exited(_body):
	is_dealing_damage = false
