class_name Block extends RigidBody2D

var collision_polygon: CollisionPolygon2D
var collision_shape: CollisionShape2D


func _ready():
	collision_polygon = get_node_or_null("CollisionPolygon2D")
	collision_shape = get_node_or_null("CollisionShape2D")
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 30.0
	timer.connect("timeout", queue_free)
	timer.start()


func change_scale(new_scale: Vector2) -> void:
	$Sprite2D.scale = new_scale
	if collision_polygon:
		collision_polygon.scale = new_scale
	if collision_shape:
		collision_shape.scale = new_scale
