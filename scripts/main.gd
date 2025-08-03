extends Node

@onready var home := $Home_screen
@onready var game := $Game

@onready var music := $music
@onready var sfx := $sfx

var sfx_explosion = preload("res://audio/explosion.wav")
var sfx_lvl_passed = preload("res://audio/level_passed.wav")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_home_signals()
	connect_game_signals()
	home.show()
	game.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func connect_home_signals():
	home.play.connect(restart_game)

func connect_game_signals():
	game.explosion_sfx.connect(play_explosion_sfx)
	game.lvl_passed_sfx.connect(play_lvl_passed_sfx)

func restart_game():
	game.show()
	home.hide()
	
func play_explosion_sfx():
	sfx.stream = sfx_explosion
	sfx.play()

func play_lvl_passed_sfx():
	sfx.stream = sfx_lvl_passed
	sfx.play()
