// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:http_pagination/http_pagination.dart';
import 'package:test/test.dart';

void main() {
  group('CursorPagination', () {
    test('creates instance with valid input values', () {
      final pagination = CursorPagination(
        first: 'first-cursor',
        next: 'next-cursor',
        prev: 'prev-cursor',
        last: 'last-cursor',
      );

      expect(pagination.first, equals('first-cursor'));
      expect(pagination.next, equals('next-cursor'));
      expect(pagination.prev, equals('prev-cursor'));
      expect(pagination.last, equals('last-cursor'));
      expect(pagination.hasNext, isTrue);
    });

    test('creates instance with null "next" value returns hasNext as false',
        () {
      final pagination = CursorPagination(
        first: 'first-cursor',
        next: null,
        prev: 'prev-cursor',
        last: 'last-cursor',
      );

      expect(pagination.hasNext, isFalse);
    });

    test('parses instance from headers with valid input values', () {
      final headers = {
        'link': [
          '<http://example.com/items?cursor=abc>; rel="first", ' +
              '<http://example.com/items?cursor=def>; rel="next", ' +
              '<http://example.com/items?cursor=ghi>; rel="prev", ' +
              '<http://example.com/items?cursor=jkl>; rel="last"',
        ],
      };

      final pagination = CursorPagination.fromHeaders(headers);

      expect(pagination.first, equals('abc'));
      expect(pagination.next, equals('def'));
      expect(pagination.prev, equals('ghi'));
      expect(pagination.last, equals('jkl'));
      expect(pagination.hasNext, isTrue);
    });

    test(
        'parses instance from headers with null "next" value when there is no "next" link header',
        () {
      final headers = {
        'link': [
          '<http://example.com/items?cursor=abc>; rel="first", ' +
              '<http://example.com/items?cursor=ghi>; rel="prev", ' +
              '<http://example.com/items?cursor=jkl>; rel="last"',
        ],
      };

      final pagination = CursorPagination.fromHeaders(headers);

      expect(pagination.first, equals('abc'));
      expect(pagination.next, isNull);
      expect(pagination.prev, equals('ghi'));
      expect(pagination.last, equals('jkl'));
      expect(pagination.hasNext, isFalse);
    });
  });
}
