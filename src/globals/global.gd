## Keeps the game's global state.
extends Node

## The default high score value, if none is assigned.
const DEFAULT_HIGH_SCORE: int = 20

## Where the game record is saved.
const HIGH_SCORE_PATH: String = "user://high_score.json"

## Current game session score.
var score: int = 0:
	set(value):
		score = value
		high_score = maxi(score, high_score)

## This game's highest recorded score.
@onready
var high_score: int = load_high_score()


## Restores the high score value from the game data file.
func load_high_score() -> int:
	var data = Data.load_json(HIGH_SCORE_PATH)
	if data is Dictionary:
		var value = data.get("high_score")
		if value is float:  # NOTE: JSON numbers are always `float`.
			return int(value)
	return DEFAULT_HIGH_SCORE


## Stores the high score value in the game data file.
func save_high_score() -> void:
	if high_score == score:
		Data.save_json(HIGH_SCORE_PATH, {high_score = high_score})
