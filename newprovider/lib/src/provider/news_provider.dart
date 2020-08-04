

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:newprovider/src/models/category_model.dart';


import 'package:newprovider/src/models/news_model.dart';


//TODO Provider NewsProvider  1.0
class NewsProvider with ChangeNotifier {


  final _URL_NEWS = 'https://newsapi.org/v2';
  final _APIKEY   = 'f11ec3403a9e40798f25aca81bdf232a';
  List<Article> headlines = [];
  String _selectCategory = 'business';
  bool _isLoading = true;

  Map<String, List<Article>> mcategoryArticles = {};
  
  List<CategoryModel> categoriesList = [
    CategoryModel(FontAwesomeIcons.building, 'business'),
    CategoryModel(FontAwesomeIcons.tv, 'entertainment'),
    CategoryModel(FontAwesomeIcons.addressCard, 'general'),
    CategoryModel(FontAwesomeIcons.headSideVirus, 'health'),
    CategoryModel(FontAwesomeIcons.vials, 'science'),
    CategoryModel(FontAwesomeIcons.futbol, 'sports'),
    CategoryModel(FontAwesomeIcons.memory, 'technology'),
  ];


       

  NewsProvider() {
    this.getTopHeadLines();

    categoriesList.forEach((element) {
      this.mcategoryArticles[element.name] = new List();
    });

    this.getArticlesByCategory( this.getselectCategory );

  }

  bool get isLoading => this._isLoading;


/// _selectCategory
  get getselectCategory => this._selectCategory;

  set setselectCategory(String valor){
    this._selectCategory = valor;

    this._isLoading = true;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }




 //mcategoryArticles
  List<Article> get getArticlesCategorySelect => this.mcategoryArticles[this.getselectCategory];

  getArticlesByCategory(String category) async {

    if(this.mcategoryArticles[category].length > 0) {
      this._isLoading = false;
      return this.mcategoryArticles[category];
    }

    final url = '$_URL_NEWS/top-headlines?country=co&apiKey=$_APIKEY&category=$category';
    final resp = await http.get(url);

    final newsResponse = newsModelFromJson(resp.body);

    this.mcategoryArticles[category].addAll(newsResponse.articles);
    this._isLoading = false;
    notifyListeners();
  }




//getTopHeadLines / headlines

  getTopHeadLines() async {
    
    final url = '$_URL_NEWS/top-headlines?country=co&apiKey=$_APIKEY';
    final resp = await http.get(url);

    final newsModel = newsModelFromJson(resp.body);
    this.headlines.addAll(newsModel.articles);
    //TODO Provider NewsProvider  1.1
    notifyListeners();
  }

  
  
}