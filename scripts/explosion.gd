class_name Explosion
extends Node2D

## Explosão provisória: dois círculos que crescem e somem.

const DURATION := 0.35

var _time := 0.0


func _process(delta: float) -> void:
	_time += delta
	if _time >= DURATION:
		queue_free()
		return
	queue_redraw()


func _draw() -> void:
	var k := _time / DURATION
	draw_circle(Vector2.ZERO, 4.0 + 18.0 * k, Color(1.0, 0.55, 0.1, 1.0 - k))
	draw_circle(Vector2.ZERO, 2.0 + 10.0 * k, Color(1.0, 1.0, 0.7, 1.0 - k))
