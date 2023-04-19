abstract class Pagination {
  dynamic get first;
  dynamic get next;
  dynamic get prev;
  dynamic get last;

  bool get isEmpty => [first, last, prev, next].every((e) => e == null);
}
