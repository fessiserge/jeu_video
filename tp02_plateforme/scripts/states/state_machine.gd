extends Node

class_name StateMachine

@export var initial_state: BaseState
var current_state: BaseState
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is BaseState:
			states[child.name.to_lower()] = child
			child.player = owner as Player
			child.Transitioned.connect(on_child_transition)
	await owner.ready
	if initial_state:
		initial_state.enter()
		current_state = initial_state
		
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return

	var new_state = states.get(new_state_name.to_lower())
	if not new_state:
		return
	#print(current_state.name, " -> ", new_state.name)
	current_state.exit()
	new_state.enter()
	current_state = new_state
