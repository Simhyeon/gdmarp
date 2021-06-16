### Macro rules (WIP)

Macro starts with underscore. There are several macro rules that don't start with underscore which are mostly intended for internal usage.

### Comma rules

M4 translates comma as argument delimiter so you cannot put comma literal without escaping. 
There are two ways to escape comma literal. First is \. and second is _cc macro. First way is to escape character with sed script. This is useful when you need to escape character so that the character should be included in final generated file content. Second is macro that converts string literal and redirects to internal macro. Such usage is sql macro because sql queries' comma should be consumed by sqlbuilder macro and redirected to sqlite3 binary.

General rule of thumb is to use comma literals only in text related macros and try not to use comma in other macros other than sql macro.

Text macro and flex box macros handle comma literal so it is ok to use comma literal in such macros. However csv macros or sql
macros currently doesn't support comma literal so you should always escape comma to use comma as text. 

#### Styles 

Multiple styles are supported. Simply type multiple css stylesheets delimtied by comma. Styles macro can be included only one time.

```
_styles(some_path/file_name.css, other.css)
```
expands to
```
<script>
<!-- some_path/file_name.css -->
section.title {
  --title-height: 130px;
  --subtitle-height: 70px;

  overflow: visible;
  display: grid;

...
<!-- other.css -->
table {
	width: 100%;
	display: table;
}

table td{
...

</script>
```

Built-in css files list are follwed as
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

Sized img macro creates markdown image text with marp favored attribute. First argument scale of image and last elements are image file pathes.

Split sized img macro is same with sized img macro but sets standard width as 200% so that images fit well into split slide.

Default width(in fact, css:max-width) is 100% for sized img macros.

Compress macro compress image files with optipng and jpegoptim. And substitute original file with compressed file. This does not affect original image file nor original index.md file. It just changes out.md file and final product's image source. 

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
Text macro handles comma easily however sql macro is actually building another macro and gets surplus arguments thus it may need different approach to allow comma literal.

Sql macro doesn't sanitize macro becuase it only read csv file as in-memory database. However it is always a good idea to take care when you create sql queries.

You can set sqlite3 path within env.m4 file.

```
_sql(csv_path.csv, table_name,
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

Flex text box creates flex display text box. This is intended when using multiple text boxes in split slide.

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

Set current section or slide's class which accords to marp class declaration. Argument after comma is ignored.
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

Split macro enables easier way to make current slide split slide with left and right column

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

#### Include 

Include macro to include other markdown files into index.md 

```
_inc(other_file_name)
```

In this case inc/other\_file\_name.md file's content will be pasted into where macro was called.

#### Web api(WIP)