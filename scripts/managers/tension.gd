extends Node

var points := 0.0
var max := 100.0

func add(amt):
	points = clamp(points+amt,0,max)
