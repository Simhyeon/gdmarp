## Why markdown for representation?

Mostly because I thought marp, which is the reason this program was named as
gdmarp, was preety neat program and marp uses markdown format. If not for marp,
I may have used asciidoc because it is more expressive. However pptx file format
is somewhat necessary so I had few choices.

## Why mediawiki for wiki 

While this may change in future, mediawiki is the best documented and widely
used wiki software with easy api. I searched some other alternatives but not
every wiki software had put method and some required profobuff which was
overkill for me. Plus, one thing that I care for most is that user accessibility,
it's time consuming for me to learn new technologies because I'm eager to learn it,
however other users may not be thus using easy and widely used methods such as REST api
is better than graphql or profobuff.

## Why bootstrap for web ui?

It's reasoning is exactly same with the REST api. Bootstrap is popular and
everybody knows, well ok not everybody but front end devs. I personally prefer
libraries like tailwind because I have more freedome. However philosophy of
gdmarp is centered on easy construction of documents in trade of
customizabilty, so such library can not be included. (Though I recommend using
pure "script" to customize when you really need it.)

In a same sense, framework such as react cannot be used. Not every user knows
web frameworks and it gets heavy when you need to configure babel,
webpack,react and yatti yatta. Gdmarp is already heavy enough. Plus, it is
rather tricker to make ergonomic macros that can cover all jsx syntax and react
state hook. At least I thought so and never looked back.
