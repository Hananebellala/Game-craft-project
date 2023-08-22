extends Sprite2D

var speed_bullet =300

var X_dir=0
var Y_dir=0
var move_dir= Vector2(Input.get_action_strength("right"),Input.get_action_strength("left"))
var velocity_bullet
#func _ready():
	#scale = Vector2(.1, .1)

func _physics_process(delta):
	
	velocity_bullet.x=X_dir
	velocity_bullet.y=Y_dir
	
	move_and_collide()
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
