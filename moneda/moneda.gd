extends Area2D

func _ready():
	$InicioTimer.wait_time = randf_range(.1,.5)
	$InicioTimer.start()

func recoger():
	var tween = create_tween()
	var tween2 = create_tween()
	tween.tween_property($AnimatedSprite2D,"scale",Vector2(.1,.1),.3)
	tween2.tween_property($AnimatedSprite2D,"modulate",Color.RED,.3)
	tween.finished.connect(eliminar)
	
func eliminar():
	queue_free()


func _on_inicio_timer_timeout():
	$AnimatedSprite2D.frame = 0
	$AnimatedSprite2D.play()
