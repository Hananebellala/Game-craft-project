extends Node2D




var speed : float = 150.0

var player_chase = false
var player = null
var run = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var health = 50
var player_inattack_zone = false
var can_take_damage=true


func _physics_process(delta):
	
	deal_with_damage()
	
	if player_chase==true:
		speed=60
		position += (player.position - position)/speed
		$AnimatedSprite2D.play("run")
		
		if(player.position.x -position.x)<0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.play("Idle")

func _on_detection_area_body_entered(body):
	player=body
	player_chase=true
	run =true
	


func _on_detection_area_body_exited(body):
	player=null
	player_chase=false
	
func enemy():
	pass


func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false
func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		if can_take_damage ==true:
			$take_damage_cooldown.start()
			can_take_damage=false
			health=0
			print("dead")
			if health <=0:
				self.queue_free()
			
		
		
		



	


func _on_take_damage_cooldown_timeout():
	can_take_damage=true
