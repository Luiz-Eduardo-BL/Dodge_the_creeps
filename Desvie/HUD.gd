extends CanvasLayer

signal start_game

func _ready():
	pass
	
#Funcao chamada para mostrar uma mensagem temporaria como prepare-se
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
#Essa funcao é chamada quando o jogador perde
func show_game_over():
	show_message("Game Over!!")
	
	yield($MessageTimer, "timeout")
	
	$MessageLabel.text = "Desvie dos\nCreeps!!"
	$MessageLabel.show()
	
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)

func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
