extends Node

@onready var Coin = preload("res://moneda/moneda.tscn")
@export var tiempoJuego : int

var nivel := 1
var score
var time_left
@onready var screensize = Vector2(450,720)
@onready var player = $Player
var playing = false

func _ready():
	randomize()
	player.ventanaTm = screensize
	player.hide()
	nuevoJuego()

func nuevoJuego():
	playing = true
	nivel = 1
	score = 0
	time_left = 0
	player.inicio($InicioMarker2D.position)
	player.show()
	$JuegoTimer.start()
	agregaMonedas()

func _process(delta):
	if playing and $ContenedorMonedas.get_child_count() == 0:
		nivel += 1
		time_left += 5
		agregaMonedas()

func agregaMonedas():
	for i in range(4+nivel):
		var coin = Coin.instantiate()
		$ContenedorMonedas.add_child(coin)
		coin.position = Vector2(randf_range(0,screensize.x),randf_range(0,screensize.y))
