import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:social_network/app_bloc.dart';
import 'package:social_network/app_widget.dart';

class AppModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
    Bloc((i) => AppBloc()),
  ];

  @override
  Widget get view => AppWidget();

  @override
  List<Dependency> get dependencies => [
    Dependency((i) => RetryClient(Client())),
  ];

  static Inject get to => Inject<AppModule>.of();
}