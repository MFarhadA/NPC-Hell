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

func _ready() -> void:
	current_health = max_health
	coin_collected = coin

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
	
func take_coin():
	coin_collected += 1
	print(coin_collected)
	
func take_damage(amount):
	if is_invincible:
		return
	current_health -= amount
	print(current_health)
	if current_health <= 0:
		die()
	start_invicibility()

func start_invicibility():
	is_invincible = true
	timer_invicible.start()
	if is_invincible:
		anim.modulate.a = 0.5
		collision_layer = false
	is_invincible = false

func _on_timer_timeout() -> void:
	is_invincible = false
	anim.modulate.a = 1
	collision_layer = 1

func die():
	queue_free()
