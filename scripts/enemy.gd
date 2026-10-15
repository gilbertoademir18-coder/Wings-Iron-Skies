class_name Enemy
extends Area2D

## Jato amarelo do beta original. Voa para a esquerda seguindo uma senoide;
## como o y depende do x, inimigos da mesma onda formam uma "cobrinha".

signal destroyed(points: int, at: Vector2)

const POINTS := 100

var speed := 130.0
var amplitude := 30.0
var hp := 1
var _base_y := 0.0


func _ready() -> void:
	collision_layer = 4
	collision_mask = 1 | 2
	var shape := CollisionShape2D.new()
	var rect := RectangleShape2D.new()
	rect.size = Vector2(26, 10)
	shape.shape = rect
	add_child(shape)
	_base_y = position.y
	area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	position.x -= speed * delta
	position.y = _base_y + sin(position.x * 0.02) * amplitude
	if position.x < -32.0:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		area.queue_free()
		hp -= 1
		if hp <= 0:
			_die()
	elif area is Player:
		area.take_hit()
		_die()


func _die() -> void:
	if is_queued_for_deletion():
		return
	destroyed.emit(POINTS, global_position)
	queue_free()


func _draw() -> void:
	var body := Color(1.0, 0.93, 0.55)
	var shade := Color(0.85, 0.68, 0.22)
	# asas
	draw_colored_polygon(PackedVector2Array([Vector2(-4, 0), Vector2(6, 0), Vector2(10, -10), Vector2(6, -10)]), shade)
	draw_colored_polygon(PackedVector2Array([Vector2(-4, 0), Vector2(6, 10), Vector2(10, 10), Vector2(6, 0)]), shade)
	# fuselagem
	draw_colored_polygon(PackedVector2Array([Vector2(-18, 0), Vector2(-6, -3), Vector2(12, -4), Vector2(14, 0), Vector2(12, 4), Vector2(-6, 3)]), body)
	# cabine
	draw_colored_polygon(PackedVector2Array([Vector2(-10, -1), Vector2(-4, -3), Vector2(0, -2), Vector2(-4, 0)]), Color(0.2, 0.3, 0.4))
