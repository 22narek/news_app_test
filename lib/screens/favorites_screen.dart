import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/repo/database/database_options.dart';
import 'package:news_app/screens/article_details_screen.dart';

import '../widgets/card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late final ArticleDatabase db;
  @override
  void initState() {
    super.initState();
    db = ArticleDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite articles'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 8.0,
                  ),
                  child: FutureBuilder<List<ArticleModel>>(
                    future: getDataFromDb(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
                        } else if (snapshot.hasData) {
                          return Column(
                            children: snapshot.data!.map(
                              (e) {
                                return NewsCard(
                                  article: e,
                                  onPressedForArticle: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ArticleDetails(
                                          article: e,
                                          isFavorite: true,
                                        ),
                                      ),
                                    );
                                    // Navigate to details page
                                  },
                                  onPressedForFav: () async {
                                    await _removeItemFromDb(e);
                                    setState(() {});
                                  },
                                  isFavorite: true,
                                );
                              },
                            ).toList(),
                          );
                        } else {
                          return const Center(child: Text('Empty data'));
                        }
                      } else {
                        return Center(
                            child: Text('State: ${snapshot.connectionState}'));
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<ArticleModel>> getDataFromDb() async {
    return db.readAll();
  }

  Future<void> _removeItemFromDb(ArticleModel item) async {
    db.delete(item.id!);
  }
}
