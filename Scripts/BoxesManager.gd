extends Node2D

const BoxRef = preload("res://Scenes/Box.tscn")
const BallRef = preload("res://Scenes/Ball.tscn")

var saveGamePath = "user://savedata.save"

@onready var ball_parent = %BallParent
@onready var levelText = $"../Level"

var boxCounter = 0
var boxSize = 3
var level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	loadGame()
	boxSize = max(boxSize - 0.3*level, 0.5)
	spawnBoxes()
	updateLevelText()
	
func _process(_delta):
	if self.get_child_count() == 0:
		level += 1
		saveGame()
		updateLevelText()
		boxSize = max(boxSize - 0.3*level, 0.5)
		spawnBoxes()

func spawnBoxes():
	if ball_parent.get_child_count() > 1:
		for i in range(1,ball_parent.get_child_count()):
			ball_parent.get_child(i).queue_free()
	var viewSize = get_viewport_rect().size
	var howBricksH = floor(viewSize.x/(160*boxSize))
	var howBricksV = floor((viewSize.y - 300)/(43.75*boxSize))
	for h in range(0,howBricksH):
		for v in range(0,howBricksV):
			var spawn = randi_range(0,1)
			if spawn == 1:
				var newBox = BoxRef.instantiate()
				newBox.get_node("Area2D").life = pow(5,level)
				newBox.scale.x = boxSize
				newBox.scale.y = boxSize
				newBox.name = "Box" + str(boxCounter)
				self.add_child(newBox)
				var margin = fmod(viewSize.x,(160 * boxSize * howBricksH)) / (howBricksH * 2)
				var outPosX = remap(h, 0, howBricksH, -viewSize.x/2+(160*boxSize)/2, viewSize.x/2+(160*boxSize)/2) + margin
				var outPosY = remap(v, 0, howBricksV, -(viewSize.y - 150)/2+(43.75*boxSize/2), (viewSize.y - 150)/2+(43.75*boxSize/2))
				newBox.position = Vector2(outPosX, outPosY)
				boxCounter += 1

func spawnBall(position):
	var newBall = BallRef.instantiate()
	newBall.name = "Ball_" + str(randi_range(0,2147483647))
	newBall.position = position
	ball_parent.call_deferred("add_child", newBall)

func updateLevelText():
	levelText.text = "Level: " + str(level)

func saveGame():
	var file = FileAccess.open(saveGamePath, FileAccess.WRITE)
	file.store_var(level)
	
func loadGame():
	if FileAccess.file_exists(saveGamePath):
			var file = FileAccess.open(saveGamePath, FileAccess.READ)
			level = file.get_var(level)
