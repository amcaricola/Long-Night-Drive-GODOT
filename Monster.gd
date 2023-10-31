extends Node2D
class_name Monster


@onready var SelfArea : Area2D =  get_child(0)
@onready var DeatSound : AudioStreamPlayer2D = $Area2D/AudioStreamPlayer2D
@onready var Animator : AnimatedSprite2D = $Area2D/AnimatedSprite2D



#contol Variable
var lndManager : lndmanager
var Player : player
var streetPosition : player.StreetPositions

# Called when the node enters the scene tree for the first time.
func _ready():
	SelfArea.body_entered.connect(_bodyEnter)
	lndManager = lndmanager.instance
	Player = player.instance
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.y += lndManager.GameVelocity
	if Player.PlayerActualPosition == self.streetPosition:
		Animator.play("PlayerFocus")
	else:
		Animator.play("Iddle")
	if self.position.y > 1600:
		self.queue_free()
	pass


func _bodyEnter(node):
	if node is player && lndManager.internalLife > 0:
		DeatSound.play()
		lndManager._playerWasHit()
		self.visible = false
