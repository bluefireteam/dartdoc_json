# Dart API extractor

This is a command line tool that can parse your Dart files to extract API information, and then
save that information into a file in JSON format. This output can then be consumed by downstream
tools for a variety of purposes, for example to generate documentation.

Install:
```shell
dart pub global activate dartdoc_json
```

Usage:
```shell
dartdoc_json FILENAME(s)
```


## Output

The produced JSON file will have the following structure:

```
root: array[compilationUnit]

compilationUnit = {
  // The name of the input file.
  "source": string,

  // import/export directives within the file.
  "directives": array[directive],

  // the list of objects defined within the file.
  "declarations": array[declaration],
}

directive = {
  // What kind of directive this is
  "kind": "import" | "export" | "part" | "part-of" | "library",

  // The name of the file being imported or exported
  "uri": string,

  // List of symbols listed in the `show`/`hide` part of the directive
  "show": array[string],
  "hide": array[string],

  // For "import" statements, the ID after the `as` keyword
  "as": string,

  // For "library" statements, the name of the library
  // For "part-of" statements, the name of the library that the file is a part of
  "name": string,

  // Whether the directive references an augmentation library
  "augmentation": bool,
}

declaration = {
  // What kind of declaration this is. Note that some declarations may only
  // appear at the top level of the file, while others are nested within
  // top-level declarations.
  "kind": "class" | "mixin" | "extension" | "variable" | "typedef" | "enum" |
          "function" | "constructor" | "field" | "getter" | "setter" |
          "method",

  // The name of the declared symbol. For constructors this will be either
  // the name of the enclosing class, or the dotted name such as
  // "Color.fromARGB".
  "name": string,

  // The doc-comment associated with the declaration. This will be a single
  // string, joined with newlines, but with comment symbols removed.
  "description": string,

  // The list of type (template) parameters for the declaration.
  "typeParameters": array[typeParameter],

  // The list of annotations (such as "@Deprecated") attached to the
  // declared object.
  "annotations": array[annotation],

  // For "class"/"mixin"/"extension" declarations, this is the list of
  // entities defined within: constructors, methods, fields, etc.
  "members": array[declaration],

  // The name of the entity that this class extends. This name may contain
  // template parameters.
  "extends": string,

  // The list of entities defined after the `with` keyword for a class or
  // mixin.
  "with": array[string],

  // The list of entities defined after the `implements` keyword for a
  // class or mixin.
  "implements": array[string],

  // The list of entities defined after the `on` keyword for a mixin.
  "on": array[string],

  // The list of arguments in a method, function, or constructor.
  "parameters": parameterList,

  // For enums, the list of values defined within that enum.
  "values": array[enumConstant],

  // For a function/method declaration, the type of the return value.
  "returns": string,

  // Whether the class was declared as `abstract`.
  "abstract": bool,

  // Whether the constructor/field/variable were declared as `const`.
  "const": bool,

  // Whether the constructor was declared as `factory`.
  "factory": bool,

  // Whether the method was declared as `static`.
  "static": bool,

  // Whether the variable/field were declared as `final`.
  "final": bool,

  // Whether the variable/field were declared as `late`.
  "late": bool,

  // For variable/field declaration that declare several variables at once
  // (such as `int x, y, z;`), this will contain the list of names beyond
  // the first name.
  "extraNames": array[string],
}

typeParameter = {
  // The name of the type parameter, such as "T".
  "name": string,

  // The name of the type after the `extends` keyword.
  "extends": string,
}

annotation = {
  // The name of the annotation, including the leading "@".
  "name": string,

  // For parametrized annotations, this will contain the list of stringified
  // arguments that were given to the annotation. For example, if the
  // annotation was `@Deprecated("1.6.0")`, then this list will contain
  // a single string `'"1.6.0"'`.
  "arguments": array[string],
}

parameterList = {
  // The list of all parameters given to the function/method, in order of
  // their appearance within the function's signature.
  "all": array[parameter],

  // The number of (optional) positional arguments in function's signature.
  // These are the arguments that appear in square brackets. This property
  // will not be provided if there are no positional arguments, otherwise
  // its value will be less than or equal to the number of arguments in the
  // "all" array.
  "positional": int,

  // The number of named arguments in function's signature. These are the
  // arguments that appear in curly braces.
  "named": int,
}

parameter = {
  // The name of the parameter. This could also be a dotted name, such as
  // "this.items", or "super.key".
  "name": string,

  // The type of the parameter, which can also be a template. The type can
  // also be missing.
  "type": string,

  // The default value of the parameter, if exists.
  "default": string,

  // If true, indicates the presence of the `covariant` keyword.
  "covariant": bool,

  // If true, indicates the presence of the `required` keyword.
  "required": bool,
}

enumConstant = {
  // The name of the enum constant.
  "name": string,

  // The doc-comment attached to this constant.
  "description": string,

  // The list of annotations associated with this enum constant.
  "annotations": array[annotation],

  // The list of arguments used in this enum constant, if the constant
  // uses explicit constructor syntax.
  "arguments": array[string],
}
```

Most of the fields in the produced JSON are optional, and will only be included if the provided
element was present in the input Dart file.


## Additional command line options

The following options are recognized by the command line tool:

- `--output FILE`: the name of the file to write. By default this will be "out.json";
- `--root DIR`: the path to the root folder of the package. If provided, all input files will be
  looked up relative to this directory. However, the `source` field in the produced JSON will still
  contain the name of the input file without the root. Thus, this option can be useful if you want
  the file names in your JSON file to match the file names as used within your Dart package's
  imports/exports.
- `--pretty`: this flag causes the output to include lots of whitespace, which makes it easier to
  read for humans, but increases the file size.
