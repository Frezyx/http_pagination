import 'package:http_pagination/src/models/models.dart';

class CursorPagination implements Pagination {
  const CursorPagination({
    required this.first,
    required this.next,
    required this.prev,
    required this.last,
  });

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
}
