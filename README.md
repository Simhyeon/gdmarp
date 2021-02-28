## Marp-cli pptx generation automation script

This is a shell script to automate m4 macro pre-processing and marp pptx generation.

### Caution

This script is very early in stage which means many breaking changes occur.

Curent version is 0.0.1.

I'm currently dogfodding this script to create game design documents.

### Dependencies

- m4 
- awk
- marp-cli
- google chrome or chromium (pptx option dependencies)

### Using docker

You can use docker image to containerize marp-cli and chromium installation if you want. Please refer to marp-cli github pages to learn how to install a docker image.

However you still need to install **m4** and **awk** to run this script. This might change later.

### Installation

Any linux distributions will work out of the box if dependencies are all properly installed. MacOs is not so sure because this script expects to use GNU version utilites. Windows can work with WSL(Window Subsystem Linux) without problems.

Simply clone or download whole repository and symlink binary file 'gdmarp' into your binary path.

e.g

```bash
git clone https://github.com/Simhyeon/gdmarp
cd gdmarp
ln -s $PWD/gdmarp ~/.local/bin/gdmarp

# Or add alias within rc file
alias gdmarp='path/to/your/downloaded/directory/gdmarp'
```

Edit index.m4 to define custom macros other than default macro rules

Edit env.m4 file to change variables e.g) default font size

### Usage

```bash

# To get help messages
gdmarp
gdmarp -h
gdmarp --help

# Check dependencies for local install or docker environment
gdmarp check
gdmarp --docker check

# Initialize current working directory with desired file structure.
# docker option does not install docker image
gdmarp init
gdmarp --docker init

# To compile within initiated directory
gdmarp compile
gdmarp --docker compile

# To preserve m4 pre-processed file (out.md) use with --preserve option or -p in short
gdmarp compile --preserve

# To disable default macro use --no-defualt option
gdmarp compile --no-default

```

### Using without init command

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
- Files you want to include should in located in directory named **'inc'**
- Built pptx file is always saved in directory named build and will be made if not existent.
- use --no-default option to prevent unexpected error if not initiated

Other than that you can call compile commands regardless of init command usage. However you cannot use csv, style macro or text macro without m4\_ext folder. 

I recommend at least copy m4\_ext folder into desired location.

### Basic syntax

```markdown
<!-- Do not escape underscore. Underscore means it's a macro -->
---
marp:true
---
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

<!-- Add class to current section can be multiple classes -->
_cls(split)

# Slide title

<!-- Column macros properly works only when split class was added>
<!-- Start left column -->
_left()

## Left column title

<!-- 0 auto scales image size in some extent rather than directly setting width pixel-->
_imgs(0, res/sample.jpeg, res/gdmarp.png)

<!-- Start right column -->
_right()

<!-- Currently doesn't support font-size change in macro-->
<!-- csv macro converts csv file into gfm flavored table format automatically -->
_csv(example_table.csv)

<!-- Raw csv conversion>
_rcsv(
name,mail,address
simon,123@g.com,somesome
creek,345@n.com,anywhere
)

<!-- End double column slide >
_end()

---
<!-- Include inc/other_file.md into index.md-->
_inc(other_file)
```

### Macro rules

[Macro rules](macro.md)

### DEMO

[DEMO (TBD)]()

### TODO

* [x] Test both symlink and rc alias ways
* [x] Make title macro rules simpler to use
* [x] Add raw csv macro
* [x] Add easy multiline writing in raw csv table
* [x] Add custom script enabled by default
* [x] Add option to disable default m4 script
* [x] Enable env.file to modify font-sizes or several trivial css types
* [x] Complete macro rules markdown file
* [ ] Add reserved container layout

#### Dropped todos

Dropped becuase it makes macro usage overly complicated.

* [ ] Add table alignment option to csv macro 
* [ ] Modify csv macro so that user can input font size
