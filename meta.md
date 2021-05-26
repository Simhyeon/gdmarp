### TODO

#### Imminent

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
