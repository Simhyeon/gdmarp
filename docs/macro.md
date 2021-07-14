### Macro rules (WIP)

### Comments

Comments start with double forward slash ```//```.

Macros followed by ```//``` will be ignored and not expanded.

### Naming convention

End user macro is in snake case with underscore prefix.
```
_macro_name_with_long_text()
```

A variable name is prefixed with v.
```
v_name_for_variable()
```

An interal use macro name is prefixed with m.
```
m_not_intended_for_user()
```

### Comma rules

M4 translates comma as argument delimiter so you cannot put comma literal
without escaping.  There are two ways to escape comma literal. First is
```\.``` and second is ```_cc``` macro. First way is to escape character with
sed script. This is useful when you need to escape character so that the
character should be included in final generated file content. Second is a macro
that converts string literal and redirects comma literal to other internal
macro. Thus ```_cc``` macro simply postpone direct evaluation for once and
should not be used if comma is required to be printed in final result.

General rule of thumb is to use comma literals only in text related macros and
us ```\.``` in other macros.

### Other escape rules

- Backtick(`) : \\;
- Quote(') : \\~

### Using string literal directives

You can use string literal within ```\#``` and ```/#```. Thus every strings
between them will be interpreted as it is. I recommend using string literal
statements if you're writing long texts with unallowed characters.

String literal directives can be single line or multi line.

e.g)
```
_macro_with_long_arguments(/#I'm sentence with quotes, commas and some even double quote "Which is cool"#/)

_macro_multi_lines(/#
	`This' also works too, which is "good".
#/)
```

_label()

### Basic macros

Basic macros are included regardless of given macro modules.

**Repeat macro**

Repeat given content for given times.

Before
```
_repeat(5,_icon(star-fill))

<!-- while _icon(star-fill) yields ... -->
<i class="bi bi-star-fill">
```
After
```
<!-- gdmarp wui -M bts  -->
<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
```

**If mod macro**

This includes the given texts only when a specific module was given to the
program. Argument should be a module name not a subcommand name.

```_elif_mod``` is not necessary and you can only use ```_if_mod``` with
```_fi_end```, however ```_if_mod``` without ```_fi_end``` is a panic.

```
_h3(Global Header)
_if_mod(marp)
No wiki allowed in here
_elif_mod(mw)
No repr is in here.
_fi_end()
```
Converts to
```
<!-- When the execution was : "gdmarp prep -M marp" -->
### Global Header

No wiki allowed in here

<!-- When the execution was : "gdmarp prep -M mw" -->
===Global Header===

