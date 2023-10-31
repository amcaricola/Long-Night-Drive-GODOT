extends CharacterBody2D
class_name player

enum StreetPositions{LEFT, CENTER , RIGHT}

@export var LeftPosition : Node2D
@export var CenterPosition : Node2D
@export var RightPosition : Node2D
@onready var AnimationPLayer : AnimatedSprite2D = $AnimatedSprite2D
@onready var EngineSound : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var CollisionShape : CollisionShape2D = $CollisionShape2D

#Control Variables
static var instance : player 
var PlayerActualPosition : StreetPositions = StreetPositions.CENTER

func _ready():
	instance = self
	visible = true
	EngineSound.play()
	self.position = CenterPosition.position
	PlayerActualPosition = StreetPositions.CENTER
	AnimationPLayer.play("Moving")

func _physics_process(delta):
	_CheckMovement()


func _CheckMovement():
	if Input.is_action_just_pressed("PlayerLeft"):
		if PlayerActualPosition == StreetPositions.CENTER:
			PlayerActualPosition = StreetPositions.LEFT
			_MoveTo(LeftPosition.position)
			return
		if PlayerActualPosition == StreetPositions.RIGHT:
			PlayerActualPosition = StreetPositions.CENTER
			_MoveTo(CenterPosition.position)
			return

	if Input.is_action_just_pressed("PlayerRight"):
		if PlayerActualPosition == StreetPositions.LEFT:
			PlayerActualPosition = StreetPositions.CENTER
			_MoveTo(CenterPosition.position)
			return
			
		if PlayerActualPosition == StreetPositions.CENTER:
			PlayerActualPosition = StreetPositions.RIGHT
			_MoveTo(RightPosition.position)
			return			



func _MoveTo(newPosition : Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",newPosition, 0.4 ).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)

