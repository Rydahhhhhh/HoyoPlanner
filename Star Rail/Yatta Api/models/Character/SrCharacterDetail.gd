class_name SrCharacterDetail extends YattaResource

const alias := {
	"rarity": "rank",
	"release_at": "release",
	"info": "fetter",
	"upgrades": "upgrade"
}

@export var id: int
@export var name: String
@export var beta: bool = false
@export var rarity: int
@export var types: SrCharacterDetailTypes
@export var icon: String
@export var release: int
@export var route: String
@export var info: SrCharacterInfo
@export var upgrades: Array[SrCharacterUpgrade]
@export var traces: SrCharacterTraces
@export var eidolons: Array[SrCharacterEidolon]
@export var ascension: Array[SrCharacterAscensionItem]
@export var sr_script: SrCharacterScript
@export var release_at: int
