extends Label

# Opacity
@export_category("Opacity")
@export var initial_opacity : float = 1
@export var opacity_loss_rate: float = 0.5
var opacity : float

# Called when the node enters the scene tree for the first time.
func _ready():
	# set intial opacity
	opacity = initial_opacity
	modulate.a = opacity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# check if text is fully invisible
	if opacity <= 0:
		# text will not re-fade in, so delete to save memory
		queue_free()
	else:
		# perform opacity fade
		opacity -= opacity_loss_rate * delta
		modulate.a = opacity
