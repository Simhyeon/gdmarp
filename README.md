## Marp-cli pptx generation automation script

This is a bash script to automate m4 macro pre-processing and marp pptx generation.

### Caution

This script is very early in stage which means many breaking changes occur.

Curent version is 0.0.1. Means nothing but sem-ver compliant.

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

#### Windows (Not confirmed)

You can use windows subsystem linux2. However you have to configure chrome installation path with wsl2 option.
This is a bash script, so theoritically windows bash can execute this script. However binary names in script doesn't end with '.exe' so I'm not so sure if it works or not. 
I personally recommend using docker image.

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
docker run --rm -v $PWD:/home/marp/app simoncreek/gdmarp init --git --code

<!-- Windows Powershell-->
docker run --rm -v ${PWD}:/home/marp/app simoncreek/gdmarp init --git --code
```

### Using without init command

**Highly recommend using init command before using gdmarp script.**

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

### TODO

* [x] Test both symlink and rc alias ways
* [x] Make title macro rules simpler to use
* [x] Add raw csv macro
* [x] Add easy multiline writing in raw csv table
* [x] Add custom script enabled by default
* [x] Add option to disable default m4 script
* [x] Enable env.file to modify font-sizes or several trivial css types
* [x] Complete macro rules markdown file
* [x] Add reserved container layout 
* [x] No pixel option for images
* [x] Make in-memory database interaction extension to get specific result using query macro
* [x] Fix image overflow errors :: Suspended
    - Also modified sized images macro mechanics : Need bc to be installed.
* [x] Make img center class works - Kinda works but strange bug occurs well rarely though.
* [x] Make simple web api macro
* [ ] Image centering is not working.... 
* [ ] Make stiatc image macro

### Big TODO

* [ ] Make integrated auto html deployment service
* [ ] Make alternative language for m4 and awk in rust.

#### Dropped todos

Dropped becuase it makes macro usage overly complicated.
* [ ] Add table alignment option to csv macro 
* [ ] Modify csv macro so that user can input font size

For legacy support + Space delimited class is not that bad
* [ ] Change class macro to get inputs delimited by comma not spaces.

Unergonomic to do with simple unix programs or m4 macro processing
* [ ] Add auto scale macro for texts with external programs

Not possible to create reproducible output from 'pdf->editable pptx' generation.
Thus it is better to separate responsibilites of creating a pptx and enabling editing.
* [ ] Pandoc extension to create editable pptx file.
