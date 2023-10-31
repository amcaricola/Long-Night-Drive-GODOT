extends Node2D
class_name  lndmanager

signal ElevateDificulty

@export var GameVelocity : int
@export var Stret1 : Node2D
@export var Stret2 : Node2D
@export var GameTimeLabel : Label
@export var GameSpeedLabel : Label
@export var MonsterInTheMirror : AnimatedSprite2D
@export var music : AudioStreamPlayer2D 
@export var PlayerHitSound : AudioStreamPlayer2D 
@export var screamer : TextureRect

#OTHERS VAR
@onready var ColosalDarkness : AnimatedSprite2D = $ColossalMonster/ColosalDarkness
@onready var ColosalMonsterManager : Node2D = $ColossalMonster
	
#Control variables
static var instance : lndmanager
var GameTime : float = 0
var minutes : int = 0
var seconds : int = 0 
var internalSignal : bool = false
var internalLife : int = 4  

func _init():
	instance = self


func _ready():
	_updateDarknessSprite()
	music.play()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_updateTimeAndSpeed()
	_updateGameVelocity()
	_MoveStreets()
	_Win()
	
func _updateTimeAndSpeed():
	GameTime += get_process_delta_time() * 6 if !GameManager.instance else get_process_delta_time() * GameManager.instance.dificultyTime
	minutes = int(GameTime / 60)
	seconds = int(GameTime - (minutes * 60))
	var theTime = {
		"minutes" : minutes,
		"seconds" : "0%s" %seconds if seconds <= 9 else "%s" %seconds
		}
	GameTimeLabel.text = "TIME: 0{minutes}:{seconds}".format(theTime)
	var speed = GameVelocity * 10
	GameSpeedLabel.text = "%s MPH" %speed

func _updateGameVelocity():
	if internalLife == 0:
		ColosalMonsterManager.position.y -= GameVelocity
	if seconds == 0 or seconds == 30:
		if internalSignal: 
			return
		else:
			internalSignal = true
			GameVelocity += 1
			if seconds == 30:
				ElevateDificulty.emit()
	else:
		internalSignal =false

func _MoveStreets():
	if Stret1.position.y >= 1150:
		var newpositionY = Stret2.position.y - 1180
		Stret1.position.y = newpositionY
		
	if Stret2.position.y >= 1150:
		var newpositionY = Stret1.position.y - 1180
		Stret2.position.y =newpositionY
		
	Stret1.position.y += GameVelocity
	Stret2.position.y += GameVelocity


func _updateDarknessSprite():
	ColosalDarkness.play("Iddle")

func _playerWasHit():
	internalLife -= 1
	PlayerHitSound.play()
	screamer.visible = true
	var screamertimer = get_tree().create_timer(.1)
	await  screamertimer.timeout
	screamer.visible = false
	if internalLife == 3:
		MonsterInTheMirror.play("M1")
	if internalLife == 2:
		MonsterInTheMirror.play("M2")
	if internalLife == 1:
		MonsterInTheMirror.play("M3")
	if internalLife == 0:
		var timer = get_tree().create_timer(.5)
		await  timer.timeout
		player.instance.visible = false
		GameManager.instance._ChangeScene(3)



func _Win():
	if minutes == 6:
		GameManager.instance._ChangeScene(4)
