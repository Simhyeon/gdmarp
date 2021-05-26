### TODO

#### Imminent

* [ ] Enhance macro ergonomics

* [ ] Enable cache feature for easy maintenance of temporary files 
Save compressed images and out.md in cache directory

* [ ] Update macro.md
Add newy added macro usage

* [ ] Background image macro
This is easier than others

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
