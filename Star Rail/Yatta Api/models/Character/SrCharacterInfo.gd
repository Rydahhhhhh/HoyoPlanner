class_name SrCharacterInfo extends YattaResource


@export var faction: String
@export var description: String
@export var voice_actors: SrVoiceActor

const alias := {
	"voice_actors": "cv",
}
