extends Node2D

const BoxRef = preload("res://Scenes/Box.tscn")

@onready var ballParentRef = get_parent().get_node("BallParent") 

var boxCounter = 0
var boxSize = 3
var level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnBoxes()
	
func _process(_delta):
	if self.get_child_count() == 0:
		boxSize = max(boxSize - 0.3, 0.5)
		spawnBoxes()

func spawnBoxes():
	if ballParentRef.get_child_count() > 1:
		for i in range(1,ballParentRef.get_child_count()):
			ballParentRef.get_child(i).queue_free()
	var viewSize = get_viewport_rect().size
	var howBricksH = floor(viewSize.x/(160*boxSize))
	var howBricksV = floor(viewSize.y/(43.75*boxSize))
	for h in range(0,howBricksH):
		for v in range(0,howBricksV):
			var spawn = randi_range(0,1)
			if spawn == 1:
				var newBox = BoxRef.instantiate()
				newBox.scale.x = boxSize
				newBox.scale.y = boxSize
				newBox.name = "Box" + str(boxCounter)
				self.add_child(newBox)
				var margin = fmod(viewSize.x,(160 * boxSize * howBricksH)) / (howBricksH * 2)
				var outPosX = remap(h, 0, howBricksH, -viewSize.x/2+(160*boxSize)/2, viewSize.x/2+(160*boxSize)/2) + margin
				var outPosY = remap(v, 0, howBricksV, -viewSize.y/2+(43.75*boxSize/2), viewSize.y/2+(43.75*boxSize/2))
				newBox.position = Vector2(outPosX, outPosY)
				boxCounter += 1

