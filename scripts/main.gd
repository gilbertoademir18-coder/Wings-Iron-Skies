extends Node2D

## Cena principal do protótipo: título -> jogo -> game over.

enum State { TITLE, PLAYING, GAME_OVER }

const START_LIVES := 3
const PLAYER_START := Vector2(80, 180)

var _state := State.TITLE
var _score := 0
var _lives := START_LIVES
var _spawn_timer := 1.0
var _player: Player
var _world: Node2D
var _hud: Hud


func _ready() -> void:
	InputSetup.setup()
	add_child(Background.new())
	_world = Node2D.new()
	add_child(_world)
	_hud = Hud.new()
	add_child(_hud)
	_hud.set_score(_score)
	_hud.set_lives(_lives)
	_hud.show_message("W I N G S\n\n--Pressione ENTER / START--")


func _process(delta: float) -> void:
	match _state:
		State.TITLE:
			if Input.is_action_just_pressed("start"):
				_start_game()
		State.PLAYING:
			_spawn_timer -= delta
			if _spawn_timer <= 0.0:
				_spawn_wave()
				_spawn_timer = randf_range(1.2, 2.2)
		State.GAME_OVER:
			if Input.is_action_just_pressed("start"):
				get_tree().reload_current_scene()


func _start_game() -> void:
	_state = State.PLAYING
	_hud.show_message("")
	_player = Player.new()
	_player.hit.connect(_on_player_hit)
	_world.add_child(_player)
	_player.respawn(PLAYER_START)


func _spawn_wave() -> void:
	var count := randi_range(3, 5)
	var y := randf_range(50.0, 310.0)
	var amplitude := randf_range(0.0, 40.0)
	for i in count:
		var enemy := Enemy.new()
		enemy.position = Vector2(660.0 + i * 34.0, y)
		enemy.amplitude = amplitude
		enemy.destroyed.connect(_on_enemy_destroyed)
		_world.add_child(enemy)


func _spawn_explosion(at: Vector2) -> void:
	var explosion := Explosion.new()
	explosion.position = at
	_world.add_child.call_deferred(explosion)


func _on_enemy_destroyed(points: int, at: Vector2) -> void:
	_score += points
	_hud.set_score(_score)
	_spawn_explosion(at)


func _on_player_hit() -> void:
	_lives -= 1
	_hud.set_lives(_lives)
	_spawn_explosion(_player.position)
	if _lives > 0:
		_player.respawn(PLAYER_START)
	else:
		_player.queue_free()
		_player = null
		_state = State.GAME_OVER
		_hud.show_message("GAME OVER\n\n--Pressione ENTER / START--")
