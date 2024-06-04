extends Node

@export var life = 10
@onready var lifeText = $LifeText
@onready var bounceSound = $"../BounceSound"
@onready var die_timer = $"../DieTimer"
@onready var collision_shape_2d = $"../CollisionShape2D"
@onready var box_sprite = $"../CollisionShape2D/BoxSprite"
@onready var life_text = $LifeText

var bounceSounds:Array[Resource]

func _ready():
	lifeText.text = str(life)
	
	for filePath in DirAccess.get_files_at("res://Audio/SFX/"):
		if filePath.get_extension() == "mp3":
			bounceSounds.append(load("res://Audio/SFX/" + filePath))

func _on_body_entered(body):
	if(life > 0):
		bounceSound.stop()
		bounceSound.stream = bounceSounds[randi_range(0,bounceSounds.size() - 1)]
		bounceSound.play()
		life -= 1
		life = max(0,life)
		lifeText.text = str(life)
		if life == 0:
			Die()

func Die():
	die_timer.start()
	box_sprite.queue_free()
	life_text.queue_free()
	collision_shape_2d.queue_free()
	get_parent().get_parent().spawnBall(get_parent().position)

func _on_die_timer_timeout():
	get_parent().queue_free()
