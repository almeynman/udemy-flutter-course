import 'package:news/src/models/ItemModel.dart';
import 'package:news/src/resources/Repository.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  // Getter to Streams
  Observable<List<int>> get topIds => _topIds.stream;

  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  // Getter to Sinks
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc() {
    _itemsFetcher.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  clearCaches() {
    return _repository.clearCaches();
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, int index) {
        print(index);
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  @override
  void dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}
