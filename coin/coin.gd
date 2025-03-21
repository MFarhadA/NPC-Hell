extends Area2D

signal coin_collected

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_coin()
		coin_collected.emit()
		queue_free()
