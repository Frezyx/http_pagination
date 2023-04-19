import 'package:http_pagination/src/models/models.dart';

abstract class HttpPagination {
  HttpPagination._();

  static const _linkHeader = 'link';

  static const _firstPageKey = 'first';
  static const _nextPageKey = 'next';
  static const _prevPageKey = 'prev';
  static const _lastPageKey = 'last';

  static CursorPagination parseCursorPagination(
    Map<String, List<String>> headers,
  ) {
    String? firstCursor;
    String? nextCursor;
    String? prevCursor;
    String? lastCursor;

    final fullLink = headers[_linkHeader];

    if (fullLink?.isNotEmpty ?? false) {
      final cursorParts = fullLink!.first.split(',');

      firstCursor = _parseCursorLink(cursorParts, _firstPageKey);
      nextCursor = _parseCursorLink(cursorParts, _nextPageKey);
      prevCursor = _parseCursorLink(cursorParts, _prevPageKey);
      lastCursor = _parseCursorLink(cursorParts, _lastPageKey);
    }

    return CursorPagination(
      next: nextCursor,
      prev: prevCursor,
      last: lastCursor,
      first: firstCursor,
    );
  }

  static String? _parseCursorLink(List<String> cursorParts, String key) {
    final cursorLink = cursorParts.firstWhere(
      (e) => e.contains(key),
      orElse: () => '',
    );
    if (cursorLink.isNotEmpty) {
      return _parseCursorId(cursorLink);
    }
    return null;
  }

  static String? _parseCursorId(String nextCursor) {
    final fullLinkParts = nextCursor.split(';');
    final clearLink = fullLinkParts.first
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll(' ', '');
    final clearLinkUri = Uri.parse(clearLink);
    final query = clearLinkUri.queryParameters;
    return query['cursor'];
  }
}
