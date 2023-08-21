extends Node2D




var speed : float = 150.0
var player_chase = false
var player = null
var run = false


func _physics_process(delta):
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
