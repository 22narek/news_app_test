import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/constants/endpoints.dart';
import 'package:news_app/models/article_model.dart';

class NewsRepository {
  Future<List<ArticleModel>> getNews() async {
    var response = await http.get(Uri.parse(Endpoints.endpointV1));
    List<ArticleModel> articleModelList = [];
    var date = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in date["articles"]) {
        ArticleModel articleModel = ArticleModel.fromJson(item);
        articleModelList.add(articleModel);
      }
      return articleModelList;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<ArticleModel>> getAllNews() async {
    var response = await http.get(Uri.parse(Endpoints.endpointV2));
    List<ArticleModel> articleModelList = [];
    var date = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in date["articles"]) {
        ArticleModel articleModel = ArticleModel.fromJson(item);
        articleModelList.add(articleModel);
      }
      return articleModelList;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
