extends Trap

var spike_time:float = 1.0
var spike_delay_time:float = 5.0

var spike_tween:Tween

func reset_loop():
	super.reset_loop()
	if spike_tween:
		spike_tween.kill()

## Create a single spike loop
func create_spike_tween():
	$spike_snd.play(0.0)
	$sprite.play()
	
	if spike_tween:
		spike_tween.kill()
		
	spike_tween = create_tween()
	spike_tween.tween_interval(spike_time*0.1)
	spike_tween.tween_property($kill_area, "enabled", true, 0.0)
	spike_tween.tween_interval(spike_time*0.8)
	spike_tween.tween_property($kill_area, "enabled", false, 0.0)
	spike_tween.tween_interval(spike_time*0.1)
	spike_tween.tween_callback($sprite.stop)
	spike_tween.tween_interval(spike_delay_time)
	spike_tween.tween_callback(create_spike_tween)
	
## Override this as required, called when the trap triggers
func trigger():
	super.trigger()
	create_spike_tween()


func _on_audio_stream_player_2d_finished():
	$spike_snd.stop()
	pass # Replace with function body.
