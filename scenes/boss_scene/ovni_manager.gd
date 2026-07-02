extends Node

const ovni_scene = preload("res://scenes/ovni/ovni.tscn")
const alien_scene = preload("res://scenes/alien_boss/alien_boss.tscn")

var ovni
var alien

var screen_width := 1152

var zones = {
	"top": -110,
	"mid": 20,
	"bottom": 150
}

var last_zone = ""
var passes = 0
var max_passes = 4

func start_phase():
	passes = 0
	spawn_ovni()
	run_cycle()
	
func spawn_ovni():
	ovni = ovni_scene.instantiate()
	ovni.position = Vector2(800,800)
	get_parent().add_child(ovni)
	ovni.collision.disabled = false
	
func run_cycle():
	if passes >= max_passes:
		end_phase()
		return

	passes += 1

	var zone = pick_zone()

	await move_ovni(zone)

	call_deferred("run_cycle")
		
func move_ovni(zone):
	var y = zones[zone]

	ovni.set_lane(y)

	ovni.global_position.x = -600

	var tween = get_tree().create_tween()
	tween.tween_property(ovni, "global_position:x", screen_width + 200, 2.2)

	await tween.finished
	
func pick_zone():
	var keys = zones.keys()

	var z = keys.pick_random()
	last_zone = z
	return z
	
func end_phase():
	ovni.collision.disabled = true
	print("sin hitbox")
	ovni.queue_free()
	spawn_alien()

func spawn_alien():
	var new_alien = alien_scene.instantiate()
	get_parent().add_child(new_alien)
	new_alien.global_position = Vector2(200, -100)

	new_alien.request_ovni_phase.connect(start_phase)

	return new_alien
