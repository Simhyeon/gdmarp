### Why need a dialogue module?

Mostly because I need it. The reason why I made gdmarp was because I thought
pptx and word was not efficient format to maintain. And now I also need
maintainable dialogue script.

This might ends with separate dialogue script language parser/reader and helper
macros from gdmarp module. However nothing is determined for now.

### How it should be

Basically dialogue script should be easy to write and easy to maintain.
Additionaly the script should follow the basic flow of logical perception.

Macro should yield exportable format such json so that other programs, for
example game, can use it.

### Demo macro usage

_var(
	Content
) 
=> for "var" : {	Content}
_dialogues(
	Content
)
=> for "dialogues" : {	Content }

_set_speaker(A,A person name)dnl
_set_speaker(B,B person name)dnl

_dialogue(dialogueID(Can be empty),
	A|Text spoken by A,
	B|Text spoken by B,
	A|Answer from A,
	Next(Empty or ID)
)

_dialogue(dialogueID,
	A|Text spoken by A,
	B|Text spoken by B,
	A|Answer from A,
	_sel(1|ID1,2|ID2,3|ID3)
	Next(Empty or ID)
)

### Demo output

{
	"Speakers": {
		"A": "A person's name",
		"B": "B person's name"
	},
	"Dialogues": [
		{
			"ID" : "",
			"Content": [
				{ "Type": "Text","Speaker" : "A", "Text": "Yatti yatta"},
				{ "Type": "Text","Speaker" : "B", "Text": "Yatti yatta 2"}
			],
			"RedirectTo" : "" // Either none or ID
		},
		{
			"ID" : "1",
			"Content": [
				{ "Type": "Text","Speaker" : "A", "Text": "Yatti yatta"},
				{ "Type": "Text","Speaker" : "B", "Text": "Yatti yatta 2"}
				{ "Type": "Selection","Speaker" : "B", "Text": "Yatti yatta 2", "Selections": [{ "text":"1", "redirectTo": "" }, "2", "3", "4"]}
			],
			"RedirectTo" : "" // Either none or ID
		}
	]
}
