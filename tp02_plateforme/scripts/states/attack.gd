extends BaseState

func enter() -> void:
	player.animated_sprite.play("attack")
	await player.animated_sprite.animation_finished
	Transitioned.emit(self, "idle")

func physics_update(delta: float) -> void:
	player.appliquer_gravite(delta)
	player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	player.move_and_slide()
