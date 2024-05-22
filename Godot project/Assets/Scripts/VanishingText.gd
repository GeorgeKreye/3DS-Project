extends Label

# Opacity variables
@export_category("Opacity")
## The opacity to use at the start of the scene
@export var initial_opacity : float = 1
## How fast opacity should be lowered
@export var opacity_loss_rate: float = 0.5
## When to start fade after scene start (in ms)
@export var opacity_loss_delay : float = 0
var opacity : float
var opacity_loss_delay_timer : float

# Called when the node enters the scene tree for the first time.
func _ready():
	# set intial opacity
	opacity = initial_opacity
	modulate.a = opacity
	
	# initialize delay timer
	opacity_loss_delay_timer = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# check if text is fully invisible or if delay is active
	if opacity <= 0: # text fully invisible
		# text will not re-fade in, so delete to save memory
		queue_free()
	elif opacity_loss_delay_timer >= opacity_loss_delay: # delay not active
		# perform opacity fade
		opacity -= opacity_loss_rate * delta
		modulate.a = opacity
	else: # delay active
		# add delta to timer
		opacity_loss_delay_timer += delta
