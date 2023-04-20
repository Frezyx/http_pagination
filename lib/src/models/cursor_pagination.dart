import 'package:http_pagination/src/http_pagination_base.dart';
import 'package:http_pagination/src/models/models.dart';

class CursorPagination implements Pagination {
  const CursorPagination({
    required this.first,
    required this.next,
    required this.prev,
    required this.last,
  });

  factory CursorPagination.fromHeaders(
    Map<String, List<String>> headers,
  ) =>
      HttpPaginationParser.parseCursor(headers);

  @override
  final String? first;

  @override
  final String? next;

  @override
  final String? prev;

  @override
  final String? last;

  @override
  bool get hasNext => next != null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CursorPagination &&
        other.first == first &&
        other.next == next &&
        other.prev == prev &&
        other.last == last;
  }

  @override
  int get hashCode {
    return first.hashCode ^ next.hashCode ^ prev.hashCode ^ last.hashCode;
  }

  @override
  String toString() {
    return 'CursorPagination(first: $first, next: $next, prev: $prev, last: $last)';
  }
}
