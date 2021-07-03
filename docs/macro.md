### Macro rules (WIP)

**Currently gdmarp 0.2 is comfing and this document is very oudated.**

Macro starts with underscore. There are several macro rules that don't start with underscore which are mostly intended for internal usage.

### Naming convention

End user macro is in snake case. 
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

M4 translates comma as argument delimiter so you cannot put comma literal without escaping. 
There are two ways to escape comma literal. First is \. and second is _cc
macro. First way is to escape character with sed script. This is useful when
you need to escape character so that the character should be included in final
generated file content. Second is macro that converts string literal and
redirects to internal macro. Such usage is sql macro because sql queries' comma
should be consumed by sqlbuilder macro and redirected to sqlite3 binary.

General rule of thumb is to use comma literals only in text related macros and
try not to use comma in other macros other than sql macro.

Text macro and flex box macros handle comma literal so it is ok to use comma
literal in such macros. However csv macros or sql
macros currently doesn't support comma literal so you should always escape
comma to use comma as text. 

### Quote and backtick rules

Same thing applies to quote and backticks use "\;" for quote and "\~" for backtick.

### Basic macros

Basic macros are included regardless of given macro modules.

**If mod macro**

This includes the given texts only when a specific module was given to the
program. Argument should be a module name not a subcommand name.

_elif_mod is not necessary but you can only use _if_mod with _if_end, however
_if_mod without _if_end is a panic.

```
_h3(Global Header)
_if_mod(marp)
No wiki allowed in here
_elif_mod(mw)
No repr is in here.
_if_end()
```
Converts to
```
<!-- When the execution was : "gdmarp prep -M marp" -->
### Global Header

No wiki allowed in here

<!-- When the execution was : "gdmarp prep -M mw" -->
### Global Header

No repr is in here.
```

**Setting variable**

There are two ways to define variables in gdmarp. First is to define a macro in
env.m4 file. Other is to use _set_var macros inside of gdt files.

Please be aware that _set_var is same with m4's macro definition syntax. Which means you can nest other macros inside a _set_var macro.

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

While this is not so complete as a lorem ipsum generator. It is enough test a text occupied situation.

```
<!-- Argument is character count -->
_rand_text(30)
```
converts to
```
xtnjewq oslebt ejgffo eae renk
```

**Comma macro**

Comma macro is a very specific macro and currently only used by a _sql_table macro. This converts into a comma literal which should be consumed as it is by a parent macro.

```
_cc
```
converts to
```
,
```

**Web api macro**

Get response from url and parse the response with "jq" program.

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

Include macro to include other markdown files into index.md. You can only give
file name without extension if given file is markdown file and resides inside
of inc directory, else you should give a full file name. Lastly, include files
should be positioned inside of a directory given to the program as an
argument of a "-I" option.

e.g.)
Let's assume the file structure is as followed
.
├── ...
├── inc
│   └── new_file.md
└── outside.md

_inc(new_file) -> This is OK
_inc(new_file.md) -> This is OK
_inc(outside.md) -> This is OK
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

In this case other_file_name.md file's content will be pasted into where
macro was called.


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
  Indented <!-- Indentation is two spaces in markdown -->
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

Multiline texts are supported. Starting and trailing new lines are all removed from input.
First argument is font-size. 0 means default font-size which is 22px.
You can edit default font size in env.m4 file.

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

Simple img macros creates markdown img list.

Sized img macro creates markdown image text with marp favored attribute. First
argument scale of image and last elements are image file pathes.

Split sized img macro is same with sized img macro but sets standard width as
200% so that images fit well into split slide.

Default width(in fact, css:max-width) is 100% for sized img macros.

Compress macro compress image files with optipng and jpegoptim. And substitute
original file with compressed file. This does not affect original image file
nor original index.md file. It just changes out.md file and final product's
image source. 

```
_imgs(1.jpeg, 2.png)

_simgs(0 ,1.jpeg, 2.png)

_simgs(0.5 ,1.jpeg, 2.png)

_fimg(100px, 100px, 30%, 3.png)

_imgs(_comp(1.jpeg), _comp(2.png))

```
converts to

```
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

M4 macro converts comma as delimiter you can use _cc to input comma literal.
Text macro handles comma easily however sql macro is actually building another
macro and gets surplus arguments thus it may need different approach to allow
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

#### Title and contents slide

```
_tnc(This is title contents)
```

```
<!-- _class: tnc -->
# This is title contents
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
_url(http://url, MnemonicName)
```
Converts to

```
[http://url MnemonicName]
```

#### Imags

Keep in mind that mediawiki can display image that is uploaded to the server
and cannot reference web url image.

```
_image(file/path, MnemonicName)
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

**Space**

- top space
  - top left
  - top center
  - top right
- bot space
  - bot left
  - bot center
  - bot right

**Container**

- header
- container
- vcontainer
- footer

**Content, aka flex container**

- content
- content center
- vcontent
- vcontent center
- content scroll
- vcontent scroll

**Forms**

- inline group
- text input (with label)
- number input (with label)
- switch
- radio
- select
- checkbox
- range

**Misc**

- image
- icon
- paragraph
- button
- label
- centered label
- card

**Grid**

**Swap area**

**Collection**

**Modal**

**Sidebar**

#### Script macros

**Set properties**

**Set tooltip**

**Set callback**

**Callbacks**

- trigger an alert
- toggle an element
- sync a text
- visit an url
- trigger a event
- update a property
- show/hide a modal
- toggle sidebar
