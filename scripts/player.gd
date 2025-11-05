extends CharacterBody2D

@export var speed := 200.0
@onready var sprite = $Sprite2D  
@onready var attack_area = $AttackArea

@warning_ignore("unused_parameter")

var is_attacking = false
var attack_duration := 0.3 

@warning_ignore("unused_parameter")
func _physics_process(delta):
	var direction = Vector2.ZERO

	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1

	direction = direction.normalized()
	
	if not is_attacking:
		velocity = direction * speed
		move_and_slide()
		# Voltear sprite según dirección
	if direction.x != 0:
		sprite.flip_h = direction.x < 0
		
	# Ataque
	if Input.is_action_just_pressed("attack") and not is_attacking:
		start_attack()
	
func start_attack():
	is_attacking = true
	if sprite.flip_h:
		attack_area.position = Vector2(-20, 0)
	else:
		attack_area.position = Vector2(20, 0)

	print("Start attack - monitoring antes:", attack_area.monitoring)
	attack_area.monitoring = true
	print("Start attack - monitoring despues:", attack_area.monitoring)
	attack_area.visible = true
	
	#desactiva despues de unos segundos
	await get_tree().create_timer(attack_duration).timeout
	attack_area.monitoring = false
	attack_area.visible = false
	is_attacking = false
	print("End attack - monitoring:", attack_area.monitoring)


func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		print("Golpeando a:", body.name)
		body.take_damage(1) 
