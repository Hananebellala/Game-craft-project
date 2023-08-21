extends Sprite2D

func _ready():
	scale = Vector2(.1, .1)

func _physics_process(_delta):
	position.x += 10


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
