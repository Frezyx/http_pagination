// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'package:http_pagination/http_pagination.dart';
import 'package:test/test.dart';

void main() {
  group('HttpPagination', () {
    group('parseCursorPagination', () {
      test('parses full link header correctly', () {
        final headers = {
          'link': [
            '<http://example.com/first?cursor=abc>; rel="first", ' +
                '<http://example.com/next?cursor=def>; rel="next", ' +
                '<http://example.com/prev?cursor=ghi>; rel="prev", ' +
                '<http://example.com/last?cursor=jkl>; rel="last"',
          ],
        };
        final pagination = HttpPaginationParser.parseCursor(headers);

        expect(pagination.first, equals('abc'));
        expect(pagination.next, equals('def'));
        expect(pagination.prev, equals('ghi'));
        expect(pagination.last, equals('jkl'));
      });

      test('returns null for missing headers', () {
        final headers = <String, List<String>>{};
        final pagination = HttpPaginationParser.parseCursor(headers);

        expect(pagination.first, isNull);
        expect(pagination.next, isNull);
        expect(pagination.prev, isNull);
        expect(pagination.last, isNull);
      });

      test('returns null for empty headers', () {
        final headers = <String, List<String>>{'link': []};
        final pagination = HttpPaginationParser.parseCursor(headers);

        expect(pagination.first, isNull);
        expect(pagination.next, isNull);
        expect(pagination.prev, isNull);
        expect(pagination.last, isNull);
      });
    });

    group('parsePagesPagination', () {
      test('parses full link header correctly', () {
        final headers = {
          'link': [
            '<http://example.com/first?page=1>; rel="first", ' +
                '<http://example.com/next?page=3>; rel="next", ' +
                '<http://example.com/prev?page=1>; rel="prev", ' +
                '<http://example.com/last?page=10>; rel="last"',
          ],
        };
        final pagination = HttpPaginationParser.parsePages(headers);

        expect(pagination.first, equals(1));
        expect(pagination.next, equals(3));
        expect(pagination.prev, equals(1));
        expect(pagination.last, equals(10));
      });

      test('returns null for missing headers', () {
        final headers = <String, List<String>>{};
        final pagination = HttpPaginationParser.parsePages(headers);

        expect(pagination.first, isNull);
        expect(pagination.next, isNull);
        expect(pagination.prev, isNull);
        expect(pagination.last, isNull);
      });

      test('returns null for empty headers', () {
        final headers = <String, List<String>>{'link': []};
        final pagination = HttpPaginationParser.parsePages(headers);

        expect(pagination.first, isNull);
        expect(pagination.next, isNull);
        expect(pagination.prev, isNull);
        expect(pagination.last, isNull);
      });
    });
  });
}
