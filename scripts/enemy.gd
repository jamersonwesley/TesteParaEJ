extends CharacterBody2D

const SPEED = 100.0
var player: Node2D
@onready var sprite = $AnimatedSprite2D 
const PLAYER_BOUNCE_VELOCITY = -400.0
func _ready():
	player = get_parent().get_node("Player")

func _physics_process(delta):
	if player:
		var player_x = player.global_position.x
		var enemy_x = global_position.x

		# Movimento horizontal
		if abs(player_x - enemy_x) > 4:
			velocity.x = SPEED if player_x > enemy_x else -SPEED
		else:
			velocity.x = 0

		# Virar baseado em quem está mais à direita
		if player_x > enemy_x:
			
			sprite.scale.x = abs(sprite.scale.x)  # direita
		else:
			sprite.scale.x = -abs(sprite.scale.x)  # esquerda

		move_and_slide()
