// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:http_pagination/http_pagination.dart';

void main() {
  final headers = {
    'link': [
      '<https://api.github.com/user/9287/repos?page=3&per_page=100>; rel="next", ' +
          '<https://api.github.com/user/9287/repos?page=1&per_page=100>; rel="prev", ' +
          '<https://api.github.com/user/9287/repos?page=5&per_page=100>; rel="last"'
    ],
  };
  final pagination = PagesPagination.fromHeaders(headers);
  print(pagination); // PagesPagination(first: null, next: 3, prev: 1, last: 5)

  final cursorHeaders = {
    'link': [
      '<http://example.com/items?cursor=a>; rel="first", ' +
          '<http://example.com/items?cursor=b>; rel="next", ' +
          '<http://example.com/items?cursor=c>; rel="prev", ' +
          '<http://example.com/items?cursor=d>; rel="last"',
    ],
  };

  final cPagination = CursorPagination.fromHeaders(cursorHeaders);
  print(cPagination); // CursorPagination(first: a, next: b, prev: c, last: d)
}
