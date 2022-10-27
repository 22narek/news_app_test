import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/top_news/top_news_event.dart';
import 'package:news_app/bloc/top_news/top_news_state.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/repo/repository.dart';

class TopNewsBloc extends Bloc<TopNewsEvents, TopNewsState> {
  final NewsRepository newsRepositoty;

  TopNewsBloc(this.newsRepositoty) : super(TopNewsLoadingState()) {
    on<StartEvent>((event, emit) async {
      print('123');
      // List<ArticleModel> _articleList = [];
      // _articleList = await newsRepositoty.getUsers();
      // print(_articleList);
      try {
        print('1');
        List<ArticleModel> articleList = [];
        emit(TopNewsLoadingState());
        print('2');
        articleList = await newsRepositoty.getNews();
        print('3');
        emit(TopNewsLoadedState(articleList: articleList));
        print('4');
      } catch (e) {
        emit(TopNewsErrorState(errorMessage: e.toString()));
      }
    });
  }
}
