extends CharacterBody2D

var coin : int = 0
var coin_collected : int = 0

const SPEED = 300.0
var max_health : int = 3
var current_health : int = 3
var is_invincible : bool = false

@export var anim : AnimatedSprite2D
@export var body : CollisionShape2D
@export var timer_invicible : Timer
@export var hitbox : Area2D

func _ready() -> void:
	current_health = max_health
	coin_collected = coin

func _physics_process(delta: float) -> void:
	
	if current_health == 0:
		die()
		
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
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

func take_damage():
	if current_health > 0:
		current_health -= 1
		start_invicibility()

func start_invicibility():
	is_invincible = true
	anim.modulate.a = 0.5
	hitbox.collision_mask = false
	timer_invicible.start()

func _on_timer_timeout() -> void:
	is_invincible = false
	anim.modulate.a = 1
	hitbox.collision_mask = 1

func die():
	queue_free()

func _on_coin_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("coin"):
		coin_collected += 1
		area.queue_free()

func _on_hit_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		take_damage()
