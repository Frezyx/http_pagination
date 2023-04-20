import 'package:http_pagination/src/http_pagination_base.dart';
import 'package:http_pagination/src/models/models.dart';

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
