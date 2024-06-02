extends RigidBody2D

var startCollide = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var forceQuantity = 500
	var vectorForce = Vector2(forceQuantity,0)
	vectorForce = vectorForce.rotated(randf_range(-360,360))
	self.linear_velocity = vectorForce
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.linear_velocity.length() < 400 || self.linear_velocity.length() > 600:
		var multiplier = 500/self.linear_velocity.length()
		self.linear_velocity = Vector2(self.linear_velocity.x*multiplier, self.linear_velocity.y*multiplier)
