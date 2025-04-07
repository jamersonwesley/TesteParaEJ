extends AnimatedSprite2D
class_name  CharacterTexture
var _is_on_action:bool = false



func animate(_velocity: Vector2) -> void:
	_verify_direction(_velocity.x)
	
	if _is_on_action:
		return
	
	if not _velocity:
		play("idle")
		return
	if _velocity.x and _velocity.y == 0:
		play("run")
		return
	if _velocity.y:
		if _velocity.y < 0 :
			play("jump")
		if _velocity.y > 0 :
			play("jump")
			return

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _verify_direction(_direction:float)-> void :
	if _direction > 0:
		flip_h = false
	if _direction < 0:
		flip_h = true
		
func  action_animation(_action_name:String) -> void:
	_is_on_action = true
	play(_action_name)


func _on_animation_finished()-> void:
	_is_on_action = false
	pass # Replace with function body.
