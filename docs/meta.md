### TODO

* [ ] Misc
	* [ ] Individual comment might be a bad idea, consider re-enabling global comment macro or make a specific custom syntax
	* [ ] Improve wikitext macros
	* [ ] Improve README
	* [ ] Consider making withmods variables can save multiple arguments

* [ ] Modular components
	* [ ] Create new webui backend macro component. 
		* [ ] Complete macros
		* [ ] Utilize bootstrap for aesthetics + functionality
	* [ ] Template module
		* [ ] Template macro sets
		* [ ] Template related configs

* [ ] Ergonomic program execution script for both windows and linux.
	* [ ] Windows powershell execution script.
	This is technically a wrapper around docker commands
	* [ ] New posix sh script for install and docker execution only

* [ ] New macros
	* [ ] Repr
		* [ ] Background image macro
		* [ ] Fixed position image(or textbox) macro
	* [ ] Wui
	* [ ] Wikitext

* [ ] New features
	* [ ] Enable cache feature for easy maintenance of temporary files 
	Save compressed images and out.md in cache directory

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
	* [x] Separate a global basic macro component.
	* [x] Separate a representation macro component.
	* [x] Create new mediawiki backend macro component for wiki render forme.
		* [x] Make wikitext macros which are compatible with repr markdown macros
		* [x] Table macro
		* [x] Automatic post page functionality binded to gdmarp script execution

* [x] Posix compliant binary
This was intended for alpine linux usage... however I found that I was extensively using gnu version of awk scripts and sed scripts. Thus a sole achievement of this refactor was docker size got slightly smaller. (Amount of bash's binary size) 


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
