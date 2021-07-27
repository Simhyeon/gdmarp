### TODO

* [ ] Bug
  * [x] Resource is not set properly due to build directory
  * [x] Include macro is not invoked
  This was because I escaped m4 quote to reseve _set_var macro
  Solution was to change the syntax of set var

* [ ] Misc
  * [ ] Check sanitization process
  For example special characters such as colon(;) can be problematic in esyscmd
  call if value is not printed as quoted form.
  * [ ] There are caveats with esyscmd and non quoted "$*" value, make this right
  * [ ] Improve macro.md
    * [ ] Add interface explanation for every macros in macro.md
	* [ ] Add class usage and explanation
  * [ ] Add submodule option
  * [ ] Make list element default to 1st level

* [ ] Modular components
  * [ ] Web ui
  * [ ] Docx(Microsoft word) module (uses latex internally)
    * [ ] Simple conversion
    * [ ] Formatting(Attribute) option 
	* [ ] Uses reference.docx
  * [ ] Dialogue module
    * [x] Multi formats other than html
    * [x] Make detailed window display on hover or click
	* [ ] Make immersive representation which is marp conversion with hyperlinks -> This has low priority
  * [ ] UML module
  * [ ] Conti module

* [ ] Check if windows can run gdmarp without docker

* [ ] New macros
  * [ ] Basic
  * [ ] Repr
    * [x] TOC with href 
    * [ ] Background image macro
    * [ ] Fixed position image(or textbox) macro
    * [ ] pptx template feature
  * [ ] Wui
    * [ ] Carousel
	* [x] Pop up menu
  * [ ] Wikitext

* [ ] New features

* [ ] Vs code extension for gdmarp program

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

* [x] Lightweight + ergonomic local project directory
  * [x] No more local css, m4 extension scripts
  * [x] An ergonomic include macro path processing which supports files that don't belong to an "inc" directory.

* [x] Comment macro 
* [x] Set Variable macro
* [x] Make mediawiki module to send useful logs to end users
* [x] Post installation script for docker usage (Mostly npm install)
* [x] Feature ::: Add "remove all unused macro expression" flag 
* [x] Implement -i flag to set input file for better extendability

* [x] Config feature
  * [x] Modules to include for preprocessing
  * [x] Consider making config format as json
  * [x] Add environmental variables
  * [x] Config option to designate multiple render process. (Similar to MakeFile)
  * [x] Config option to designate multiple render process but for test purposes

* [x] Modular components
  * [x] Dialogue module
    * [x] Create data structure macro
	* [x] Convert out.json into out.gv
    * [x] Utilize graphviz for visualization
	* [x] Added goto hyperlink feature
  * [x] Separate a global basic macro component.
  * [x] Separate a representation macro component.
  * [x] Create new mediawiki backend macro component for wiki render forme.
    * [x] Make wikitext macros which are compatible with repr markdown macros
    * [x] Table macro
    * [x] Automatic post page functionality binded to gdmarp script execution

* [x] Posix compliant binary
This was intended for alpine linux usage... however I found that I was extensively using gnu version of awk scripts and sed scripts. Thus a sole achievement of this refactor was docker size got slightly smaller. (Amount of bash's binary size) 

* [ ] Bug
  * [x] m4 consumes m4 quote even if the macro is not defined... which is a problem because _set_var uses same syntax
  * [x] url caused end of line becuase comment was double forward slash.

* [ ] Misc
  * [x] From macro enable no leading, trailing spaces, whitespaces variable utilization
  * [x] Make a preserve logic consistent
  * [x] Re-make purge option (-P all) with perl script
  * [x] Migrate from gdt to gddt file extension.
  * [x] Make simg macro's proportion argument to comply with other sizes or support various formats
  * [x] String literal rule without escaping any characters (BEGIN=/#, END=#/)
	* [x] Single liner
	* [x] Multiline
  * [x] Change default temporary files reside in cache directory.
  * [x] Make webui can be embedded into index.gddt
  * [x] Add borders by default
  * [x] Add automation macro with raw csv and file format

* [x] New macros
  * [x] Basic
  	* [x] Random text macro for test usage
    * [x] Make repeat macro
  * [x] Repr
  * [x] Wui
  	* [x] Complete todos
    * [x] Component macros
	  * [x] Input forms
      * [x] Swappable area macro
      * [x] List view macro (Scrollable Content)
      * [x] Menu macro(Sidebar)
      * [x] Modal macro
	  	* [x] Pop Up Style
	  	* [x] Screen touch
	  * [x] Dialogue
	  * [x] Advanced style macro

### Big TODO

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
