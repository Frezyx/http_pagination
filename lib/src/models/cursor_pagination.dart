class CursorPagination {
  const CursorPagination({
    required this.first,
    required this.next,
    required this.prev,
    required this.last,
  });

  final String? first;
  final String? next;
  final String? prev;
  final String? last;
}
