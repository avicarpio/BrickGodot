extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var forceQuantity = 500
	var vectorForce = Vector2(forceQuantity,0)
	vectorForce = vectorForce.rotated(randf_range(-360,360))
	self.linear_velocity = vectorForce
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
