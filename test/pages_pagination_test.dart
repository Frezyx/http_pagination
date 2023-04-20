// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:http_pagination/http_pagination.dart';
import 'package:test/test.dart';

void main() {
  group('PagesPagination', () {
    test('creates instance with valid input values', () {
      final pagination = PagesPagination(
        first: 1,
        next: 2,
        prev: 0,
        last: 5,
      );

      expect(pagination.first, equals(1));
      expect(pagination.next, equals(2));
      expect(pagination.prev, equals(0));
      expect(pagination.last, equals(5));
      expect(pagination.hasNext, isTrue);
    });

    test('creates instance with null "next" value returns hasNext as false',
        () {
      final pagination = PagesPagination(
        first: 1,
        next: null,
        prev: 0,
        last: 5,
      );

      expect(pagination.hasNext, isFalse);
    });

    test('parses instance from headers with valid input values', () {
      final headers = {
        'link': [
          '<https://example.com/api/items?page=1>; rel="first", ' +
              '<https://example.com/api/items?page=3>; rel="next", ' +
              '<https://example.com/api/items?page=2>; rel="prev", ' +
              '<https://example.com/api/items?page=5>; rel="last"'
        ]
      };

      final pagination = PagesPagination.fromHeaders(headers);

      expect(pagination.first, equals(1));
      expect(pagination.next, equals(3));
      expect(pagination.prev, equals(2));
      expect(pagination.last, equals(5));
      expect(pagination.hasNext, isTrue);
    });

    test(
        'parses instance from headers with null "next" value when there is no "next" link header',
        () {
      final headers = {
        'link': [
          '<https://example.com/api/items?page=1>; rel="first", ' +
              '<https://example.com/api/items?page=2>; rel="prev", ' +
              '<https://example.com/api/items?page=5>; rel="last"'
        ]
      };

      final pagination = PagesPagination.fromHeaders(headers);

      expect(pagination.first, equals(1));
      expect(pagination.next, isNull);
      expect(pagination.prev, equals(2));
      expect(pagination.last, equals(5));
      expect(pagination.hasNext, isFalse);
    });
  });
}
