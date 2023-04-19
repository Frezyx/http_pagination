import 'package:http_pagination/src/models/models.dart';

class PagesPaginatedList<T> {
  const PagesPaginatedList({
    required this.data,
    required this.pagination,
  });

  final List<T> data;
  final PagesPagination pagination;
}
