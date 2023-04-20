import 'package:http_pagination/http_pagination.dart';
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
}
