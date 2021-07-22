### What is important?

- Easy editing
- Easy visualization
- Easy construction

#### Current approach - Chunk based

Chunk based means text nodes are merged into a chunk if text nodes are
continuouse without diversion. While this makes sense, is has many drawbacks.

- Need extra layer of processing to make conceptual structure into an
implementation.
- Often, macro usage is not so ergonomic(unintuitive)
- Rules are too complex for editing

#### Next approach - Complete node based

A node based approach is about making a conceptual structure to share format
with technical implementations. Which makes json parsing easier.

Also it makes macro usages less complex and intuitive.

Finally, it makes editing far more easier since json is now simply a big array of objects.

#### Demo

```json
[
	{
		"id": "",
		"type":"",
		"speaker": "",
		"text": "",
		"diversion": [],
		"goto": ""
	},
	...
]

Goto is mandatory, while other props are optional.
Text is for selection and 
target + qual(ification) is for branching.

"diversion": [
	{
		"goto":"",
		"text":"",
		"target":"",
		"qual":""
	}
]

```
