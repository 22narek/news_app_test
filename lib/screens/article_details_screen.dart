import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';

import '../widgets/custom_network_image.dart';

class ArticleDetails extends StatelessWidget {
  final ArticleModel article;
  final bool isFavorite;
  const ArticleDetails({
    Key? key,
    required this.article,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News details"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: isFavorite ? Colors.red : Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //image
            Hero(
              tag: article.urlToImage ?? article.url ?? '',
              child: CustomNetworkImage(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                imageUrl: article.urlToImage,
              ),
            ),
            //title
            Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Text(
                  article.title ?? '',
                  // "Title",
                  style: const TextStyle(
                    fontSize: 26,
                  ),
                ),
              ),
            ),
            // description
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                article.content ?? '',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
