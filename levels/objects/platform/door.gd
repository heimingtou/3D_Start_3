extends Node3D

## This door's name as a spawn point. A door in another stage leads here with target_door = id.
@export var id := ""
@export_file("*.tscn") var target_stage := ""
@export var target_door := ""
@export var type_door:=""
@export var locked := false
@export var unlock_flag := ""

@onready var _sprite: AnimatedSprite3D = $AnimatedSprite3D

func _ready() -> void:
	add_to_group("spawn_points")
	$InteractiveArea3D. interacted.connect(_on_interacted)
	var arriving := id != "" and GameManager.pending_spawn == id
	_sprite.play("closing" if arriving else "idle")

func is_locked() -> bool:
	return locked and not GameManager.is_door_unlocked(unlock_flag)

func _on_interacted() -> void:
	if is_locked():
		_tell_locked()
		
		return
	if _sprite.animation == "opening":
		return# already opening - a second press changes nothing
	_sprite.play("opening")
	await _sprite.animation_finished
	print("changeState")
	if type_door=="next":
		GameManager.change_stage(target_stage, target_door)
	if type_door=="go":
		GameManager._Go_next_door(target_door)
	print("changeState")
func _tell_locked() -> void:
	print("Cua khoa roi ... Chac phai hoi Nam ở lang.")
