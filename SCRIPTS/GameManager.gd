extends Node2D
class_name GameManager


@export var SceneManager : Node2D 
@export var GameScenes : Array[PackedScene]
@export var TransitionAnimation : AnimationPlayer 

#controlVariables
static var instance : GameManager
var dificultyTime : int = 2

func _init():
	instance = self

# Called when the node enters the scene tree for the first time.
func _ready():
	TransitionAnimation.play("FadeOut")
	await TransitionAnimation.animation_finished
	await get_tree().create_timer(1).timeout
	_ChangeScene(1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if Input.is_key_pressed(KEY_ESCAPE):
#		get_tree().quit()
	pass


func _ChangeScene( SceneNumber : int) :
	var newScene = GameScenes[SceneNumber].instantiate()
	TransitionAnimation.play("FadeIn")
	await TransitionAnimation.animation_finished
	SceneManager.get_child(0).queue_free()
	SceneManager.add_child(newScene)
	TransitionAnimation.play("FadeOut")
	
	pass
