extends Node

@export_group("Game Resources")
@export var game_root = preload("res://scenes/game_root/GameRoot.tscn")

@export_group("Buttons")
@export var DeckBuildBtn : Button
@export var SingleGameBtn : Button
@export var OnlineGameBtn : Button
@export var SettingsBtn : Button
@export var ExitBtn : Button
@export var PingBtn : Button

@export_group("Labels")
@export var ping_lbl : Label

var deck_builder_scene: PackedScene

func _ready() -> void:
	DeckBuildBtn.pressed.connect(_on_deck_build_btn_pressed)
	SingleGameBtn.pressed.connect(_on_single_game_btn_pressed)
	OnlineGameBtn.pressed.connect(_on_online_game_btn_pressed)
	ExitBtn.pressed.connect(_on_exit_btn_pressed)
	PingBtn.pressed.connect(_on_ping_btn_pressed)
	SettingsBtn.pressed.connect(_on_settings_btn_pressed)
	
	Server.request_handler.register_scene("Lobby", self)
	
	deck_builder_scene = load("res://scenes/deck_builder/deck_builder.tscn")

func set_ping_lbl(request_time):
	var whole_ping = round((Time.get_unix_time_from_system() - request_time) * 1000)
	ping_lbl.text = str(whole_ping) + " ms"


func _on_ping_btn_pressed() -> void:
	var request = Request.new("Server", "ping", ["Lobby", "set_ping_lbl", Time.get_unix_time_from_system()])
	Server.send_request(request)
	

func _on_online_game_btn_pressed() -> void:
	var request = Request.new("Lobby", "add_queue", [])
	Server.send_request(request)
	
func _on_deck_build_btn_pressed() -> void:
	get_tree().change_scene_to_packed(deck_builder_scene)
	
func _on_single_game_btn_pressed() -> void:
	pass
	
func _on_settings_btn_pressed() -> void:
	Settings2d.show_settings()


func start_online_game(my_id, game_dict: Dictionary):
	var game_root_instance = game_root.instantiate()
	get_tree().root.add_child(game_root_instance)
	game_root_instance.set_data(my_id, game_dict)
	call_deferred("queue_free")

func _on_exit_btn_pressed() -> void:
	get_tree().quit()
