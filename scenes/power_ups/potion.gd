extends Area2D

enum Type {
	EMPTY,
	SPEED,
	HEALTH,
	INVINCIBLE,
}

@export var potion_type: Type

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		match potion_type:
			Type.EMPTY:
				pass
			Type.SPEED:
				body.start_speed_increase(100.0)
			Type.HEALTH:
				body.start_health_increase(1)
			Type.INVINCIBLE:
				body.start_invicibility()
		queue_free()