No repr is in here.
```

**Setting variable**

There are two ways to define variables in gdmarp. First is to define a macro in
env.m4 file. Other is to use _set_var macros inside of gddt files.

Please be aware that ```_set_var```'s syntax is same with m4's macro definition syntax. Which means you can nest other macros inside a _set_var macro too.

```
<!-- Arg order is "Varaible name" followed by "substituted text" -->
_set_var(`v_simple_name', `Some repeated text that is a waste of typing and readability')dnl

v_simple_name()
```
Converts to
```
Some repeated text that is a waste of typing and readability
```

**Random text macro**

While this is not so complete as a lorem ipsum generator. It is enough to test
a text occupied situation.

Before
```
<!-- Argument is character count -->
_rand_text(30)
```
After
```
xtnjewq oslebt ejgffo eae renk
```

**Comma macro**

Comma macro is a very specific macro and currently only used by a _sql_table
macro. This converts into a comma literal which should be consumed as it is by
a parent macro.

Before
```
_cc
```
After
```
,
```

**Web api macro**

Get a response from a given url and parse the response with ```jq``` program.

```
_wapi(http://url/api/get, .env.value)

<!-- While received data is as followed-->
{
	env : {
		value: "Some Value"
	}
}
```
converts to
```
Some value
```

**Include other files**

Include macro to include other markdown files' content.  You can only give file
name without extension if given file is gddt file and resides inside of inc
directory, else you should give a full file name. Lastly, include files should
be positioned inside of a directory given to the program as an argument of a
```-I``` option.

e.g.)
Let's assume the file structure is as followed
```
.
├── ...
├── inc
│   └── new_file.gddt
└── outside.gddt
```

_inc(new_file) -> This is OK

_inc(new_file.gddt) -> This is OK

_inc(outside.gddt) -> This is OK

_inc(outside) -> This is Error

Macro usage:
```
Preceding lines
_inc(other_file_name)
Following lines

<!-- Let's say other_file_name's content is as followed-->
Included lines
```
Converts to
```
Preceding lines
Included lines
Following lines
```

### Representaion macros (Marp module)

#### Basic markdown syntax macros

Using raw markdown syntax is fine, but for multi-format rendering macros are recommended.

**Headers**

Before
```
_h1(h1)
_h2(h2)
_h3(h3)
_h4(h4)
_h5(h5)
```
After
```
# h1
## h2
### h3
#### h4
##### h5
```

**Emphasis**

Before
```
_b(Bold)
_i(Italic)
_bi(BoldItalic)
_st(StrikeThrough)
_ud(Underline)
```
After
```
**Bold**
*Italic*
***BoldItalic***
~~StrikeThrough~~
__Underline__
```

**Indentation**

Before
```
_idt(1) Indented
_idt(2) Indented2
```
After
```
<!-- Indentation is two spaces in markdown -->
  Indented 
    Indented2
```

**Lists**

Before
```
_ul(1)
_ul(2)
_ol(first)
_ol(second)
```
After
```
* 1
  * 2
1. first
  1. second
```

**New Page**

Normally triple dash is a horizontal line, but ```marp```, which is a markdown to
slide generator, treates horizontal line as page separator.

Before
```
_new_page()
```
After
```
---
```
#### Styles 

Multiple styles are supported. Simply type multiple css stylesheets delimtied
by comma. Styles macro can be included only one time.

```
_styles(file_name.css, other.css)
```
expands to
```
<script>
/* file_name.css */
section.title {
  --title-height: 130px;
  --subtitle-height: 70px;

  overflow: visible;
  display: grid;

...
/* other.css */
table {
	width: 100%;
	display: table;
}

table td{
...

</script>
```

The built-in css files list is follwed as
- layout.css
- table.css
- image.css

#### Texts

Multiline texts are supported. Leading and trailing new lines are all removed
from input.  First argument is a font-size. 0 means default font-size which is
22px. You can edit default font size in env.m4 file.

```
_text(30, Big texts are printed)

_text(0, 
This is simple text

- This is a list item
	- with nestedness
	- and some **bold** text
)
```
expands to

```
<div style="font-size: 30px;">

Big texts are printed

</div>
<div style="font-size: 22px;">

This is simple text

- This is a list item
	- with nestedness
	- and some **bold** text

</div>
```

#### Img macro

Simple img macros creates markdown imgs list.

Sized img macro creates markdown image with marp favored attribute. First
argument is an css value for width and other elements are for image file
pathes.

Default width(is in fact a max-width) is 100% for sized img macros.

Compress macro compress image files with optipng and jpegoptim. And substitute
an original file with compressed file. This does not affect original image file
nor original index.gddt file. It just changes out.gddt file and final product's
image source. 

```
// Alt text is optional
_img(1.jpeg, alt_text)

_imgs(1.jpeg, 2.png)

_simgs(0, 1.jpeg, 2.png)

_simgs(50% ,1.jpeg, 2.png)

_fimg(3.png, alt_text, 100px, 100px, 30%)

_imgs(_comp(1.jpeg), _comp(2.png))

```
converts to

```
![](1.jpeg)

![](1.jpeg)
![](2.png)

<div style="flex: 1;"><img src="1.jpeg" style="width: 100%; max-width: 100.00%; max-height: auto;"></img></div>
<div style="flex: 1;"><img src="2.jpeg" style="width: 100%; max-width: 100.00%; max-height: auto;"></img></div>

<div style="flex: 1;"><img src="1.jpeg" style="width: 100%; max-width: 50.00%; max-height: auto;"></img></div>
<div style="flex: 1;"><img src="2.jpeg" style="width: 100%; max-width: 50.00%; max-height: auto;"></img></div>

<div style="position: fixed; top: 100px; left: 100px;">
<img style="width: 30%;" src="3.png"></img>
</div>

![](1_comp.jpeg)
![](2_comp.png)
```

#### Wrapper macro

This is intended to use with other macros

Center macro makes image centered
```
_center(_imgs(_comp(1.jpeg)))
```
converts to
```
<div style="text-align:center; display:block; margin: 0 auto;">

![](ppp_comp.png)</div>
```

#### CSV

Csv macro reads csv file and converts into github flavored markdown format. 

```
_csv(test.csv)

<!-- While test.csv is followd as-->
foo,bar,baz
1,2,3
4,5,6
```

converts to

```
| foo | bar | baz |
| --- | --- | --- |
| 1   | 2   | 3   |
| 4   | 5   | 6   |
```

Raw csv macro reads raw csv input and converts into github flavored markdown format

```
_rcsv(
name,mail,address
simon,123@g.com,somesome
creek,345@n.com,anywhere
)
```

converts to 

```
| name  | mail      | address  |
| ----- | --------- | -------- |
| simon | 123@g.com | somesome |
| creek | 345@n.com | anywhere |
```

Web csv macro wih jq syntax

```
_wcsv(http://some_url/api/get_csv&key=Encoding, .env.value)

<!-- While received data is as followed-->
{
	env : {
		value: "foo,bar,baz\n1,2,3\n4,5,6"
	}
}
```

Converts so 

```
| foo | bar | baz |
| --- | --- | --- |
| 1   | 2   | 3   |
| 4   | 5   | 6   |
```

Advanced table macros enable users to use multiline texts inside markdown table

```
<!-- Start table -->
_ts()

<!-- Set font size for header and body, this is **optional** -->
<!-- It is impossible to make ergonomic way to change font sizes respectively-->
_tfont(30, 16)

<!-- Header -->
_th(Name, email, description)

<!-- Table row -->
_tr(Simon, 123@gmail.com,
- List can be inserted inside markdown
	- Nested lists too
1. With some ordered list
)
<!-- Table row -->
<!-- Single line is required to make paragraphs work-->
_tr(Creek, 456@naver.com,
Simple texts without listing

can be inserted
)
<!-- Table end -->
_te()
```

converts to

```
<table>

<style scoped>
        thead > tr > td { font-size: 30px !important; }
        :not(thead) > tr > td { font-size: 16px !important; }
</style>

<thead>
    <td>
        <p>Name</p>
    </td>
    <td>
        <p>email</p>
    </td>
    <td>
        <p>description</p>
    </td>
</thead>

<tr>
    <td>
        <p>Simon</p>
    </td>
    <td>
        <p>123@gmail.com</p>
    </td>
    <td>
        <ul><li>List can be inserted inside markdown</li><ul><li>Nested lists too</li></ul><li>With some ordered list</li></ul>
    </td>
</tr>
<tr>
    <td>
        <p>Creek</p>
    </td>
    <td>
        <p>456@naver.com</p>
    </td>
    <td>
        <p>Simple texts without listing</p><p>can be inserted</p>
    </td>
</tr>
</table>
```

#### SQL macro

This macro reads csv file from local path and read into in-memory sqlite3 database. You can set query statement and substitute macro with query result formatted as github flavored table.

M4 macro converts comma as delimiter. You can use _cc to input comma literal.
Text macro handles comma easily however sql macro is actually building another
macro and gets surplus arguments, thus it needs different approach to allow
comma literal.

Sql macro doesn't sanitize macro becuase it only read csv file as in-memory
database. However it is always a good idea to take care when you create sql
queries.

You can set sqlite3 path within env.m4 file.

```
_sql_table(csv_path.csv, table_name,
SELECT id _cc room_id FROM table_name;)

<!-- Where csv data is followed as-->
id,name,room_id
1,simon,26
2,jim,99
3,creek,56
4,keller,48
```
converts to
```
| id | room_id |
| -- | ------- |
| 1  | 26      |
| 2  | 99      |
| 3  | 56      |
| 4  | 48      |
```

#### Flex text box

Flex text box creates flex display text box. This is intended when using
multiple text boxes in split slide.

Font flex box gets font size as first argument.


```
_fbox( text content )

_ffbox(16, text content with examples)
```

```
<div style="flex:1;">

text content

</div>

<div style="flex:1; font-size:16px;">

text content

</div>
```

#### Class

Set current section or slide's class which accords to marp class declaration.
Argument after comma is ignored.
```
_cls(split gdtable)
```
converts to

```
<!-- _class: split gdtable -->
```

#### Title

Shorthand for using title class

```
_title(Main Title, Subtitle)
```

converts to

```
<!-- _class: title -->

# Main Title
## Subtitle
```
#### Split Slide 

Split macro enables easier way to make current slide split slide with left and
right column

```
<!--  Split slide needs split class -->
_cls(split)

<!-- Start left column -->
_left()

Left contents go here

<!-- Start right column -->
_right()

Right contents go here

<!-- End column -->
_end()
```

converts into

```
<!-- _class: split -->

<div class="ldiv">

Left contents go here

</div>
<div class="rdiv">

Right contents go here

</div>
```

### Wikitext macros (mw module)

#### Basic syntax

**Headers**

Before
```
_h1(h1)
_h2(h2)
_h3(h3)
_h4(h4)
_h5(h5)
```
After
```
<!-- Mediawiki considers h1 to title so h1 is simply a fallback for h2 -->
==h1==
==h2==
===h3===
====h4====
=====h5=====
```

**Emphasis**

Before
```
_b(Bold)
_i(Italic)
_bi(BoldItalic)
_st(StrikeThrough)
_ud(Underline)
```
After
```
'''Bold'''
''Italic''
'''''BoldItalic'''''
<s>StrikeThrough</s>
<u>Underline</u>
```

**Lists**

Before
```
_ul(1)
_ul(2)
_ol(first)
_ol(second)
```
After
```wikitext
* 1
** 2
# first
## second
```

**Indentation**

Before
```
_idt(1) Indented
_idt(2) Indented2
```
After
```
: Indented
:: Indented2
```

#### Links

Wiki interal page link
```
_wiki_page(http://url)
<!-- Alt addes alternative name or say mnemonic name to the link -->
_wiki_page_alt(http://url MnemonicName) 
```

Converts to

```
[[http://url]]
[[http://url|MnemonicName]]
```

External link

```
_url(http://url)
_url(http://url,MnemonicName)
```
Converts to

```
[http://url]
[http://url MnemonicName]
```

#### Imags

Keep in mind that mediawiki can only display an image that is uploaded to the
server and cannot reference web url image.

```
_img(file/path, MnemonicName)
```

Converts to

```
[[File:file/path|alt=MnemonicName]]
```

#### Table

Basic table syntax is given as csv format.

```
<!-- Reading csv from a given file -->
_csv(test.csv)

<!-- While test.csv is followd as-->
foo,bar,baz
1,2,3
4,5,6

<!-- Or you can simply give raw csv -->
_rcsv(foo,bar,baz
1,2,3
4,5,6)
```
Both converts to

```
{| class="wikitable"
|+ wikitable
|-
! foo !! bar !! baz
|-
| 1 || 2 || 3
|-
| 4 || 5 || 6
|-
|}
```

### WebUI macros (bts module)

#### Directives macro

**UI start and end macro**

Every webui's component macros should be positioned between ui start and ui end
macro. Unpaired single macro is a panic.

```
_ui_begin(Page title name)
<!-- UI macros and html tags should be here -->
_ui_end()
```
converts to
```
<!-- This is for interal usage and you don't have to understand -->
divert(`-1')
_set_var(`m_webui_title', `Page title name')
_set_var(`m_webui_content', `shift(Page title name, ...
)')
divert`'dnl
```

**Script begin and end macro**

Every webui's script(function) macros should be positioned between script start
and script end macro. Unpaired single macro is a panic.

```
_script_begin()
<!-- Script macros go here -->
_script_end()
```
converts to
```
<!-- This is for interal usage and you don't have to understand -->
_set_var(`m_webui_script', `
	...
')
```

#### Component macros

This part illustrates how macros are expanded rather than how it should be
used. I fixed a formatting aftward for better readabiltity because raw output is
rather hard to read. Please refer a demo for redered screen.

**Space**

Top space is in top of the page while bot space is in bottom of the page.

You have to give all ```top_left```, ```top_center```, ```top_right``` for
proper formatting. This also applies for bot_space

Before
```
_top_space(
	_top_left(Left)
	_top_center(Center)
	_top_right(Right)
)

<!-- Container goes here between spaces -->

_bot_space(
	_bot_left(Left)
	_bot_center(Center)
	_bot_right(Right)
)
```
After
```
<div id="topSpace" class="topSpace">
	<div id="topLeft" class="topLeft">
		Left
	</div>
	<div id="topCenter" class="topCenter">
		Center
	</div>
	<div id="topRight" class="topRight">
		Right
	</div>
</div>

<div id="botSpace" class="botSpace">
	<div id="botLeft" class="botLeft">
		Left
	</div>
	<div id="botCenter" class="botCenter">
		Center
	</div>
	<div id="botRight" class="botRight">
		Right
	</div>
</div>
```

**Container**

Container macro is used only once unlike a content macro. Container macro is a
semantic indicator how space is composed. Actually container also determineds
page's orientation too. Header and footer are to be used within of a container.

Before
```
<!-- vcontainer makes vertically aligned page while container makes
horizontally aligned page -->
_vcontainer(
	_header(
		Header Content
	)
	Other contents
	_footer(
		Footer Content
	)
)
```
After
```
<div id="container" class="gdContainer colFlex hiddenFlow">
	<div id="header" class="gdHeader">
		Header Content
	</div>
	Other contents
	<div id="footer" class="gdFooter">
		Footer Content
	</div>
</div>
```

**Content, aka flex container**

Content macro is a simple wrapper or division with flexible composition. Use
nested content macros to create a desired layout.

Width and height is hard to measure with fixed unit. Use percent for sanity.
e.g.) _content(id,50%, content)

Basic content syntax is 
```
<!-- Vertical content gets height while (horizontal) content gets width-->
_content_name(Id of content,Width or height,Content to be displayed)

<!-- Give empty arguments to set no id or sest size to 100% -->
_content(,,Content to be displayed)
```

Before
```
_content(contentId,width,
	This is content
)
_content_center(contentId,width,
	This is content with centering
)
_vcontent(contentId,height,
	This is vertcial content
)
_vcontent_center(contentId,height,
	This is vertcial content with centering
)
_content_scroll(contentId,width,
	This is content with scroll view
)
_vcontent_scroll(contentId,height,
	This is vertical content with scroll view
)
```
After
```
<div id="contentId" class="gdContent rowFlex fullSize hiddenFlow width" style="width: width;">
	This is content
</div>
<div id="contentId" class="gdContent rowFlex fullSize flexCenter hiddenFlow width" style="width: width;">
	This is content with centering
</div>
<div id="contentId" class="gdContent colFlex fullSize hiddenFlow height" style="height: height;">
	This is vertcial content
</div>
<div id="contentId" class="gdContent colFlex flexCenter fullSize hiddenFlow height" style="height: height;">
	This is vertcial content with centering
</div>
<div id="contentId" class="fullSize" style="width: width; overflow-x: scroll;">
	This is content with scroll view
</div>
<div id="contentId" class="fullSize" style="height: height; overflow-y: scroll;">
	This is vertical content with scroll view
</div>
```

**Forms**

Forms are interactive ui element to input data.

Before
```
<!-- Text input -->
_tinput(inputId,Placeholder texts)
<!-- Text input with a label -->
_tinput_label(inputId,Placeholder texts,Label for input)
<!-- Number input -->
_ninput(inputId,Placeholder number)
<!-- Number input with a label -->
_ninput_label(inputId,Placeholder number, Label for input)
<!-- On/Off switch -->
_switch(inputId,Label for switch)
<!-- Buttons that turn off each other -->
_radio(inputId,radio1,radio2,radio3)
<!-- This is called selection but identical to drop down menu -->
_sel(inputId,
	_sel_item(Value1)
	_sel_item(Value2)
	_sel_item(Value3)
)
<!-- Literally, a checkbox-->
_checkbox(inputId,Label for checkbox)
<!-- Slider that you can drag between min and max numbers -->
_range(inputId,Label for range,minNumber,maxNumber)
```
After
```
<!-- Text input -->
<input id="inputId" type="text" class="form-control" placeholder="Placeholder texts" aria-label="Username" aria-describedby="basic-addon1">

<!-- Text input with a label-->
<div class="input-group mb-3">
	<span class="input-group-text" id="inputIdLabel">Label for input</span>
	<input id="inputId" type="text" class="form-control" placeholder="Placeholder texts" aria-label="Username" aria-describedby="basic-addon1">
</div>

<!-- Number input -->
<input id="inputId" type="number" class="form-control" placeholder="Placeholder number" aria-label="Username" aria-describedby="basic-addon1" onkeypress="return onlyNumberKey(event)">

<!-- Number input with a label-->
<div class="input-group mb-3">
	<span class="input-group-text" id="inputIdLabel">Label for input</span>
	<input id="inputId" type="number" class="form-control" placeholder="Placeholder number" aria-label="Username" aria-describedby="basic-addon1" onkeypress="return onlyNumberKey(event)">
</div>

<!-- Switch-->
<div class="form-check form-switch">
	<input class="form-check-input" type="checkbox" id="inputId">
	<label class="form-check-label" for="inputId" id="inputIdLabel">Label for switch</label>
</div>

<!-- Radio -->
<div id="inputId" class="radioGroup">
	<div class="form-check ">
		<input class="form-check-input" type="radio" name="inputId" id="radio1" value="radio1">
		<label class="form-check-label" for="radio1" id="radio1Label">radio1</label>
	</div>
	<div class="form-check ">
		<input class="form-check-input" type="radio" name="inputId" id="radio2" value="radio2">
		<label class="form-check-label" for="radio2" id="radio2Label">radio2</label>
	</div>
	<div class="form-check ">
		<input class="form-check-input" type="radio" name="inputId" id="radio3" value="radio3">
		<label class="form-check-label" for="radio3" id="radio3Label">radio3</label>
	</div>
</div>

<!-- Select -->
<select id="inputId" class="form-select" aria-label="Default select example">
	<option value="Value1">Value1</option>
	<option value="Value2">Value2</option>
	<option value="Value3">Value3</option>
</select>

<!-- Checkbox -->
<div class="form-check">
	<input class="form-check-input" type="checkbox" value="" id="inputId">
	<label class="form-check-label" for="flexCheckDefault" id="inputIdLabel">
		Label for checkbox
	</label>
</div>

<!-- Range -->
<label for="inputId" class="form-label" id="inputIdLabel">Label for range</label>
<input type="range" class="form-range" id="inputId" min="minNumber" max="maxNumber">
```

**Inline group**

Elements except radio is all "outlined", which means they don't reside in same
lines. You can inline elements with inline macro.

Before
```
_inline(
	_checkbox(1,1)
	_checkbox(2,2)
	_checkbox(3,3)
)
```
After
```
<div class="inlineGroup">
	<div class="form-check">
		<input class="form-check-input" type="checkbox" value="" id="1">
		<label class="form-check-label" for="flexCheckDefault" id="1Label">
			1
		</label>
	</div>
	<div class="form-check">
		<input class="form-check-input" type="checkbox" value="" id="2">
		<label class="form-check-label" for="flexCheckDefault" id="2Label">
			2
		</label>
	</div>
	<div class="form-check">
		<input class="form-check-input" type="checkbox" value="" id="3">
		<label class="form-check-label" for="flexCheckDefault" id="3Label">
			3
		</label>
	</div>
</div>
```

**Misc**

Miscellaneous macros for various components.

Before
```
<!-- Image -->
_img(imgSrcUrl,alt text, imgId, size)
<!-- Button -->
_btn(btnId, ButtonLabel)
<!-- Icon -->
<!-- IconType is a bootstrap icon class with preceding "bi-" stripped  -->
_icon(iconType)
<!-- Card form component -->
_card(cardId,cardTitle,cardContent)
<!-- Card with image on top -->
_card_img(cardId,cardTitle,imgSrcUrl,cardContent)
<!-- Paragraph -->
_p(Content)
<!-- Simple text label -->
_label(labelId,text)
<!-- Simple text label with centering-->
_label_center(labelId,text)

```
After
```
<!-- Image -->
<img id="imgId" class="img" style="width: ratio; height: ratio;" src="imgSrcUrl" alt="!!Image Not FOUND!!"></img>
<!-- Button -->
<button id="btnId" class="flexGrow btn btn-primary">ButtonLabel</button>
<!-- Icon -->
<i class="bi bi-iconType"></i>
<!-- Card -->
<div id="cardId" class="card card-body">
	<h5 class="card-title">cardTitle</h5>
	cardContent
</div>
<!-- Card with image -->
<div id="cardId" class="card card-body">
	<img src="imgSrcUrl" class="card-img-top" alt="!!Card Image is not found!!">
	<h5 class="card-title">cardTitle</h5>
	cardContent
</div>
<!-- Paragraph -->
<p>Content</p>
<!-- Label -->
<div id="labelId" class="">
	text
</div>
<!-- Label center -->
<div id="labelId" class="flexGrow gdLabel">
	text
</div>
```

**Grid**

The grid macro creates a sqaure grid, which is an uniformly distributed grid.

Before
```
_grid(grid,3,
	_grid_cell(g1,1)
	_grid_cell(g2,2)
	_grid_cell(g3,3)
	_grid_cell(g4,4)
	_grid_cell(g5,5)
)
```
After
```
<div class="gridContainer" id="grid" style="grid-template-columns: repeat(auto-fill, minmax( 33%, 1fr));">
	<div id="g1" class="grid"><div class="gridContent">
		1
	</div></div>
	<div id="g2" class="grid"><div class="gridContent">
		2
	</div></div>
	<div id="g3" class="grid"><div class="gridContent">
		3
	</div></div>
	<div id="g4" class="grid"><div class="gridContent">
		4
	</div></div>
	<div id="g5" class="grid"><div class="gridContent">
		5
	</div></div>
</div>
```

**Swap area**

Note : I'm not sure if there is any existing terminology to refer a "Swap" ui,
but I'm no expert in UI, so I'll just stick to a term swap.

Swap areas are like a deriative of an accordian ui but with remote control. Swap
consists of two parts, swap buttons and swap areas. Swap buttons control which
content to show in swap areas.

Before
```
_swap_buttons(swapGroupId,swap1,swap2,swap3)

<!-- Important: swap item's second argument should be parent element's id -->
<!-- Important: swap item's id should be same with swap_buttons' id -->
_content(parentId,,
		_swap_item(swap1,parentId,This is first)
		_swap_item(swap2,parentId,This is first)
		_swap_item(swap3,parentId,This is first)
)
```
After
```
<div id="swapGroupId" class="btn-group" role="group">
	<input type="radio" class="btn-check" name="swapGroupId" value="no" id="swap1"
	       aria-expanded="false"
	       aria-controls="swap1"
	       data-bs-toggle="collapse"
	       data-bs-target="#swap1">
	<label class="btn btn-outline-primary" for="swap1">swap1</label>
	<input type="radio" class="btn-check" name="swapGroupId" value="no" id="swap2"
	       aria-expanded="false"
	       aria-controls="swap2"
	       data-bs-toggle="collapse"
	       data-bs-target="#swap2">
	<label class="btn btn-outline-primary" for="swap2">swap2</label>
	<input type="radio" class="btn-check" name="swapGroupId" value="no" id="swap3"
	       aria-expanded="false"
	       aria-controls="swap3"
	       data-bs-toggle="collapse"
	       data-bs-target="#swap3">
	<label class="btn btn-outline-primary" for="swap3">swap3</label>
</div>

<div id="parentId" class="gdContent rowFlex fullSize hiddenFlow flexGrow" style="width: ;">
	<div id="swap1" class="collapse" data-bs-parent="#parentId">
		This is first
	</div>
	<div id="swap2" class="collapse" data-bs-parent="#parentId">
		This is first
	</div>
	<div id="swap3" class="collapse" data-bs-parent="#parentId">
		This is first
	</div>
</div>
```

**Collection**

This name sounds somewhat fancy, but this is actually a helper macro to create
multiple elements with atuomated generation of given element.

Before
```
<!-- Horizontal alignment -->
_coll(collId,2,_btn(,Button Label))

<!-- Vertical alignment -->
_vcoll(collId,2,_btn(,Button Label))
```
After
```
<div id="collId" class="gdCollection rowFlex">
	<button id="" class="flexGrow btn btn-primary">Button Label</button>
	<button id="" class="flexGrow btn btn-primary">Button Label</button>
</div>

<div id="collId" class="gdCollection colFlex">
	<button id="" class="flexGrow btn btn-primary">Button Label</button>
	<button id="" class="flexGrow btn btn-primary">Button Label</button>
</div>
```

**Modal**

Modal is a modal. There are two types of modal. One is a traditional modal and
other is a full screen modal that intercepts of all input until user clicks a
screen aka screen touch.

Modals are not visible in a page and you have to add trigger(callbacks) to show
modals. Refer a script section. Or even better, you can define your own
javascript callback functions with event listener.

You can declare a modal or screen touch anywhere, but I recommend separating it
from other normal elements that are always shown so that artifacts don't occur.
A general rule of thumb is to declare hidden elements right before ```_ui_end``` macro.

Before
```
_modal(modalId, Header Content, Body Content, Footer content)

_screen_touch(modalId, Text to display in center)
```
After
```
<!-- Normal modal -->
<div class="modal fade" id="modalId" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">Header Content</h5>
				<button type="button" class="btn-close modal-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				Body Content
			</div>
			<div class="modal-footer">
				Footer content
			</div>
		</div>
	</div>
</div>

<!-- Screen touch -->
<div class="modal" id="modalId" tabindex="-1" aria-hidden="true" onclick="hideModal">
	<div class="modal-dialog modal-fullscreen">
		<div class="modal-content modal-tp text-white">
			<button type="button" style="display: none;" class="modal-close" data-bs-dismiss="modal" aria-label="Close"></button>
			<div class="modal-body" style="display: flex; justify-content: center; align-items: center;">
			Text to display in center
			</div>
			<div class="modal-footer" style="border: 0; justify-content: center;">
				Click to dismiss
			</div>
		</div>
	</div>
</div>
```

**Sidebar**

Sidebar is a floating sidemenu that doesn't push main contents aside. You should add a trigger to toggle the sidebar.

Before
```
<!-- Left sidebar -->
_sidebar_left(sidebarId, Content to be displayed)

<!-- Right sidebar -->
_sidebar_right(sidebarId, Content to be displayed)
```
After
```
<!-- Left sidebar>
<div class="offcanvas offcanvas-start" tabindex="-1" id="sidebarId">
	<div class="offcanvas-header">
		<h5 class="offcanvas-title" id="sidebarIdLabel"></h5>
		<button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
	</div>
	<div class="offcanvas-body">
		Content to be displayed
	</div>
</div>

<!-- Right sidebar>
<div class="offcanvas offcanvas-end" tabindex="-1" id="sidebarId">
	<div class="offcanvas-header">
		<h5 class="offcanvas-title" id="sidebarIdLabel"></h5>
		<button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
	</div>
	<div class="offcanvas-body">
		Content to be displayed
	</div>
</div>
```

#### Script macros

Script macros add functionality to existing elements. 

Every webui's script(function) macros should be positioned between the script
start and script end macro.

Every script macro expands to javascript functions that are defined by the bts
module.

**Set properties**

Whlie this macro was intended as a callback. But you can directly invoke a
macro to change html tag's properties. You know what you are doing if you can
understand what properties do.

Before
```
_call_update(targetId,propsId,propsValue)
```
After
```
setProperties(targetId,propsId,propsValue)
```

**Set tooltip**

This set toolip for a given id. Tooltip is displayed when you hover over an element.

Before
```
_add_tooltip(targetId,This is some very useful tooltip)
```

After
```
setProperties("targetId",{"data-bs-toggle":"tooltip","data-bs-placement":"top","title":"This is some very useful tooltip"})
```

**Set callback**

You can set callbacks, or functions that invoked when specific events occurs, with macros.

```
<!-- Bare bone-->
_add_call(targetId,eventType,javascriptCode)

<!-- Real usage -->
<!-- comma is escaped with \\. to prevent evaluation -->
_add_call(buttonId,click,_call_alert(Yo yo\\. you pressed "the" button.))
```
```
addCallback("targetId", "eventType",(ev) => {javascriptCode})

addCallback("targetId", "click",(ev) => {alert("Yo yo, you pressed "the" button.")})
```

**Callbacks**

There are several pre-defined macros for setting callback for an element.
Callback macros are used as conjuction with ```_add_call``` macro's argument.

Before
```
<!--trigger an alert-->
_call_alert(Alert text)

<!--toggle an element-->
_call_toggle(targetId)

<!--sync a text-->
_call_sync_text(targetId)

<!--visit an url-->
_call_visit(url)

<!--trigger a event-->
_call_event(targetId, eventType)

<!--update a property-->
_call_update(targetId,propsId,propsValue)

<!--show/hide a modal-->
_call_modal(modalId)
_hide_modal(modalId)

<!--toggle sidebar-->
_call_sidebar(sidebarId)
```
After
```
<!--trigger an alert-->
alert("Alert text")
<!--toggle an element-->
toggleElement("targetId")
<!--sync a text-->
syncText("targetId",ev)
<!--visit an url-->
window.location="url"
<!--trigger a event-->
triggerEvent("targetId" , "eventType")
<!--update a property-->
setProperties("targetId",{"propsId" : "propsValue"})
<!--show/hide a modal-->
callModal("modalId")
hideModal("modalId")
<!--toggle sidebar-->
toggleSidebar("sidebarId")
```
