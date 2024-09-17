@tool
extends Node

# Godot doesn't have string Enums
const PathType := {
	KNIGHT = "Knight", 
	# Preservation
	ROGUE = "Rogue",
	# The Hunt
	MAGE = "Mage",
	# Erudition
	WARLOCK = "Warlock",
	# Nihility
	WARRIOR = "Warrior",
	# Destruction
	SHAMAN = "Shaman",
	# Harmony
	PRIEST = "Priest"
	# Abundance
}

const CombatType := {
	ICE = "Ice",
	FIRE = "Fire",
	QUANTUM = "Quantum",
	IMAGINARY = "Imaginary",
	WIND = "Wind",
	THUNDER = "Thunder",
	PHYSICAL = "Physical"
}
