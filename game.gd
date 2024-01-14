extends Node2D


func _process(delta):
	$RichTextLabel.modulate.a += delta / 5.0
