extends CharacterBody2D

@onready var bullet = preload("res://scenes/sprite_2d.tscn")
@export var speed : float = 300.0
@export var jump_velocity : float = -200.0
@export var double_jump_velocity : float =-200.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false

var b
var bullet_set="right"

var enemy_attack = false
var enemy_attack_cooldown =true
var health = 100
var player_alive = true
var player_current_attack = false
var attack_ip = false

@onready var anim= get_node("AnimationPlayer")

func _physics_process(delta):
	
	
	move(delta)
	enemy_attacking()
	shoot()
	if health<=0:
		player_alive=false
		health = 0
		
		
	
	
	move_and_slide()
func move(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		has_double_jumped=false

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if  is_on_floor():
			velocity.y = jump_velocity
			
		elif not has_double_jumped:
			velocity.y=double_jump_velocity
			has_double_jumped=true
		
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	
	if direction == -1 :
		get_node("AnimatedSprite2D").flip_h =true
	elif direction == 1 :
		get_node("AnimatedSprite2D").flip_h =false
	if direction :
		
		velocity.x = direction * speed
		anim.play("run")
		
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
		anim.play("idle")

func shoot():
	var direction = Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("shoot"):
		if direction == -1:
			bullet_set="left"
		attack_ip=true
		global.player_current_attack = true
		b = bullet.instantiate( )
		get_parent().add_child(b)
		b.global_position = $Marker2D.global_position
		$deal_attack_timer.start()
		
func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_attack = true
		


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_attack = false

func enemy_attacking():
	if enemy_attack and enemy_attack_cooldown == true:
		health = health-20
		enemy_attack_cooldown =false
		$attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true


func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack=false
	attack_ip=false
