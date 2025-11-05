extends CharacterBody2D

@export var speed := 200.0
@onready var sprite = $Sprite2D  # Asegúrate de tener un Sprite2D como hijo

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
	velocity = direction * speed
	move_and_slide()

	# Voltear sprite según dirección
	if direction.x != 0:
		sprite.flip_h = direction.x < 0
