[
  "break"
  "case"
  "continue"
  "default"
  "do"
  "else"
  "for"
  "if"
  "switch"
  "while"
  "with"
  "of"
  "in"
  "var"
  "let"
  "const"
  "static"
  "readonly"
  "override"
  "accessor"
  "private"
  "protected"
  "public"
  "declare"
  "abstract"
  "global"
  "using"
] @keyword

"return" @keyword.return
"yield"  @keyword.return

[
  "try"
  "catch"
  "finally"
  "throw"
] @keyword.exception

"debugger" @keyword.debug

[
  "async"
  "await"
] @keyword.coroutine

[
  "import"
  "export"
  "from"
  "as"
] @keyword.import

[
  "class"
  "extends"
  "implements"
  "interface"
  "enum"
  "namespace"
  "module"
  "type"
] @keyword.type

"function" @keyword.function

[
  "new"
  "delete"
  "instanceof"
  "typeof"
  "void"
  "keyof"
  "infer"
  "satisfies"
  "asserts"
  "is"
] @keyword.operator

(string)          @string
(template_string) @string

(template_substitution
  "${" @punctuation.special
  "}" @punctuation.special) @embedded

(regex)         @string.regexp
(regex_pattern) @string.regexp
(regex_flags)   @string.regexp

(number) @number

(true)  @boolean
(false) @boolean

(null)      @constant.builtin
(undefined) @constant.builtin

(hash_bang_line) @comment
(comment)        @comment

((comment) @comment.documentation
  (#match? @comment.documentation "^\\/\\*\\*"))

(identifier) @variable

; this / super / arguments
(this)  @variable.builtin
(super) @variable.builtin

((identifier) @variable.builtin
  (#eq? @variable.builtin "arguments"))

; SCREAMING_SNAKE_CASE constants
((identifier) @constant
  (#match? @constant "^[A-Z][A-Z0-9_]+$"))

; Shorthand property { foo } in object literals
(shorthand_property_identifier) @variable

; Shorthand destructure pattern { foo } = ...
(shorthand_property_identifier_pattern) @variable

(required_parameter
  name: (identifier) @variable.parameter)

(optional_parameter
  name: (identifier) @variable.parameter)

; rest parameter: ...args
(required_parameter
  name: (rest_pattern
    (identifier) @variable.parameter))

; destructured array parameter: [a, b]
(required_parameter
  pattern: (array_pattern
    (identifier) @variable.parameter))

(optional_parameter
  pattern: (array_pattern
    (identifier) @variable.parameter))

; destructured object parameter: { foo }
(required_parameter
  pattern: (object_pattern
    (shorthand_property_identifier_pattern) @variable.parameter))

(optional_parameter
  pattern: (object_pattern
    (shorthand_property_identifier_pattern) @variable.parameter))

; single-arg arrow function: x => x
(arrow_function
  parameter: (identifier) @variable.parameter)

(function_declaration
  name: (identifier) @function)

(function_expression
  name: (identifier) @function)

(generator_function_declaration
  name: (identifier) @function)

(generator_function
  name: (identifier) @function)

; Arrow / function expressions assigned to const foo = ...
(variable_declarator
  name: (identifier) @function
  value: (arrow_function))

(variable_declarator
  name: (identifier) @function
  value: (function_expression))

(variable_declarator
  name: (identifier) @function
  value: (generator_function))

; Methods
(method_definition
  name: (property_identifier) @function.method)

(method_definition
  name: (private_property_identifier) @function.method)

; constructor
((method_definition
  name: (property_identifier) @constructor)
  (#eq? @constructor "constructor"))

; Call sites
(call_expression
  function: (identifier) @function.call)

(call_expression
  function: (member_expression
    property: (property_identifier) @function.method.call))

; new Foo()
(new_expression
  constructor: (identifier) @constructor)

; Predefined type keywords: string, number, boolean, any, never, void, etc.
(predefined_type) @type.builtin

; Named type identifiers
(type_identifier) @type

; Declarations (definitions)
(type_alias_declaration      name: (type_identifier) @type.definition)
(interface_declaration       name: (type_identifier) @type.definition)
(class_declaration           name: (type_identifier) @type.definition)
(abstract_class_declaration  name: (type_identifier) @type.definition)
(enum_declaration            name: (identifier)      @type.definition)

; Generic type parameters <T, K extends string>
(type_parameter
  name: (type_identifier) @type.parameter)

; Enum members
(enum_body
  name: (property_identifier) @constant)

(enum_body
  name: (string) @constant)

(property_identifier)         @property
(private_property_identifier) @property

; Member access  foo.bar  foo?.bar
(member_expression
  property: (property_identifier) @property)

(member_expression
  property: (private_property_identifier) @property)

; Subscript with string key  foo["bar"]
(subscript_expression
  index: (string) @property)

; Class field definitions
(public_field_definition
  name: (property_identifier) @property)

(public_field_definition
  name: (private_property_identifier) @property)

(decorator "@" @attribute)

(decorator
  (identifier) @attribute)

(decorator
  (call_expression
    function: (identifier) @attribute))

(decorator
  (call_expression
    function: (member_expression
      property: (property_identifier) @attribute)))

; import { foo } — name before alias
(import_specifier
  name: (identifier) @variable)

; import { foo as bar } — alias is the local binding
(import_specifier
  alias: (identifier) @variable)

; export { foo }
(export_specifier
  name: (identifier) @variable)

; import * as ns
(namespace_import
  (identifier) @module)

; export * as ns
(namespace_export
  (identifier) @module)

(internal_module
  name: (identifier) @module)

(module
  name: (string) @module)

[
  "+"   "-"   "*"   "/"   "%"   "**"
  "++"  "--"
  "="
  "+="  "-="  "*="  "/="  "%="  "**="
  "&&=" "||=" "??="
  "<<=" ">>=" ">>>="
  "&="  "|="  "^="
  "=="  "===" "!="  "!=="
  "<"   "<="  ">"   ">="
  "&&"  "||"  "??"
  "!"   "~"
  "&"   "|"   "^"
  "<<"  ">>"  ">>>"
  "=>"
] @operator

(non_null_expression "!" @operator)

[
  "{"  "}"
  "("  ")"
  "["  "]"
] @punctuation.bracket

[
  "."
  ","
  ";"
  ":"
  "?."
] @punctuation.delimiter

"..." @punctuation.special

(labeled_statement  label: (statement_identifier) @label)
(break_statement    label: (statement_identifier) @label)
(continue_statement label: (statement_identifier) @label)
