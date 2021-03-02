### Macro rules (WIP)

Macro starts with underscore. There are several macro rules that don't start with underscore which are mostly intended for internal usage.

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

#### Texts

Multiline texts are supported. Starting and trailing new lines are all removed from input.
First argument is font-size. 0 means default font-size which is 22px for now.

```
_texts(30, Big texts are printed)

_texts(0, 
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

### Img macro

Simple img macros creates markdown img list.

Sized img macro creates markdown image text with marp favored attribute. First argument is always image width in pixel(px) 0 menas autoscale which actually divides v\_basis\_height by image counts.

```
_imgs(1.jpeg, 2.png)

_simgs(1.jpeg, 2.png)

```
converts to

```
![](1.jpeg)
![](2.png)

<!-- Assume v_basis_height is 500 -->
![width:250px](1.jpeg)
![width:250px](2.png)
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
However converted syntax is not so beautiful to read, keep in mind.

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
	thead > tr > td {
		font-size: 5px !important;
	}
	tr > td {
		font-size: 16px !important;
	}
</style>

<thead>
<td> <p>Name</p>
 </td><td> <p>email</p>
 </td><td> <p>description</p>
 </td>
</thead>

<tr>
<td> <p>Simon</p>
 </td><td> <p>123@gmail.com</p>
 </td><td> <ul><li>List can be inserted inside markdown</li><ul><li>Nested lists too</li></ul><li>With some ordered list</li></ul>
 </td>
</tr>
<tr>
<td> <p>Creek</p>
 </td><td> <p>456@naver.com</p>
 </td><td> <p>Simple texts without listing</p><p>can be inserted</p>
 </td>
</tr>
</table>
```

#### Flex text box

Intended usage is for split slide

```
_fbox( text content )
```

```
<div style="flex:1;">

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
_tnc(Tnc title)
```

```
<!-- _class: tnc -->
# Tnc title
```

#### Include 

Include macro to include other markdown files into index.md 

```
_inc(other_file_name)
```

In this case inc/other\_file\_name.md file's content will be pasted into where macro was called.
