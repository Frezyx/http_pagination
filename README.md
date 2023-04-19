Http headers pagination parser

## Features

Work in progress

## Getting started

```yaml
dependencies:
  http_pagination: ^0.1.1
```

## Usage

```dart
import 'package:http_pagination/http_pagination.dart';

final pagination = HttpPagination.parsePagesPagination(res.headers.map);
```


