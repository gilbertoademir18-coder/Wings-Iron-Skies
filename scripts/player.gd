class_name Player
extends Area2D

## Nave do jogador. Gráfico provisório desenhado em _draw().

signal hit

const SPEED := 200.0
const FIRE_INTERVAL := 0.1
const INVULNERABLE_TIME := 2.0
const BOUNDS := Rect2(16, 16, 608, 328)

var _fire_cooldown := 0.0
var _invulnerable := 0.0


func _ready() -> void:
	collision_layer = 1
	collision_mask = 0
	monitoring = false
	var shape := CollisionShape2D.new()
	var rect := RectangleShape2D.new()
	rect.size = Vector2(14, 6) # hitbox menor que o desenho, padrão de shmup
	shape.shape = rect
	add_child(shape)


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	position = (position + direction * SPEED * delta).clamp(BOUNDS.position, BOUNDS.end)

	_fire_cooldown -= delta
	if Input.is_action_pressed("shoot") and _fire_cooldown <= 0.0:
		_fire()

	if _invulnerable > 0.0:
		_invulnerable -= delta
		modulate.a = 0.3 if fmod(_invulnerable, 0.16) > 0.08 else 1.0
	else:
		modulate.a = 1.0

	queue_redraw()


func take_hit() -> void:
	if _invulnerable > 0.0:
		return
	hit.emit()


func respawn(at: Vector2) -> void:
	position = at
	_invulnerable = INVULNERABLE_TIME


func _fire() -> void:
	_fire_cooldown = FIRE_INTERVAL
	var bullet := Bullet.new()
	bullet.position = position + Vector2(18, 0)
	get_parent().add_child(bullet)


func _draw() -> void:
	var body := Color(0.92, 0.94, 0.98)
	var shade := Color(0.6, 0.65, 0.75)
	# asas
	draw_colored_polygon(PackedVector2Array([Vector2(4, 0), Vector2(-6, -11), Vector2(-10, -11), Vector2(-6, 0)]), shade)
	draw_colored_polygon(PackedVector2Array([Vector2(4, 0), Vector2(-6, 0), Vector2(-10, 11), Vector2(-6, 11)]), shade)
	# fuselagem
	draw_colored_polygon(PackedVector2Array([Vector2(18, 0), Vector2(6, 3), Vector2(-12, 4), Vector2(-14, 0), Vector2(-12, -4), Vector2(6, -3)]), body)
	# cabine
	draw_colored_polygon(PackedVector2Array([Vector2(10, -1), Vector2(4, 0), Vector2(0, -2), Vector2(4, -3)]), Color(0.3, 0.6, 0.95))
	# chama do motor
	var flame := 4.0 + randf() * 5.0
	draw_colored_polygon(PackedVector2Array([Vector2(-14, -2), Vector2(-14, 2), Vector2(-14 - flame, 0)]), Color(1.0, 0.55, 0.1))
