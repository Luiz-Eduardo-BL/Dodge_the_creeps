extends Area2D
signal hit

export var speed = 400 #Quao rapido o jogador se movera em Pixels
var screen_size #Tamanho da janela do jogo

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Iniciando a velocidade em Zero (0, 0), entao é verificado cada entrada e adicionado ou subtraido da velocidade
# Para obter a direcao resultante
func _process(delta):
	#is_action_just_pressed só funciona quando se aperta, nao funcionara se ficar apertado, para isso use o is_action_pressed
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.play() 
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "andar"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "caminhar"
		$AnimatedSprite.flip_v = velocity.y > 0


func _on_Jogador_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disable", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

