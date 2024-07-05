extends Node2D

var rng := RandomNumberGenerator.new()

var block_prefabs := [
	preload("res://blocks/gitea.tscn"),
	preload("res://blocks/github.tscn"),
	preload("res://blocks/gitlab.tscn"),
	preload("res://blocks/godot.tscn"),
	preload("res://blocks/itchio.tscn")
]

# I don't want to resize sprites or redo CollisitionPolygon2D's
var relative_scale: Array[float] = [
	0.550, # Gitea  384 x 237
	0.800, # GitHub 240 x 240
	1.000, # GitLab 192 x 186
	0.821, # Godot  234 x 220
	0.700  # Itchio 262 x 235
]

@onready var text := $RichTextLabel
@onready var block_timer := $BlockAddTimer
@onready var spawn_point := $SpawnPath/SpawnPoint
@onready var blocks := $Blocks

func _ready() -> void:
	block_timer.connect("timeout", spawn_block)
	fade_text()


func _process(_delta: float) -> void:
	var number_of_blocks = blocks.get_child_count()
	block_timer.wait_time = number_of_blocks / 40.0 if number_of_blocks > 0 else 2.0


func fade_text() -> void:
	var tween := get_tree().create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(text, "modulate:a", 1.0, 2.0)
	tween.tween_property(text, "modulate:a", 0.0, 6.0).set_delay(6.0)


func spawn_block() -> void:
	spawn_point.progress_ratio = rng.randf()
	var block_index := rng.randi_range(0, block_prefabs.size() - 1)
	var block: Block = block_prefabs[block_index].instantiate()
	blocks.add_child(block)
	block.position = spawn_point.position
	var size := rng.randf_range(0.6, 0.9) * relative_scale[block_index]
	block.change_scale(Vector2(size, size))
