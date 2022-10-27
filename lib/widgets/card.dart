// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';

import 'custom_network_image.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
    required this.article,
    required this.onPressedForFav,
    required this.onPressedForArticle,
    this.isFavorite = false,
  }) : super(key: key);

  final ArticleModel article;
  final VoidCallback onPressedForFav;
  final VoidCallback onPressedForArticle;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: GestureDetector(
        onTap: onPressedForArticle,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                blurRadius: 1,
                color: Colors.grey,
                offset: Offset(0, 2),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: article.urlToImage ?? article.url ?? '',
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: CustomNetworkImage(
                    imageUrl: article.urlToImage,
                    width: width * 0.3,
                    height: height * 0.15,
                  ),
                ),
              ),
              SizedBox(width: width * 0.03),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.01),
                  child: Text(
                    '${article.title}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: onPressedForFav,
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft,
                ),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_outline,
                  color: isFavorite ? Colors.red : Colors.black,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
