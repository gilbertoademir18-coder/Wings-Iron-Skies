class_name Background
extends Node2D

## Cenário provisório da Fase 1 (mar, de manhã): céu em gradiente, nuvens e
## brilhos no mar com parallax (quanto mais perto da tela, mais rápido).

const WIDTH := 640.0
const HEIGHT := 360.0
const HORIZON := 230.0
const SKY_TOP := Color(0.0, 0.25, 0.95)
const SKY_BOTTOM := Color(0.35, 0.75, 1.0)
const SEA := Color(0.02, 0.1, 0.6)

var _sparkles: Array[Vector3] = [] # x, y, velocidade
var _clouds: Array[Vector3] = [] # x, y, raio


func _ready() -> void:
	for i in 80:
		var y := randf_range(HORIZON + 4.0, HEIGHT)
		var depth := (y - HORIZON) / (HEIGHT - HORIZON)
		_sparkles.append(Vector3(randf() * WIDTH, y, 30.0 + depth * 170.0))
	for i in 5:
		_clouds.append(Vector3(randf() * (WIDTH + 160.0), randf_range(30.0, 170.0), randf_range(12.0, 24.0)))


func _process(delta: float) -> void:
	for i in _sparkles.size():
		var s := _sparkles[i]
		s.x -= s.z * delta
		if s.x < -10.0:
			s.x += WIDTH + 20.0
		_sparkles[i] = s
	for i in _clouds.size():
		var c := _clouds[i]
		c.x -= (10.0 + c.z) * delta
		if c.x < -80.0:
			c.x = WIDTH + 80.0
			c.y = randf_range(30.0, 170.0)
		_clouds[i] = c
	queue_redraw()


func _draw() -> void:
	draw_polygon(
		PackedVector2Array([Vector2(0, 0), Vector2(WIDTH, 0), Vector2(WIDTH, HORIZON), Vector2(0, HORIZON)]),
		PackedColorArray([SKY_TOP, SKY_TOP, SKY_BOTTOM, SKY_BOTTOM])
	)
	draw_rect(Rect2(0, HORIZON, WIDTH, HEIGHT - HORIZON), SEA)
	draw_line(Vector2(0, HORIZON), Vector2(WIDTH, HORIZON), Color(0.5, 0.8, 1.0), 2.0)

	for c in _clouds:
		_draw_cloud(Vector2(c.x, c.y), c.z)

	for s in _sparkles:
		var length := 2.0 + (s.z - 30.0) / 170.0 * 10.0
		draw_rect(Rect2(s.x, s.y, length, 1.0), Color(1, 1, 1, 0.85))


func _draw_cloud(center: Vector2, radius: float) -> void:
	var color := Color(0.85, 0.92, 1.0)
	draw_circle(center, radius, color)
	draw_circle(center + Vector2(radius * 1.1, radius * 0.2), radius * 0.8, color)
	draw_circle(center + Vector2(-radius * 1.1, radius * 0.25), radius * 0.7, color)
	draw_circle(center + Vector2(radius * 0.3, -radius * 0.5), radius * 0.75, color)
