import 'dart:convert';
import 'package:http/http.dart';
import 'package:social_network/app/shared/models/post.dart';
import 'package:social_network/app/shared/models/user.dart';
import 'package:social_network/app/util/constants.dart';

class FeedApi {

  final Client _client;
  FeedApi(this._client);

  Map<int, User> _fetchedUsers = Map();

  Future<List<Post>> fetchPosts() async {
    final response = await _client.get(Uri.parse('${Constants.API_BASE_URL}/posts'));
    if(response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> jPosts = json.decode(response.body);
      final posts = jPosts.map((jp) => Post.fromJson(jp)).toList();

      for(final post in posts) {
        if(_fetchedUsers.containsKey(post.userId)) {
          post.user = _fetchedUsers[post.userId];
        } else {
          final res = await _client.get(
              Uri.parse('${Constants.API_BASE_URL}/users/${post.userId}'));
          if(res.statusCode == 200) {
            post.user = User.fromRawJson(res.body);
            _fetchedUsers[post.userId] = post.user!;
          }
        }
      }

      return posts;
    } else {
      throw Exception('Erro ao recuperar os posts');
    }
  }
}