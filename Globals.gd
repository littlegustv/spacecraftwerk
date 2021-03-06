extends Node2D

const SERVER_PORT = 4000
const MAX_PLAYERS = 8

var player
var game
var player_abilities

var player_info = {}
var my_info = { name: ["Dog", "Bug", "Prawn", "Horse", "Giant"][ randi() % 5 ], color = Color("#ff0000") }

onready var soundtrack = $Soundtrack
onready var game_over_timer = $GameOverTimer

func host():
	player_info[1] = my_info
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(SERVER_PORT, MAX_PLAYERS)
	get_tree().network_peer = peer
	print("HOST")

func join( ip : String ):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, SERVER_PORT)
	get_tree().network_peer = peer
	print("JOIN")

func get_closest( p : Vector2, group : String, exclude : Array = [] ):
	var closest_distance = 100000
	var closest_target = null
	for target in get_tree().get_nodes_in_group( "Enemies" ):
		if exclude.has( target ):
			pass
		elif ( target.position - p ).length() < closest_distance:
			closest_distance = ( target.position - p ).length()
			closest_target = target
	return closest_target

func _player_connected( id ):
	print("PLAYER CONNECTED")
	rpc_id( id, "register_player", my_info )

func _player_disconnected( id ):
	player_info.erase( id )
	print("PLAYER DISCONNECTED")

func _physics_process(delta):
	if Input.is_action_just_pressed("mute_music"):
		AudioServer.set_bus_mute(2, not AudioServer.is_bus_mute(2))
	if Input.is_action_just_pressed("mute_sound"):
		AudioServer.set_bus_mute(1, not AudioServer.is_bus_mute(1))

remote func register_player(info):
	var id = get_tree().get_rpc_sender_id()
	player_info[ id ] = info

func _ready():
	print("READY")
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")

func game_over():
	get_tree().paused = true
	game_over_timer.start()

func _on_Soundtrack_finished():
	soundtrack.play()

func _on_GameOverTimer_timeout():
	get_tree().change_scene("res://MainMenu.tscn")
