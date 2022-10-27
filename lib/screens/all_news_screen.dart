import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/repo/database/database_options.dart';
import 'package:news_app/repo/repository.dart';
import 'package:news_app/screens/article_details_screen.dart';
import 'package:news_app/widgets/header.dart';
import 'package:news_app/widgets/card.dart';

import '../bloc/all_news/all_news_bloc.dart';
import '../bloc/all_news/all_news_event.dart';
import '../bloc/all_news/all_news_state.dart';

class AllNewsScreen extends StatefulWidget {
  const AllNewsScreen({super.key});

  @override
  State<AllNewsScreen> createState() => _AllNewsScreenState();
}

class _AllNewsScreenState extends State<AllNewsScreen> {
  late ArticleDatabase db;
  @override
  void initState() {
    super.initState();
    db = ArticleDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllNewsBloc>(
      create: (context) => AllNewsBloc(
        RepositoryProvider.of<NewsRepository>(context),
      )..add(AllNewsStartEvent()),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<AllNewsBloc, AllNewsState>(
            builder: (context, state) {
              if (state is AllNewsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is AllNewsLoadedState) {
                List<ArticleModel> articleInfo = state.articleList;
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Header(textHeader: 'All News'),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            context
                                .read<AllNewsBloc>()
                                .add(AllNewsStartEvent() /*RefreshEvent()*/);
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
            },
          ),
        ),
      ),
    );
  }
}
