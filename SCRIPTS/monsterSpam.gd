extends Node2D
class_name monsterSpam

signal SpamingPosition(positionNumber)

@export var LNDManager : lndmanager
@export var MonstersArray : Array[PackedScene]
@export var postions : Array[Node2D]


#control Variables
var timeForCreation : int = 10
var Dificulty = 1 
static var instance : monsterSpam


func _ready():
	instance = self
	LNDManager.ElevateDificulty.connect(_elevateDificulty)
	_SpamMonster()
	pass

func _elevateDificulty():
	Dificulty += 1 * LNDManager.minutes

func _SpamMonster():
	var timeToCreate = randi_range( 2 , timeForCreation / Dificulty) 
	var timer = get_tree().create_timer(timeToCreate)
	var monster : Monster = _getMonster()
	var spampositionNumber : int = randi_range(0, postions.size() -1)
	var spamPosition : Node2D =  postions[spampositionNumber]
	await timer.timeout
	SpamingPosition.emit(spampositionNumber)
	self.add_child(monster)
	monster.position = spamPosition.position
	monster.streetPosition = spampositionNumber
	_SpamMonster()

func _getMonster() -> Monster:
	var newMonster : Monster
	var number : int = randi_range(0, MonstersArray.size() -1)
	newMonster = MonstersArray[number].instantiate() 
	return newMonster
