import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social_network/app/screens/feed/feed_api.dart';
import 'package:social_network/app/shared/models/post.dart';

class FeedBloc extends BlocBase {

  final FeedApi _api;
  FeedBloc(this._api);

  late final _feedFetcher = PublishSubject<List<Post>>();
  late final _loading = BehaviorSubject<bool>();

  Stream<List<Post>> get posts => _feedFetcher.stream;
  Stream<bool> get loading => _loading.stream;

  doFetch() async {
    _loading.sink.add(true);
    final posts = await _api.fetchPosts();
    posts.shuffle();

    _feedFetcher.sink.add(posts);

    _loading.sink.add(false);
  }

  @override
  void dispose() {
    _feedFetcher.close();
    _loading.close();
    super.dispose();
  }

}