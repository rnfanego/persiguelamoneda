extends Node

@onready var Coin = preload("res://moneda/moneda.tscn")
@export var tiempoJuego : int

var nivel := 1
var score
var time_left
@onready var screensize = Vector2(450,720)
@onready var player = $Player
@onready var HUD = $HUD
var playing = false

func _ready():
	randomize()
	player.ventanaTm = screensize
	player.hide()

func nuevoJuego():
	$InicioAudioStreamPlayer2.play()
	playing = true
	nivel = 1
	score = 0
	time_left = 10
	player.inicio($InicioMarker2D.position)
	player.show()
	$JuegoTimer.start()
	agregaMonedas()
	HUD.actScore(score)
	HUD.actTimer(time_left)

func _process(delta):
	if playing and $ContenedorMonedas.get_child_count() == 0:
		nivel += 1
		time_left += 5
		HUD.actTimer(time_left)
		agregaMonedas()

func agregaMonedas():
	for i in range(4+nivel):
		var coin = Coin.instantiate()
		$ContenedorMonedas.add_child(coin)
		coin.position = Vector2(randf_range(0,screensize.x),randf_range(0,screensize.y))

func _on_juego_timer_timeout():
	time_left -= 1
	HUD.actTimer(time_left)
	if time_left <= 0:
		game_over()

func game_over():
	$MorirAudioStreamPlayer3.play()
	playing = false
	$JuegoTimer.stop()
	for moneda in $ContenedorMonedas.get_children():
		moneda.queue_free()
	HUD.mostrar_gameOver()
	player.morirse()

func _on_player_recolectar():
	$CoinAudioStreamPlayer.play()
	score += 1
	HUD.actScore(score)


func _on_player_herirse():
	$MorirAudioStreamPlayer3.play()
	game_over()
