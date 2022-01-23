tool
extends Node2D


export var speed:= 50
export var min_length:= 10
export var max_length:= 50
export var pause_seconds:= 0.5


onready var player:= $Player
onready var fishy:= $Fishy
onready var harpoon := $Harpoon
onready var chain:= $Chain

onready var direction: Vector2 = player.position.direction_to(fishy.position)

onready var start_player_position: Vector2 = player.position


func _ready() -> void:
	harpoon.rotation = direction.angle() - PI / 2
	update_chain()


func _physics_process(_delta: float) -> void:
	update_chain()
	

func update_chain() -> void:
	chain.points = PoolVector2Array([player.position, harpoon.position])
	
	

