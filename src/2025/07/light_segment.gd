extends Node2D

class_name LightSegment

func set_color(c: Color):
	%Background.color = c

func set_timelines(i: int):
	%Timelines.text = str(i)
	if i > 0:
		%Background.color = Color.GREEN
