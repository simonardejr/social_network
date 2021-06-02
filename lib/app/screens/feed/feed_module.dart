import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social_network/app/screens/feed/feed_api.dart';
import 'package:social_network/app/screens/feed/feed_bloc.dart';
import 'package:social_network/app/screens/feed/feed_widget.dart';
import 'package:social_network/app_module.dart';

class FeedModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
    Bloc((i) => FeedBloc(i.get<FeedApi>()))
  ];

  @override
  Widget get view => FeedWidget();

  @override
  List<Dependency> get dependencies => [
    Dependency((i) => FeedApi(AppModule.to.getDependency<Client>()))
  ];

  static Inject get to => Inject<FeedModule>.of();
}