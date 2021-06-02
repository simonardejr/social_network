import 'package:flutter/material.dart';
import 'package:social_network/app/screens/feed/feed_bloc.dart';
import 'package:social_network/app/screens/feed/feed_module.dart';
import 'package:social_network/app/shared/models/post.dart';
import 'package:social_network/app/util/constants.dart';

class FeedWidget extends StatelessWidget {

  late final FeedBloc _bloc = FeedModule.to.getBloc<FeedBloc>();

  Widget _titleFor(Post post) {
    if(post.user != null) {
      return Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage('${Constants.PHOTO_BASE_URL}/200/200/?u-${post.userId}'),
              ),
              SizedBox(width: 16,),
              Text(post.user!.name),
            ],
          )
        ],
      );
    } else {
      return Text(post.title);
    }
  }

  Widget _bodyFor(Post post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8,),
        ClipRRect(
          child: Image.network('${Constants.PHOTO_BASE_URL}/1280/720/?p-${post.id}'),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        SizedBox(height: 8,),
        Text(post.body)
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {

    _bloc.doFetch();

    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
      ),
      body: StreamBuilder(
        stream: _bloc.posts,
        builder: (_, AsyncSnapshot<List<Post>>snapshot) {
          if(snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                final post = snapshot.data![index];
                return ListTile(
                  title: _titleFor(post),
                  subtitle: _bodyFor(post),
                );
              },
              separatorBuilder: (_, __) => Divider(),
            );
          } else {
            return StreamBuilder(
                stream: _bloc.loading,
                builder: (_, AsyncSnapshot<bool> snapshot) {
                  final loading = snapshot.data ?? false;
                  if(loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Container();
                }
            );
          }
        },
      ),
    );
  }
}
