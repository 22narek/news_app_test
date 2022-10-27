// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:news_app/models/article_model.dart';

@immutable
abstract class AllNewsState extends Equatable {}

// class NewsInitState extends NewsState {
//   @override
//   // TODO: implement props
//   List<Object?> get props => throw UnimplementedError();
// }

class AllNewsLoadingState extends AllNewsState {
  @override
  List<Object?> get props => [];
}

class AllNewsLoadedState extends AllNewsState {
  final List<ArticleModel> articleList;

  AllNewsLoadedState({required this.articleList});

  @override
  // TODO: implement props
  List<Object?> get props => [articleList];
}

class AllNewsErrorState extends AllNewsState {
  final String errorMessage;
  AllNewsErrorState({
    required this.errorMessage,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
