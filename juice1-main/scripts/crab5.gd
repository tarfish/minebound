extends CharacterBody2D


var activation_range: float = 100

const speed = 30
var is_frog_chase: bool = true
@onready var healthBar = $HealthBar
@onready var detection_area = $DetectionArea  

var health := 140
var health_max = 140
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
	$AnimatedSprite2D.play("idle")

func die_to_lava():
	for body in attack_area.get_overlapping_bodies():
		if body.is_in_group("lava"):
			health = 0
	
func take_damage(damage: int):
	if health > 0:
		
		health -= damage
		healthBar.change_health(-damage)
		$AnimatedSprite2D.play("hurt")
		set_physics_process(false)
	
	if health <= 0:
		$AnimatedSprite2D.play("death")
		set_process(false)
		set_physics_process(false)
		

func _process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0
	
	player = Global.playerBody
	move(delta)
	handle_animation()
	move_and_slide()
	die_to_lava()
	
	
func move(delta):
	if !dead:
		if !is_frog_chase:
			velocity += dir * speed * delta
		elif is_frog_chase and !taking_damage and player_in_area and player:
			var dir_to_player = position.direction_to(player.position) * speed
			velocity.x = dir_to_player.x
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
		
		
		if dir.x == 1:
			anim_sprite.play("right walk" if player_in_area else "idle")
		elif dir.x == -1:
			anim_sprite.play("left walk" if player_in_area else "idle")
	elif !dead and taking_damage and !is_dealing_damage:
		anim_sprite.play("hurt")
		await get_tree().create_timer(0.8).timeout
		taking_damage = false
	elif !taking_damage and player_in_area and is_dealing_damage:
			
			if dir.x == -1:
				$AnimatedSprite2D.play("left attacking")
				get_node("AttackArea/right").disabled = false
				get_node("AttackArea/left").disabled = false
			if dir.x == 1:
				$AnimatedSprite2D.play("right attacking")
				get_node("AttackArea/left").disabled = false
				get_node("AttackArea/right").disabled = false
	elif dead and is_roaming:
		is_roaming = false
		anim_sprite.play("death")
		await get_tree().create_timer(1.0).timeout
		handle_death()

func handle_death():
	set_process(false)
	
	
	
	
	

func _on_detection_timer_timeout():
	$DirectionTimer.wait_time = choose([1.5,2.0,2.5])
	if !is_frog_chase:
		dir = choose([Vector2.RIGHT , Vector2.LEFT])
		velocity.x = 0

func choose(array):
	array.shuffle()
	return array.front()

@export var damage_to_player := 20
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


func _on_animated_sprite_2d_animation_finished():
	if health <= 0:
		Global.crab5 = true
		self.queue_free()
