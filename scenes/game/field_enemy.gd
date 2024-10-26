extends Node3D

@onready var f2 = $Field2
@onready var f1 = $Field
@onready var f3 = $Field3

# Called when the node enters the scene tree for the first time.
@export var hand : Hand
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	f1.field_identity = Identity.Identity.ENEMY
	f2.field_identity = Identity.Identity.ENEMY
	f3.field_identity = Identity.Identity.ENEMY
	f1.can_drop = true
	
	
func set_hand(_hand : Hand):
	hand = _hand
	f1.hand = hand
	f2.hand = hand
	f3.hand = hand

func _set_identity(indentity : int) :
	if(indentity == Identity.Identity.PLAYER):
		f1.field_identity = Identity.Identity.PLAYER
		f2.field_identity = Identity.Identity.PLAYER
		f3.field_identity = Identity.Identity.PLAYER
	if(indentity == Identity.Identity.ENEMY):
		f1.field_identity = Identity.Identity.ENEMY
		f2.field_identity = Identity.Identity.ENEMY
		f3.field_identity = Identity.Identity.ENEMY

			

# Called every frame. 'delta' is the elapsed time since the previous frame.