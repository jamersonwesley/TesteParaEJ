extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var Jump_Count = 0
var _on_floor: bool = true

@export_category("Objects")
@export var animations: CharacterTexture
@onready var sprite = $Animations

func _physics_process(delta):
	if is_on_floor():
		if not _on_floor:
			_on_floor = true
			Jump_Count = 0
		if abs(velocity.x) < 10:
			animations.action_animation("idle")
		else:
			animations.action_animation("run")
	else:
		_on_floor = false
		if Jump_Count == 2:
			animations.action_animation("mortal")
		elif Jump_Count == 1:
			animations.action_animation("jump")

	# Gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Pulo
	if Input.is_action_just_pressed("ui_accept") and Jump_Count < 2:
		Jump_Count += 1
		velocity.y = JUMP_VELOCITY

	# Movimento
	var direction = Input.get_axis("esquerda", "direita")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	animations.animate(velocity)

	# ⚠️ Primeiro move, depois checa colisão
	move_and_slide()

	check_collisions()

func check_collisions():
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		var normal = collision.get_normal()

		if collider:
			if collider.is_in_group("Enemy"):
				if normal.y < -0.7:
					# Colisão por cima, mata o inimigo instantaneamente
					collider.queue_free()
					velocity.y = JUMP_VELOCITY / 1.5
					return
				elif abs(normal.x) > 0.9:
					restart_level()
					return
			elif collider.is_in_group("Cerra"):
				restart_level()
				return
			elif collider.is_in_group("Final"):
				goto_final_screen()
				return

func restart_level():
	if get_tree():
		get_tree().reload_current_scene()

func goto_final_screen():
	if get_tree():
		get_tree().change_scene_to_file("res://leveis/Final.tscn")
