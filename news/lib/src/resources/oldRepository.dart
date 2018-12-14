//import 'package:news/src/models/ItemModel.dart';
//import 'package:news/src/resources/NewsApiProvider.dart';
//import 'package:news/src/resources/NewsDbProvider.dart';
//
//abstract class Source {
//  Future<List<int>> fetchTopIds();
//
//  Future<ItemModel> fetchItem(int id);
//}
//
//abstract class Cache {
//  Future<int> addItem(ItemModel item);
//}
//
//class Repository {
//  NewsDbProvider dbProvider = NewsDbProvider();
//  NewsApiProvider apiProvider = NewsApiProvider();
//
//  Future<List<int>> fetchTopIds() {
//    return apiProvider.fetchTopIds();
//  }
//
//  Future<ItemModel> fetchItem(int id) async {
//    var item = await dbProvider.fetchItem(id);
//
//    if (item != null) {
//      return item;
//    }
//
//    item = await apiProvider.fetchItem(id);
//    await dbProvider.addItem(item);
//    return item;
//  }
//}
