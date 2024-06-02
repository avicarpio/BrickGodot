extends Node

const BallRef = preload("res://Scenes/Ball.tscn")

var life = 10
@onready var ballParentRef = get_parent().get_parent().find_child("BallParent")

func DecreaseLife(howMuch):
	life -= howMuch
	var lifeText = $LifeText
	life = max(0,life)
	lifeText.text = str(life)
	if life == 0:
		var newBall = BallRef.instantiate()
		newBall.name = "Ball_" + str(randi_range(0,2147483647))
		newBall.position = self.position
		ballParentRef.add_child(newBall)
		self.queue_free()
