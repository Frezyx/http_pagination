abstract class Pagination {
  const Pagination();
  dynamic get first;
  dynamic get next;
  dynamic get prev;
  dynamic get last;

  bool get hasNext;

  static const linkHeader = 'link';

  static const firstPageKey = 'first';
  static const nextPageKey = 'next';
  static const prevPageKey = 'prev';
  static const lastPageKey = 'last';

  static const cursorKey = 'cursor';
  static const pageKey = 'page';
}
