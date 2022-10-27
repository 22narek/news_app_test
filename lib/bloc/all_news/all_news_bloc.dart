import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/all_news/all_news_state.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/repo/repository.dart';

import 'all_news_event.dart';

class AllNewsBloc extends Bloc<AllNewsEvents, AllNewsState> {
  final NewsRepository newsRepositoty;

  AllNewsBloc(this.newsRepositoty) : super(AllNewsLoadingState()) {
    on<AllNewsStartEvent>((event, emit) async {
      print('123');
      // List<ArticleModel> _articleList = [];
      // _articleList = await newsRepositoty.getUsers();
      // print(_articleList);
      try {
        print('1');
        List<ArticleModel> articleList = [];
        emit(AllNewsLoadingState());
        print('2');
        articleList = await newsRepositoty.getAllNews();
        print('3');
        emit(AllNewsLoadedState(articleList: articleList));
        print('4');
      } catch (e) {
        emit(AllNewsErrorState(errorMessage: e.toString()));
      }
    });
  }
}
