extends Node2D
class_name ColosalMonster

@onready var SelfArea : Area2D =  get_child(0)
@onready var Animator : AnimatedSprite2D = $Area2D/AnimatedSprite2D
@onready var MonsterSound : AudioStreamPlayer2D = $Area2D/AudioStreamPlayer2D
@export var positions : Array[Node2D]

#control variables
var lndManager : lndmanager 
var Player : player
var MSpam : monsterSpam
var CDForAtack : int = 10
var atacking : bool = false
var streetPosition : player.StreetPositions = 1
var dificulty : int = 1
var AlreadyHit: bool = false

	

# Called when the node enters the scene tree for the first time.
func _ready():
	lndManager = lndmanager.instance
	
	MSpam = monsterSpam.instance
	Animator.play("iddle")
	SelfArea.body_entered.connect(_bodyEnter)
	_Atack()
	pass # Replace with function body.


func _process(delta):
	if !Player:
		Player = player.instance
	if Player && !atacking &&  (streetPosition != Player.PlayerActualPosition || self.position.x != Player.position.x) :
		_moveToPlayer(Player.PlayerActualPosition)
	if lndManager.internalLife == 0:
		Animator.play("Atack")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _Atack():
	dificulty = 1 if !MSpam else MSpam.Dificulty
	var TimeforAtack = randi_range( 2 , CDForAtack / dificulty) 
	var timer = get_tree().create_timer(TimeforAtack)
	await timer.timeout
	var timer2 = get_tree().create_timer(2)
	Animator.play("Atack")
	MonsterSound.play()
	atacking = true
	_atackthePlayer()
	await timer2.timeout
	Animator.play("iddle")
	atacking = false
	AlreadyHit = false
	_Atack()

func _atackthePlayer():
	var tween = get_tree().create_tween()
	await tween.tween_property(self,"position",Vector2(self.position.x,-100 ),1 ).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	
	await tween.tween_property(self,"position",Vector2(self.position.x,0 ),0.75 ).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	pass

func _moveToPlayer(poss : int):
	var newPosition : Vector2 = positions[poss].position
	streetPosition = poss
	var tween = get_tree().create_tween()
	await tween.tween_property(self,"position",newPosition,1.5 ).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)

	
	
func _bodyEnter(node):
	if node is player && !AlreadyHit && lndManager.internalLife > 0:
		AlreadyHit = true
		lndManager._playerWasHit()

