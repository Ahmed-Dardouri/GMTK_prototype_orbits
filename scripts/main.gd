extends Node

@onready var home := $Home_screen
@onready var game := $Game
@onready var settings := $Settings
@onready var rules := $Rules
@onready var music := $music
@onready var sfx := $sfx
enum screen {  
	HOME,      
	GAME,  
	SETTINGS,
	RULES,
}  

var sfx_explosion = preload("res://audio/explosion.wav")
var sfx_lvl_passed = preload("res://audio/level_passed.wav")
var sfx_click = preload("res://audio/sound_click.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_home_signals()
	connect_game_signals()
	connect_settings_signals()
	load_volume_settings()
	connect_rules_signals()
	set_sliders()
	switch_to(screen.HOME)
	connect_click_sounds($".")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func connect_home_signals():
	home.play.connect(restart_game)
	home.settings.connect(load_settings)
	home.rules.connect(load_rules)
	home.exit.connect(exit_game)

func connect_settings_signals():
	settings.back.connect(load_back)
	settings.music_set.connect(set_music_volume)
	settings.sfx_set.connect(set_sfx_volume)
	
func connect_rules_signals():
	rules.back.connect(load_back)

func connect_game_signals():
	game.explosion_sfx.connect(play_explosion_sfx)
	game.lvl_passed_sfx.connect(play_lvl_passed_sfx)
	game.level_loaded.connect(update_button_click_sounds)

func restart_game():
	switch_to(screen.GAME)
	connect_click_sounds($".")
	
func play_explosion_sfx():
	sfx.stream = sfx_explosion
	sfx.play()

func play_lvl_passed_sfx():
	sfx.stream = sfx_lvl_passed
	sfx.play()

func switch_to(value: screen):
	match value:
		screen.HOME : 
			game.hide()
			home.show()
			settings.hide()
			rules.hide()
		screen.GAME : 
			game.show()
			home.hide()
			settings.hide()
			rules.hide()
		screen.SETTINGS : 
			game.hide()
			home.hide()
			settings.show()
			rules.hide()
		screen.RULES :
			game.hide()
			home.hide()
			settings.hide()
			rules.show()
		_:
			pass
			
func load_settings():
	switch_to(screen.SETTINGS)

func load_rules():
	switch_to(screen.RULES)
	
func exit_game():
	get_tree().quit()

func load_back():
	switch_to(screen.HOME)

func set_music_volume(value: float):
	music.volume_db = value
	_save_volume_settings()
	
func set_sfx_volume(value: float):
	sfx.volume_db = value
	_save_volume_settings()
	
func _save_volume_settings():
	var f = FileAccess.open("user://settings.cfg", FileAccess.WRITE)
	f.store_line(str(music.volume_db))
	f.store_line(str(sfx.volume_db))
	f.close()

func load_volume_settings():
	if FileAccess.file_exists("user://settings.cfg"):
		var f = FileAccess.open("user://settings.cfg", FileAccess.READ)
		music.volume_db = float(f.get_line())
		sfx.volume_db = float(f.get_line())
		f.close()

func set_sliders():
	settings.set_sfx_slider(sfx.volume_db)
	settings.set_music_slider(music.volume_db)



func connect_click_sounds(node):
	for child in node.get_children():
		if child is Button:
			child.pressed.connect(play_click_sound)
		elif child.has_method("get_children"):  # recurse
			connect_click_sounds(child)

func play_click_sound():
	sfx.stream = sfx_click
	sfx.play()

func update_button_click_sounds():
	connect_click_sounds($".")
