
[Apex Logs](https://apex.sh/logs/) utilizes a purpose-built query language for searching and aggregating structured log events.

## Events

An Apex Log event requires the following properties:

Name | Type | Description
---|---|---
`id` | __string__ | The unique identifier of the event.
`level` | __string__ | The severity level.
`message` | __string__ | The log message.
`fields` | __object__ | User-defined context, may contain nested arrays and objects.
`timestamp` | __timestamp__ | The log creation time.

## Severity levels

A log event has an associated severity level, indicating if the log is purely informational, or represents a problem with your application. The following severity levels are supported:

- __debug__
- __info__
- __notice__
- __warning__
- __error__
- __critical__
- __alert__
- __emergency__

Severity levels are treated as numeric internally, thus the following expressions are considered valid.

```
level > info
```

When used alone, the severity level keywords behave as an `=` expression. For example these three expressions are identical:

```
error
level = error
level = "error"
```

## Structured and unstructured log messages

Log messages provide an indication of what happened in the application, such as a user
signing in, uploading a file, or experiencing a crash. It's recommended to provide machine-friendly "structured" messages, a good example would be "user_login" or "User Login", while adding dynamic information to the log `fields`. This allows you to quickly filter on a distinct message as shown here:

```
message = "user_login"
message in ("User Login", "User Logout")
error and message = "upload_failed" and user.name = "tobi"
```

Unstructured log messages are less ideal, as shown below, the dynamic information is embedded in the message string, however, this style is also supported by Apex Logs.

```
"alert 1SvStCtXlLQ8JcqvnHRkIYCiYIn: performed query duration=2s"
```

To query against unstructured messages you may use substring match operators, for example:

```
message like "*performed query*"
message contains "performed query"
message starts with "alert 1SvStCtXlLQ8JcqvnHRkIYCiYIn"
message ends with "duration=2s"
```

Note that the `duration=2s` substring has no structure, it is simply a string, thus it's not possible to perform more complex queries. Sending the `duration` as a numeric field is preferred, allowing for queries like:

```
message = "performed query" and duration > 2s
message = "performed query" and duration between 1m and 5m
```

## Accessing fields and array elements 

Fields are accessible via the `.` operator, here are a few examples:

```
user.is_admin
user.name = "tobi"
cart.items.total > 15.99
```

Array elements are accessible via the `[]` operator, supplying the index:

```
cart.items[0].name = "Ferret Food"
cart.items[1].price > 10
```

## Literals

This section covers the literals available.

### Booleans

Booleans use the `true` and `false` keywords:

```
user.is_admin = true
user.is_admin = false
```

### Integers

Integers use a sequence of digits.

```
cart.total > 15
```

You may use `_` as a thousands separator, for example:

```
1_000_000
```

### Floats

Floats use a sequence of digits followed by a `.`, another sequence of digits,
and optional exponent.

```
cart.total > 15.99
```

You may use `_` as a thousands separator, for example:

```
1_000_000.99
```

### Duration units

The numeric duration units use a millisecond resolution, using the suffixes `ms`, `s`, `m`, `h`, and `d`.

```
message = "uploaded file" and duration > 1500
message = "uploaded file" and duration > 1500ms
message = "uploaded file" and duration > 1s
message = "uploaded file" and duration > 1.5s
message = "uploaded file" and duration > 5m
message = "uploaded file" and duration > 3h
message = "uploaded file" and duration > 1d
```

### Byte size units

The numeric byte size units use the suffixes `b`, `kb`, `mb`, `gb`, and `tb` for querying multiples of 1024.

```
message = "uploaded file" and file.size > 1024
message = "uploaded file" and file.size > 1024b
message = "uploaded file" and file.size > 1kb
message = "uploaded file" and file.size > 2.5mb
message = "uploaded file" and file.size > 1gb
```

## Logical operators

Logical operators evaluate to a boolean, allowing you to define more complex filter operations.

### AND

The `and` operator evalutes to `true` if both conditions are truthy:

```
error and message = "Upload Failed"
```

### OR

The `or` operator evalutes to `true` if either condition is truthy:

```
user.first_name = "Tobi" or user.first_name = "Loki"
```

### NOT

The `!` operator negates an expression:

```
user.is_admin and !(user.email in ("tj@apex.sh", "tobi@apex.sh"))
```

### EXISTS

The `exists` operator evalutes to `true` if the field is defined.

```
user.cart exists
```

## Equality operators

Equality operators perform comparisons between fields and values.

### =

The `=` operator evalutes to true if both operands are the same.

```
region = "us-west2"
```

This operator is aliased as `==`.

### !=

The `!=` operator evalutes to true if both operands are not the same.

```
region != "us-west2"
```

### LIKE

The `like` operator evalutes to true if the left operand matches the right's pattern,
where `*` denotes a wildcard.

```
region like "us-*"
region like "*-west2"
```

### CONTAINS

The `contains` operator evalutes to true if the left operand contains the string on the right.

```
cart.items[0].product.name contains "Logitec"
```

This operator is aliased as `includes`.

### STARTS WITH

The `starts with` operator evalutes to true if the left operand starts with the string on the right.

```
region starts with "us-"
region like "us-*"
```

### ENDS WITH

The `ends with` operator evalutes to true if the left operand ends with the string on the right.

```
region ends with "-west2"
region like "*-west2"
```

### BETWEEN

The `between` operator evalutes to true if the left operand is between the range (inclusive).

```
response.status between 200 and 299
```

### IN

The `in` operator evalutes to true if the left operand is within the tuple.

```
function.name in ("check_processor", "check_queuer", "check_reporter")
```

## Relational operators

### >

The `>` operator evalutes to true if the left operand is greater than the right.

```
cart.total > 15
```

### >=

The `>=` operator evalutes to true if the left operand is greater than or equal to the right.

```
cart.total >= 15
```

### <

The `<` operator evalutes to true if the left operand is less than the right.

```
cart.total < 15
```

### <=

The `<=` operator evalutes to true if the left operand is less than or equal to the right.

```
cart.total <= 15
```

## Grouping

You may group expressions using the `(` and `)` characters, for example:

```
message = "Removed User" and (user.is_admin or user.email ends with "@apex.sh")
```

## Examples

Errors caused by a particular Lambda function and version:

```
error and function.name = "alert_processor" and function.version = "v1.5.0"
```

Slow responses caused by a particular user.

```
user.email = "tobi@apex.sh" and response.duration >= 5s
```

Image upload errors:

```
error and message = "Upload Failed" and file.type like "image/*"
```

Large file uploads:

```
file.size >= 16mb
```

Actions performed by an administrator:

```
user.is_admin
```
