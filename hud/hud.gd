extends CanvasLayer

signal inicio_juego

func actScore(value):
	$Menu/ScoreLabel.text = str(value)
	
func actTimer(value):
	$Menu/TiempoLabel.text = str(value)

func mostrarMensajeInicio(text):
	$Menu/InicioLabel.text = text
	$Menu/InicioLabel.show()
	$MensajeTimer.start()


func _on_mensaje_timer_timeout():
	$Menu/InicioLabel.hide()


func _on_button_pressed():
	$Menu/Button.hide()
	$Menu/InicioLabel.hide()
	emit_signal("inicio_juego")

func mostrar_gameOver():
	mostrarMensajeInicio("Se acabo el tiempo")
	await $MensajeTimer.timeout
	$Menu/Button.show()
	$Menu/InicioLabel.text = "PERSIGUE LA MONEDA"
	$Menu/InicioLabel.show()
