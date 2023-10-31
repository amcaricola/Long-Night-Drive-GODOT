extends Node2D

@export var MonsterSpam : monsterSpam
@export var Alerts : Array[Node2D]
# Called when the node enters the scene tree for the first time.
func _ready():
	MonsterSpam.SpamingPosition.connect(_ActivateAlert)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _ActivateAlert(PositionSpam : int):
	Alerts[PositionSpam].visible = true
	var timer = get_tree().create_timer(0.5)
	await timer.timeout
	Alerts[PositionSpam].visible = false
	pass
