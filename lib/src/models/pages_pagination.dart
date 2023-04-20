import 'package:http_pagination/src/http_pagination_base.dart';
import 'package:http_pagination/src/models/models.dart';

/// Pages (offset) based pagination model
/// ```dart
///  final headers = {
///    'link': [
///      '<https://api.github.com/user/9287/repos?page=3&per_page=100>; rel="next", ' +
///          '<https://api.github.com/user/9287/repos?page=1&per_page=100>; rel="prev", ' +
///          '<https://api.github.com/user/9287/repos?page=5&per_page=100>; rel="last"'
///    ],
///  };
///  final pagination = PagesPagination.fromHeaders(headers);
///  print(pagination); // PagesPagination(first: null, next: 3, prev: 1, last: 5)
/// ```
///
/// More info you can find in this article [https://dev.to/jackmarchant/offset-and-cursor-pagination-explained-b89]
class PagesPagination implements Pagination {
  const PagesPagination({
    required this.first,
    required this.next,
    required this.prev,
    required this.last,
  });

  factory PagesPagination.fromHeaders(
    Map<String, List<String>> headers,
  ) =>
      HttpPaginationParser.parsePages(headers);

  @override
  final int? first;

  @override
  final int? next;

  @override
  final int? prev;

  @override
  final int? last;

  @override
  bool get hasNext => next != null;

  @override
  String toString() {
    return 'PagesPagination(first: $first, next: $next, prev: $prev, last: $last)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PagesPagination &&
        other.first == first &&
        other.next == next &&
        other.prev == prev &&
        other.last == last;
  }

  @override
  int get hashCode {
    return first.hashCode ^ next.hashCode ^ prev.hashCode ^ last.hashCode;
  }
}
