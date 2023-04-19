import 'package:http_pagination/src/models/models.dart';

abstract class HttpPagination {
  HttpPagination._();

  static const _linkHeader = 'link';

  static const _firstPageKey = 'first';
  static const _nextPageKey = 'next';
  static const _prevPageKey = 'prev';
  static const _lastPageKey = 'last';

  static const _cursorKey = 'cursor';
  static const _pageKey = 'page';

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

  static PagesPagination parsePagesPagination(
    Map<String, List<String>> headers,
  ) {
    int? firstPage;
    int? nextPage;
    int? prevPage;
    int? lastPage;

    final fullLink = headers[_linkHeader];

    if (fullLink?.isNotEmpty ?? false) {
      final cursorParts = fullLink!.first.split(',');

      firstPage = _parsePageLink(cursorParts, _firstPageKey);
      nextPage = _parsePageLink(cursorParts, _nextPageKey);
      prevPage = _parsePageLink(cursorParts, _prevPageKey);
      lastPage = _parsePageLink(cursorParts, _lastPageKey);
    }

    return PagesPagination(
      next: nextPage,
      prev: prevPage,
      last: lastPage,
      first: firstPage,
    );
  }

  static int? _parsePageLink(List<String> cursorParts, String key) {
    final cursorLink = cursorParts.firstWhere(
      (e) => e.contains(key),
      orElse: () => '',
    );
    if (cursorLink.isNotEmpty) {
      return _parsePageIndex(cursorLink);
    }
    return null;
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

  static String? _parseCursorId(String link) {
    Map<String, String> query = _getLinkQueryParams(link);
    return query[_cursorKey];
  }

  static int? _parsePageIndex(String link) {
    Map<String, String> query = _getLinkQueryParams(link);
    final pageParam = query[_pageKey];
    return pageParam == null ? null : int.tryParse(pageParam);
  }

  static Map<String, String> _getLinkQueryParams(String link) {
    final fullLinkParts = link.split(';');
    final clearLink = fullLinkParts.first
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll(' ', '');
    final clearLinkUri = Uri.parse(clearLink);
    final query = clearLinkUri.queryParameters;
    return query;
  }
}
