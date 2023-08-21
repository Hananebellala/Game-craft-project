extends CharacterBody2D

@onready var bullet = preload("res://bullet.tscn")
@export var speed : float = 300.0
@export var jump_velocity : float = -200.0
@export var double_jump_velocity : float =-200.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false

var b

@onready var anim= get_node("AnimationPlayer")

func _physics_process(delta):
	
	shoot()
	move(delta)
	
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
	if Input.is_action_just_pressed("shoot"):
		b = bullet.instantiate( )
		get_parent().add_child(b)
		b.global_position = $Marker2D.global_position
	
		

		
		
		
		
		


