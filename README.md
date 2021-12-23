## Gdmarp is not developed anymore

Gdmarp is deprecated in favor of new cross-platform implementation,
[gdengine](https://github.com/simhyeon/gdengine).

## Gdmarp, an automatic game document generation script

This is a shell script to automate m4 macro pre-processing and various
documenation rederings with automated publishing. Gdmarp can create pdf, 
pptx, html slide, wikitext file for mediawiki instance and webui html
page for UI/UX demo usage.

Gdmarp uses a gddt filetype which is an abbreviation of a game design document
text. Gddt consists of complex macro usages which are defined by various
modules. Such module expands macros into properly formatted texts. 

Therefore you don't have to write separate files for separate formats, just write
once and export with one gdmarp command.

### How gdmarp works

Gdmarp is a script that combines sets of several text processing and macro
expansion for easy game design documentation creation. It utilizes various unix
tools with m4 macro processor as a protagonist.

Init subcommand creates a necessary file structure in a current working
directory. In the directory gdmarp can render multiple documentation formats
such as representation forms, wiki page and webui.

There are many pre-defined macros that expands to lengthy codes of html,css or
wikitexts. Some macros are defined in various modules at the same time which
enables you to write macros once and render multiple formes without changing
any of them.

You can edit "index.gddt" which is created by init subcommand however you can also
create new file and give the file to gdmarp with -N command followed by file name.

After writing all macros, simply call subcommand with proper backend modules
and gdmarp will render output files into the build directory. Or simply
set all commands in config.json file so that "run" subcommand can call multiple
commands at the same time.

Please refer a macro part at the bottom of this document for how macro is used and expanded.

### Available modules

There are two types of modules; render module and component module. Render
module yield complete document while component module yields component that can
be utilized in document or used as it is.

**Render modules**

- marp (pptx, pdf, html creation)
- mw (mediawiki page)

To be updated
- pandoc ( docs creation )

**Component modules**

- bts (web ui html page with bootstrap cdn)
- gdl (graphviz dialgoue as html, pdf and png format)
- fjs (flowchart-js to create interactive flowchart)
- gvz (graphviz to create static flowchart as image format)

### Dependencies

- sed (GNU version)
- m4 
- awk (GNU version)
- jq (config parsing)
- perl (over 5.10 version)
- bc
- tr

### Optional dependencies

- marp-cli (node package)
- google chrome or chromium (pptx creation dependencies)
- git (git flag)
- sqlite3 (sql macro)
- curl (web api)
- jpegoptim (jpeg compression)
- optipng (png compression)
- "graphviz" for dot binary (dialogue png and pdf format)

### Installation

#### Docker iamge (OS independent option)

Pull docker image from dockerhub

```bash
docker pull simoncreek/gdmarp:latest
```

Docker image includes all dependencies including optional ones.

#### Unix

Install dependencies before using gdmarp binary file.

Then simply clone or download whole repository and symlink binary file 'gdmarp' into your binary path.

e.g

```bash
git clone https://github.com/Simhyeon/gdmarp
cd gdmarp
ln -s $PWD/gdmarp ~/.local/bin/gdmarp

# Or add alias within rc file
alias gdmarp='path/to/your/downloaded/directory/gdmarp'
```

#### Windows

You can use windows subsystem linux2. However you have to configure chrome
installation path with wsl2 option.

This is a shell script, so theoritically windows bash can execute this script.
However it is not guaranteed to work with cygwin or similar unix layer.

I strongly recommend using docker image especially on windows.

P.S. CR/LF('\n\r') triggers wrong formatted macro substitutions. Therefore
every file's EOL should be formatted as CR('\n'). e.g. visual studio code
support a config to set default EOL to CR.

### Customization

Edit index.m4 to define custom macros other than default macro rules

Edit env.m4 file to define macro variables or frequently used but might changing numbers. 
e.g.) default font size or current products stock ETC...

You can simply use setvar macro to set varaibles inside any gddt files.
e.g.) 

```gddt
_set_var(`v_url',`http://google.com/some_img_path')dnl

// "v_url" varaible is expanded within image macro during macro processing
_img(v_url())
```

### Usage

Usages of shell are mostly applicable to docker verison's but the difference is
that docker run commands should be preceded with real program arguments.

#### shell

```bash
# To get help messages
gdmarp -h
gdmarp help

# Check dependencies for local installation
gdmarp check

# Initialize current working directory with desired file structure.
# Git flag, "-g" initialize folder and create .gitignore file
# Init with module so that necessary config can be defined in config.json
gdmarp init
gdmarp init -g
gdmarp init -M mw # This module is mediawiki backend

# NOTE
# Every subcommand get get module name with -M flag
# However default module is set already, so you don't always have to give
# module name.

# Simpley preprocess and don't publish to final format
gdmarp prep -M marp
gdmarp prep -M mw # wiki's prep doesn't post wikipage to given url

# To render presentation forms (pdf, pptx, html)
gdmarp repr -M marp -F pdf

# To render wikitext and send page to mediawiki ( requires config.json to be configured )
gdmarp wiki -M mw

# To render webui
# Currently this doesn't post the page to an url. Thus, this command is same
# with prep for now.
gdmarp wui -M bts

# To render dialogue tree
# Available formats are {html|png|pdf}
gdmarp dial -M gdl -F html

# Copy to given directory
# You can copy final file into the direcotry you want it copied to.
# Next command will make a final file named as <file_name> 
# and copy the file to <directory>
gdmarp <subcommand> -M <module_name> -O <file_name> -C <directory>

# Purgemode
# You can give purgemode {all|user|var} to purge unused macros
# Purgemode is used only on render modules
gdmarp <subcommand> -M <module_name> -P <purgemode>

# To run test scripts in config.json
# This enables preserve flag("-p") and creates distinctive middle files in build directory
gdmarp test

# To run scripts in config.json
gdmarp run
```
#### docker

Every argument and flags are all same but gdmarp should be substituted with
docker commands such as ```docker run --rm -v $PWD:/home/marp/app
simoncreek/gdmarp```

for example,
```bash
<!-- Linux-->
<!-- Linux needs to set user id manually-->
docker run --rm -v $PWD:/home/marp/app --user="$(id -u):$(id -g)" simoncreek/gdmarp init -g 

<!-- Windows Powershell-->
docker run --rm -v ${PWD}:/home/marp/app simoncreek/gdmarp init -g
```

Also you can use docker wrapper gde placed within gde directory. Windows
version is powershell script called ```gde.ps1``` and unix version is shell
script called ```gde```.

With wrapper script you can use gde instead of gdmarp.

for example,
```sh
// This will invoke docker run simoncreek:latest ... with given arguments

gde wiki -M mw
gde wui -M bts
```

### Sample config.json

```json
{
    "env": {
        "url": "http://urlToMediaWikiInstance",
        "bot_id": "UserName@thisIsBotName",
        "bot_pwd": "LongAndHardToRememberBotPassword",
        "page_title": "PageTitleToPost"
    },
    "test": [
        "prep -M marp -F html",
        "wui -M bts -N webui_test.gddt -O webui"
    ],
    "script": [
        "repr -M marp -F html -O repr",
        "wui -M bts -N webui_test.gddt -O webui"
    ]
}
```

### Macro rules(interface)

[Macro rules](docs/macro.md)

### DEMO

not yet

[Todos and issues](docs/meta.md)

### Release notes

[](docs/release_note.md)

### License

[MIT](docs/LICENSE.md)
