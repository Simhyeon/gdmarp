## Marp-cli pptx generation automation script

This is a bash script to automate m4 macro pre-processing and marp pptx generation.

### Caution

This script is very early in stage which means many breaking changes occur.

I'm currently dogfooding this script to create game design documents.

### Dependencies

- bash 
- sed
- m4 
- awk (preferably GNU version)
- marp-cli (node package)
- google chrome or chromium (pptx creation dependencies)

### Optional dependencies

- git (git flag)
- bc (sized image macros)
- sqlite3 (sql macro)
- curl + jq (web api)
- jpegoptim (jpeg compression)
- optipng (png compression)

### Installation

#### Docker iamge (OS independent option)

Pull docker image from dockerhub

```bash
docker pull simoncreek/gdmarp
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

You can use windows subsystem linux2. However you have to configure chrome installation path with wsl2 option.

This is a bash script, so theoritically windows bash can execute this script. However it is not guaranteed to work with cygwin or similar unix layer.

I strongly recommend using docker image especially on windows.

+ CR/LF triggers wrong formatted macro substitution. Therefore every file's EOL should be formatted as CR(\n). e.g. visual studio code support config to set default EOL to CR.

### Customization

Edit index.m4 to define custom macros other than default macro rules

Edit env.m4 file to define macro variables or frequently used but might changing numbers. e.g) default font size or current products stock ETC...

### Usage

#### bash

```bash

# To get help messages
gdmarp
gdmarp -h
gdmarp --help

# Check dependencies for local install or docker environment
# This only checkes binary files' names as they are. e.g) chrome or chromium is ok but chrome-browser or chromium-browser might not get detected. However it doesn't mean marp-cli cannot detect chrome binary file.
gdmarp check
gdmarp --docker check

# Initialize current working directory with desired file structure.
# docker option does not install docker image but creates build folder with specific authority
# git flag initialize folder and create .gitignore file
# code flag creates vs code compliant tasks.json for easy build
gdmarp init
gdmarp --docker init
gdmarp --git init
gdmarp --code init 

# To compile within initiated directory
gdmarp compile
gdmarp --docker compile

# To preserve m4 pre-processed file (out.md) use --preserve option or -p in short
gdmarp compile --preserve

# To create pdf file instead of pptx
gdmarp compile --pdf

# To create html when you want to tweak and test csv formats, this automatically preserves medium file
# This may not include local files
gdmarp test

# To disable default macro, use --no-defualt option
gdmarp compile --no-default
```
#### docker

Every argument and flags are all same but gdmarp should be substituted with ```docker run --rm -v $PWD:/home/marp/app simoncreek/gdmarp```

for example,

```bash
<!-- Linux-->
<!-- Linux needs to set user id manually-->
docker run --rm -v $PWD:/home/marp/app --user="$(id -u):$(id -g)" simoncreek/gdmarp init --git --code

<!-- Windows Powershell-->
docker run --rm -v ${PWD}:/home/marp/app simoncreek/gdmarp init --git --code

<!--If you dont' set alias for docker command using --make or --code flag can be handy-->

<!-- Creates makefile(Linux) -->
docker run --rm -v $PWD:/home/marp/app --user="$(id -u):$(id -g)" simoncreek/gdmarp init --git --code

make cnprep
make cncompile
make cnpdf

<!-- Creates vs code tasks.json file(Windows) -->
docker run --rm -v ${PWD}:/home/marp/app simoncreek/gdmarp init --git --code

<!-- Press "Ctrl(Cmd) + Shift + b" to trigger aliased build tasks -->
```

### Using without init command

**Highly recommend using init command before using gdmarp script.**

It is similar to use git without git init command.

Init command creates a file structure looks like this

```
TargetDirectory
|- inc
|- res
|- css
    |- *.css
|- build
|- m4_ext
    |- *.awk
|- index.md
|- index.m4
|- env.m4
```

It is okay to not 'init' a directory, however there are several fixed rules.

- Main file should be called **'index.md'**
- Files you want to include should be located inside of a directory named **'inc'**
- Built pptx or pdf files are always saved in directory named 'build' and the directory will be created if not existent.
- use --no-default option to prevent unexpected error if the directory was not initiated.

Other than that you can call compile commands regardless of init command usage. However you cannot extension macros. 

I recommend at least copy m4\_ext folder into desired location to utilize frequently used macros.

### Basic syntax

```markdown
<!-- Do not escape underscore. Underscore means it's a macro -->
<!-- If a macro doesn't expect arguments parenthesis is optional -->
_styles(css/layout.css, css/table.css)

<!-- Make this slide a title slide-->
_title(Title Text, Subtitle text)

<!-- Add horizontal line to start new slide -->
---

<!--Text macro with font size-->
_text(0, 
This is some sample texts
)

---

<!-- Add class to current section. Content can be multiple classes delimted by spaces -->
_cls(split gdtable)

# Slide title

<!-- Column macros properly works only when split class was added -->
<!-- Start left column -->
_left

## Left column title

<!-- Imgs macro-->
_imgs(res/sample.jpeg, res/gdmarp.png)

<!-- Start right column -->
_right

<!-- Currently doesn't support font-size change in macro-->
<!-- csv macro converts csv file into gfm flavored table format automatically -->
_csv(example_table.csv)

<!-- Raw csv conversion -->
_rcsv(
name,mail,address
simon,123@g.com,somesome
creek,345@n.com,anywhere
)

<!-- End double column slide -->
_end

---
<!-- Include inc/other_file.md into index.md -->
_inc(other_file)

---
<!-- Read csv file into sqlite and print query results -->
<!-- _cc means comma because comma is treated as argument delimters-->
<!-- therefore needs escaping -->
_sql(stock.csv, stock,
SELECT id _cc product_id FROM stock WHERE id = 22;)

<!--You can use _cc() if you don't like whitespaces -->
_sql(stock.csv, stock,
SELECT id_cc()product_id FROM stock WHERE id = 22;)
```

### Macro rules

[Macro rules](macro.md)

### DEMO

not yet

[Todos and issues](./meta.md)
