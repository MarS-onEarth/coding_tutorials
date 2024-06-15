extends Node

@export var mob_scene: PackedScene
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	#new_game()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	
func new_game():
	score = 0
	$player.start($StartPosition.position)
	$StartTimer.start()


func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate() # Create a new instance of the Mob scene.
	
	var mob_spawn_location = $MobPath/MobSpawnLocation #Choose a random location on Path2D.
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2 # Set the mob's direction perpendicular to the path direction.
	
	mob.position = mob_spawn_location.position # Set the mob's position to a random location
	
	direction += randf_range(-PI/4, PI/4) # Add some randomness to the direction
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0) # Choose the velocity for the mob.
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob) # Spawn the mob by adding it to the Main scene.
	


func _on_score_timer_timeout():
	score += 1


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
