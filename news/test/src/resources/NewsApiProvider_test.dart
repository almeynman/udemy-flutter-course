import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:news/src/resources/NewsApiProvider.dart';
import 'package:test/test.dart';

void main() {
  test('fetchTopIds return a list of ids', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 4]);
  });

  test('fetchItem return an item model', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(999);
    expect(item.id, 123);
  });
}
