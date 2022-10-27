import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/repo/database/database_options.dart';
import 'package:news_app/repo/repository.dart';
import 'package:news_app/screens/article_details_screen.dart';
import 'package:news_app/widgets/header.dart';
import 'package:news_app/widgets/card.dart';

import '../bloc/top_news/top_news_bloc.dart';
import '../bloc/top_news/top_news_event.dart';
import '../bloc/top_news/top_news_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ArticleDatabase db;
  List<ArticleModel> articleInfo = [];
  @override
  void initState() {
    super.initState();
    db = ArticleDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopNewsBloc(
        RepositoryProvider.of<NewsRepository>(context),
      )..add(StartEvent()),
      child: SafeArea(
        child: Scaffold(body:
            BlocBuilder<TopNewsBloc, TopNewsState>(builder: (context, state) {
          if (state is TopNewsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TopNewsLoadedState) {
            articleInfo = state.articleList;
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Header(textHeader: 'Top News'),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<TopNewsBloc>()
                            .add(StartEvent() /*RefreshEvent()*/);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          itemCount: articleInfo.length,
                          // primary: true,
                          // itemExtent: height * 0.15,
                          // scrollDirection: Axis.vertical,
                          // shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return NewsCard(
                              article: articleInfo[index],
                              onPressedForFav: () async {
                                await db.insert(articleInfo[index]);
                              },
                              onPressedForArticle: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ArticleDetails(
                                        article: articleInfo[index]),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(child: Text('${state.runtimeType}'));
        })),
      ),
    );
  }
}
