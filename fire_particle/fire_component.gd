extends Node2D

@onready var yellow: GPUParticles2D = $yellow
@onready var orange: GPUParticles2D = $orange

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_particle_lifetime(lifetime: float, lifetime_max: float):
	orange.lifetime = lifetime
	yellow.lifetime = lifetime

func set_particle_scale(scale: float, scale_max: float):
	if orange.process_material is ParticleProcessMaterial:
		var material = orange.process_material as ParticleProcessMaterial
		material.scale_min = scale
		material.scale_max = scale_max

	if yellow.process_material is ParticleProcessMaterial:
		var material = yellow.process_material as ParticleProcessMaterial
		material.scale_min = scale
		material.scale_max = scale_max