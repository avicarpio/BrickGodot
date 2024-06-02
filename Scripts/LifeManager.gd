extends Node

@export var life = 10
@onready var lifeText = $LifeText

func _ready():
	lifeText.text = str(life)

func _on_body_entered(body):

	life -= 1
	life = max(0,life)
	lifeText.text = str(life)
	if life == 0:
		get_parent().get_parent().spawnBall()
		get_parent().queue_free()
