import 'package:http_pagination/src/models/models.dart';

class CursorPaginatedList<T> {
  const CursorPaginatedList({
    required this.data,
    required this.pagination,
  });

  final List<T> data;
  final CursorPagination pagination;
}
