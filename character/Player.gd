extends "res://character/Character.gd"

signal moved
signal grabbed_key
signal win
signal dead

func _ready():
	$Sprite.scale = Vector2.ONE

func _process(delta):
	if can_move:
		for dir in moves.keys():
			if Input.is_action_pressed(dir):
				if move(dir):
					$FootSteps.play()
					emit_signal('moved')
					

func _on_Player_area_entered(area):
	if area.is_in_group('enemies'):
		area.hide()
		set_process(false)
		$Lose.play()
		$CollisionShape2D.disabled = true
		$AnimationPlayer.play("die")
		yield($AnimationPlayer, 'animation_finished')
		emit_signal('dead')
	if area.has_method('pickup'):
		area.pickup()
		if area.type == 'key_red':
			emit_signal('grabbed_key')
		if area.type == 'star':
			$Win.play()
			$CollisionShape2D.disabled = true
			yield($Win, "finished")
			emit_signal('win')
			
			
