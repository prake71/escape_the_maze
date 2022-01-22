extends Area2D

export (int) var speed

var tile_size = 64
var can_move = true
var facing = 'right'
var moves = {'right': Vector2.RIGHT, 'left': Vector2.LEFT, 'up': Vector2.UP, 'down': Vector2.DOWN}

onready var raycasts = {'right': $RayCastRight, 'left': $RayCastLeft, 'down': $RayCastDown, 'up': $RayCastUp}

func move(dir):
	$AnimationPlayer.playback_speed = speed
	facing = dir
	if raycasts[facing].is_colliding():
		return
	can_move = false
	$AnimationPlayer.play(facing)
	$MoveTween.interpolate_property(self, "position", position, position + moves[facing] * tile_size, 1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$MoveTween.start()
	return true
	

func _on_MoveTween_tween_completed(object, key):
	can_move = true

