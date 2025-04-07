extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://telas/tela_final.tscn") # ajuste o caminho da sua tela final
