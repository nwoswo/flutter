import 'package:flutter/material.dart';
import 'package:newprovider/src/models/news_model.dart';
import 'package:newprovider/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';


import 'package:newprovider/src/provider/news_provider.dart';


class Tab1Page extends StatefulWidget {
  const Tab1Page({Key key}) : super(key: key);

  @override
  _Tab1PageState createState() => _Tab1PageState();
}

//TODO Scroll stado return 
class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {

    //TODO Provider NewsProvider  1.2
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      body: (newsProvider.headlines == 0)
        ? Center( child: CircularProgressIndicator(),)
        : ListaNoticias(newsProvider.headlines ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

