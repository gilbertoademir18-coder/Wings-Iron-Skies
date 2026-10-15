class_name Hud
extends CanvasLayer

## HUD provisório: pontos, vidas e mensagem central (título / game over).

var _score_label: Label
var _lives_label: Label
var _message_label: Label


func _ready() -> void:
	_score_label = _make_label(Vector2(8, 6), Vector2(200, 24), HORIZONTAL_ALIGNMENT_LEFT, 16)
	_lives_label = _make_label(Vector2(8, 332), Vector2(200, 24), HORIZONTAL_ALIGNMENT_LEFT, 16)
	_message_label = _make_label(Vector2(0, 120), Vector2(640, 120), HORIZONTAL_ALIGNMENT_CENTER, 24)


func set_score(value: int) -> void:
	_score_label.text = "PONTOS  %07d" % value


func set_lives(value: int) -> void:
	_lives_label.text = "W x %d" % value


func show_message(text: String) -> void:
	_message_label.text = text
	_message_label.visible = not text.is_empty()


func _make_label(pos: Vector2, size: Vector2, align: HorizontalAlignment, font_size: int) -> Label:
	var label := Label.new()
	label.position = pos
	label.size = size
	label.horizontal_alignment = align
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_outline_color", Color.BLACK)
	label.add_theme_constant_override("outline_size", 4)
	add_child(label)
	return label
