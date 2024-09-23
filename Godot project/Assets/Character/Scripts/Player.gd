extends CharacterBody3D



#movement
@export_category("Movement")
@export var maxSpeed = 4.0
@export var maxRunSpeed = 6.0
@export var acceleration = 20.0
@export var braking = 20.0
@export var airAcc = 4.0
@export_category("Jumping")
@export var jumpForce = 5.0
@export var gravityModifier = 1.5


var isRunning = false

#camera
@export_category("Camera")
@export var lookSensitivity = .005
var cameraLookInput : Vector2

@export_category("Materials")
@export var redMat : Material
@export var greenMat : Material


@onready var camera : Camera3D = $Camera3D
@onready var player = $"."
@onready var gameGravity = ProjectSettings.get_setting("physics/3d/default_gravity") * gravityModifier



func _ready():
	#fix for camera flipping bug
	camera.rotation = Vector3(0,0,0)
	Input.mouse_mode =Input.MOUSE_MODE_CAPTURED
	
	
func _physics_process(delta):
	#apply gravity
	if not is_on_floor():
		velocity.y -= gameGravity *delta
		
	#jump
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jumpForce
	
	var moveInput = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	var moveDir = (transform.basis * Vector3(moveInput.x, 0, moveInput.y).normalized())
	
	isRunning = Input.is_action_pressed("sprint")
	
	var moveSpeed = maxSpeed
	
	if isRunning:
		moveSpeed = maxRunSpeed
		#calculate dot product of move direction
		#determine the direction of run
		#-move direction dot transform.basis.z will be
		# 1 if moving forward
		# -1 if moving backward
		# 0 is moving left or right
		var rundot = moveDir.dot(-transform.basis.z)
		#use this to only allow forward running
		#only allow rundot to be a positive number
		rundot = clamp (rundot, 0.0, 1.0)
		#movedir will only sprint forward because rundot won't be negative or zero
		moveDir *= rundot
	
	var currentSmoothing = acceleration
	
	#change smoothing if in the air
	if not is_on_floor():
		currentSmoothing = airAcc
	#change smoothing if not moving
	elif  not moveDir:
		currentSmoothing = braking
		
	var targetVelocity = moveDir * moveSpeed
	
	#lerp to go from current velocity to targetvelocity using the correct acceleration or deceleration
	velocity.x = lerp(velocity.x, targetVelocity.x, currentSmoothing *delta)
	velocity.z = lerp(velocity.z, targetVelocity.z, currentSmoothing *delta)
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		cameraLookInput = event.relative

	move_and_slide()
	
	#camera look
	#horizontal
	player.rotate_y(-cameraLookInput.x * lookSensitivity)
	##vertical
	camera.rotate_x(-cameraLookInput.y * lookSensitivity)
	camera.rotation.x = clamp (camera.rotation.x, -.8, .8)
	#
	#reset
	cameraLookInput = Vector2.ZERO
	
	
