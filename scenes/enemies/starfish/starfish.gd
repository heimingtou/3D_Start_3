extends EnemyCharacter

func _ready() -> void:
	fsm = FSM.new(self, $States, $States/Run)
	super._ready()

func _spaw()->void:
	var current_scene_path = scene_file_path
	var my_packed_scene = load(current_scene_path) as PackedScene
	if GameManager.enemy_factory:
		var spawEnemy= GameManager.enemy_factory.create(my_packed_scene)
		if spawEnemy:
			print("sinh thanh cong")
