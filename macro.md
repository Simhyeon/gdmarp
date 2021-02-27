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

#### CSV

Csv macro reads csv file and converts into github flavored markdown format. Font-size change are to be updated.

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

#### Title

#### Split

#### Left

#### Right

#### End

#### Include 
