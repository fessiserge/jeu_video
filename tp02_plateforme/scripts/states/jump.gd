extends BaseState

func enter() -> void:
	player.velocity.y = player.JUMP_VELOCITY
	player.animated_sprite.play("idle")

func physics_update(delta: float) -> void:
	player.appliquer_gravite(delta)
	player.deplacer_horizontalement()
	player.move_and_slide()
	if player.velocity.y >= 0:
		Transitioned.emit(self, "fall")
