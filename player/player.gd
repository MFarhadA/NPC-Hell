extends CharacterBody2D


const SPEED = 300.0
@export var anim : AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	print(velocity.x, velocity.y)
	
	if velocity.x != 0 && velocity.y == 0:
		anim.play("walk_right")
			
	if velocity.x == 0 && velocity.y != 0:
		if velocity.y > 0:
			anim.play("walk_down")
		if velocity.y < 0:
			anim.play("walk_up")
	
	if velocity.x != 0 && velocity.y != 0:
		if velocity.y > 0:
			anim.play("walk_rightdown")
		else:
			anim.play("walk_rightup")

	if velocity.x == 0 && velocity.y == 0:
		anim.play("idle")
	
	if velocity.x > 0:
		anim.flip_h = false
	else:
		anim.flip_h = true
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		
	position += velocity * delta
