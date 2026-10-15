class_name Bullet
extends Area2D

## Tiro básico do jogador.

const SPEED := 480.0
const SIZE := Vector2(10, 3)


func _ready() -> void:
	collision_layer = 2
	collision_mask = 0
	monitoring = false
	var shape := CollisionShape2D.new()
	var rect := RectangleShape2D.new()
	rect.size = SIZE
	shape.shape = rect
	add_child(shape)


func _physics_process(delta: float) -> void:
	position.x += SPEED * delta
	if position.x > 660.0:
		queue_free()


func _draw() -> void:
	draw_rect(Rect2(-SIZE / 2.0, SIZE), Color(1.0, 0.95, 0.5))
