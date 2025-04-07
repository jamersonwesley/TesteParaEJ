extends Control

func _ready():
	var button = get_node("MainContainer/HBoxContainer/VBoxContainer/Button")
	if button and button is Button:
		button.pressed.connect(_on_button_pressed)
	else:
		print("Botão não encontrado!")

func _on_button_pressed():
	print("Botão clicado!")
	get_tree().change_scene_to_file("res://leveis/fase_base.tscn")
