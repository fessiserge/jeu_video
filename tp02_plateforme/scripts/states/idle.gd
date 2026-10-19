extends BaseState
func enter() -> void:
	player.animated_sprite.play("idle")

func physics_update(delta: float) -> void:
	player.appliquer_gravite(delta)
	player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	player.move_and_slide()
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		Transitioned.emit(self, "jump")
	elif Input.is_action_just_pressed("attack"):
		Transitioned.emit(self,"attack")
	elif not player.is_on_floor():
		Transitioned.emit(self, "fall")
	elif Input.get_axis("left", "right") != 0:
		Transitioned.emit(self, "run")
