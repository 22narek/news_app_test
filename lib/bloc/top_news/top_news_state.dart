// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:news_app/models/article_model.dart';

@immutable
abstract class TopNewsState extends Equatable {}

// class NewsInitState extends NewsState {
//   @override
//   // TODO: implement props
//   List<Object?> get props => throw UnimplementedError();
// }

class TopNewsLoadingState extends TopNewsState {
  @override
  List<Object?> get props => [];
}

class TopNewsLoadedState extends TopNewsState {
  final List<ArticleModel> articleList;

  TopNewsLoadedState({required this.articleList});

  @override
  // TODO: implement props
  List<Object?> get props => [articleList];
}

class TopNewsErrorState extends TopNewsState {
  final String errorMessage;
  TopNewsErrorState({
    required this.errorMessage,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
