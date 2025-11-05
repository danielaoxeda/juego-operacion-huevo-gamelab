extends CharacterBody2D

@export var max_health := 5
var current_health := max_health

func _ready():
	add_to_group("enemy")

func take_damage(amount: int):
	current_health -= amount
	print("Enemy HP:", current_health)

	# Parpadeo cuando recibe daño
	modulate = Color(1, 0.4, 0.4)
	await get_tree().create_timer(0.15).timeout
	modulate = Color(1, 1, 1)

	if current_health <= 0:
		die()

func die():
	print("Enemy derrotado")
	queue_free()
