extends BaseState

func enter() -> void:
	player.animated_sprite.play("idle")

func physics_update(delta: float) -> void:
	player.appliquer_gravite(delta)
	player.deplacer_horizontalement()
	player.move_and_slide()

	if player.is_on_floor():
		Transitioned.emit(self, "idle")
