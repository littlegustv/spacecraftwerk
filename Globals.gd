extends Node2D

const SERVER_PORT = 4000
const MAX_PLAYERS = 8

func host():
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

var player
var game
var player_abilities

var player_info = {}
var my_info = { name: "elsif", color = Color("#ff0000") }

func _player_connected( id ):
	print("PLAYER CONNECTED")
	rpc_id( id, "register_player", my_info )

func _player_disconnected( id ):
	player_info.erase( id )
	print("PLAYER DISCONNECTED")

func _connection_ok():
	print("CONNECTION OK")

func _connection_failed():
	print("CONNECTION FAILED")

func _server_disconnected():
	print("server disconnected.")

remote func register_player(info):
	var id = get_tree().get_rpc_sender_id()
	player_info[ id ] = info

func _ready():
	print("READY")
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connection_ok")
	get_tree().connect("connection_failed", self, "_connection_failed")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
