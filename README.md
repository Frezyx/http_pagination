# Http pagination

Http headers pagination parser <br>
Inspired by js lib [parse-link-header](https://github.com/thlorenz/parse-link-header)

## Features

Parses a link header [(web links)](https://datatracker.ietf.org/doc/html/rfc5988) and returns pagination data <br>
Works both with pages and cursor pagination

## Getting started

```yaml
dependencies:
  http_pagination: ^0.2.0
```

## Usage

Pages pagination

```dart
import 'package:http_pagination/http_pagination.dart';

final headers = {
  'link': [
    '<https://api.github.com/user/9287/repos?page=3&per_page=100>; rel="next", ' +
    '<https://api.github.com/user/9287/repos?page=1&per_page=100>; rel="prev", ' +
    '<https://api.github.com/user/9287/repos?page=5&per_page=100>; rel="last"'
  ],
};
final pagination = PagesPagination.fromHeaders(headers);
print(pagination); // PagesPagination(first: null, next: 3, prev: 1, last: 5)
```

Cursor pagination

```dart
import 'package:http_pagination/http_pagination.dart';

final headers = {
  'link': [
    '<http://example.com/items?cursor=a>; rel="first", ' +
    '<http://example.com/items?cursor=b>; rel="next", ' +
    '<http://example.com/items?cursor=c>; rel="prev", ' +
    '<http://example.com/items?cursor=d>; rel="last"',
  ],
};

final pagination = CursorPagination.fromHeaders(headers);
print(pagination); // CursorPagination(first: a, next: b, prev: c, last: d)
```

