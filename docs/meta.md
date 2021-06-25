### Gdmarp 0.2 plan

**What is planned for 0.2 ?**

#### Highly modular components with config file

Formerly, m4 extensions were distributed with init commands. This was to make
binary distribution very easy. However extensions are getting bigger by time and
it became not so desirable to include the scripts inside working project
directories.

Therefore m4 extensions will be located in app setting directories both for
m4_ext and css. Also a style macro will be removed and module inclusion will be
defined by separate config file.

#### Diverse render forms and associated macro extensions

Currently only single render format is availble, which is a slide style. From
0.2 there will be multiple render forms. Thus script's name gdmarp will not only
mean game design marp automation, but game design macro processing.

Planned redner forms are as followed,

- Representation (Marp)
- Wiki page (wiki.js)
- Web UI (Framework is not determined, yet)

Each render form is enabled as an extension module. Currently default m4 script
is both basic and representation macros. This will be changed in 0.2 and default
macro rules would only include non-representation directives. You have to enable
representation module if you want to render a slide form.

#### Ergonomic executable distribution

This is not about finalizing distribution process but about making it much more
ergonomic. This doesn't make independent windows build or something like that,
but about making end-user friendly install and command line wrapper script for
both window sand unix operating systems.

I found docker command execution is bit tedious and feels helpless when I don't
remember the exact commands. So gdmarp 0.2 will have separate script(sh or
powershell) to install and execute commands without recurring docker commands.

### Candidates for wiki backends

- mediawiki : Currently actively developed
Mature api, large userbase

- django-wiki
- wikijs

### TODO

### 0.2

* [ ] Test mediawiki\_bin execution
* [ ] Comment macro 
* [ ] Feature ::: Add "remove all unused macro expression" flag
* [ ] Make withmods variables can save multiple arguments

* [ ] Config feature
	* [x] Modules to include for preprocessing
	* [x] Consider making config format as json
	* [x] Add environmental variables
	* [ ] Config option to designate multiple render process. (Similar to MakeFile)

* [ ] Template functionality
	* [ ] Make local content template from system design
	* [ ] Make basic templates functionality which copys templates from bin folder or web 
	Integrate with subcommand flags

* [ ] Modular components
	* [x] Separate a global basic macro component.
	* [x] Separate a representation macro component.
	* [ ] Create new mediawiki backend macro component for wiki render forme.
		* [x] Make wikitext macros which are compatible with repr markdown macros
		* [ ] Automatic post page functionality binded to gdmarp script execution
	* [ ] Create new webui backend macro component. 
	(Consider bootstrap with pure javascript for better compatibility)

* [ ] Ergonomic program execution script for both windows and linux.
	* [ ] Windows powershell execution script.
	This is technically a wrapper around docker commands
	* [x] Posix compliant shell execution script.
		* [x] Include install command in gdmarp
		* [x] Change all bash speicifc syntax into posix compliant.
		* [x] Substitue array with something posix compliant.
		* [x] Posix sh compliant flag naming which is single character

* [x] Lightweight + ergonomic local project directory
	* [x] No more local css, m4 extension scripts
	* [x] An ergonomic include macro path processing which supports files that don't belong to an "inc" directory.

### 0.1

* [ ] **Enhance macro ergonomics**
	- Avoid meaningless verbosity
	- Improve argument rationale
	- Macro usage should not be ambiguous

* [ ] Improve documentation
	* [ ] Update macro.md
	* [ ] Add comment for internal macro implementations

* [ ] New macros
	* [ ] Background image macro
	* [ ] Fixed position image(or textbox) macro

* [ ] New features
	* [ ] Enable cache feature for easy maintenance of temporary files 
	Save compressed images and out.md in cache directory
	* [ ] Template feature
	Create pre-configured project structure
	* [ ] Auto publish content into python sphinx like web page.

#### Done

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
* [x] Make stiatc image/textbox macro
* [x] Image compression macro (Optipng for png, jpegoptim for jpeg)
* [x] Documentation is weak, make it happen before even I forget what it does

### Big TODO

* [ ] Make integrated auto html deployment service such as doxygen or sphinx
* [ ] Make alternative language for m4 and awk in rust.

#### Dropped todos (However this might change in future)

- Add table alignment option to csv macro 
- Modify csv macro so that user can input font size
Dropped becuase it makes macro usage overly complicated.

- Change class macro to get inputs delimited by comma not spaces.
For legacy support + Space delimited class is not that bad + using multiple
classes is somewhat buggy in terms of marp transition

- Add auto scale macro for texts with external programs
Unergonomic to do with simple unix programs or m4 macro processing

- Pandoc extension to create editable pptx file.
Not possible to create reproducible output from 'pdf->editable pptx' generation.
Thus it is better to separate responsibilites of creating a pptx and enabling editing.

- Advanced macro with various attributes
This makes macro usage very unergonomic while it is not so desperately needed.
Thus not worthwhile to implement, at least for now
