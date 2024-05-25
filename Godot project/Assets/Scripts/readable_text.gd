extends VBoxContainer

@export_category("Animation")
## Rate text box should fade in
@export var fade_in_rate : float = 0.1
## Rate text box should fade out
@export var fade_out_rate : float = 0.1
var fade_in : bool
var fade_out : bool
var opacity: float

@onready var readable_text : Label = $ReadableText

# Called when the node enters the scene tree for the first time.
func _ready():
	fade_in = true
	fade_out = false
	opacity = 0
	modulate.a = opacity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fade_in:
		if opacity >= 1:
			opacity = 1
			modulate.a = opacity
			fade_in = false
		else:
			opacity += fade_in_rate * delta
			modulate.a = opacity
	elif fade_out:
		if opacity > 0:
			opacity -= fade_out_rate * delta
			modulate.a = opacity
		else:
			queue_free()
	elif Input.is_action_just_pressed("ui_accept"):
		fade_out = true
