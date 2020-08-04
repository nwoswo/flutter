import 'package:flutter/material.dart';
import 'package:newprovider/src/provider/news_provider.dart';
import 'package:newprovider/src/theme/tema.dart';
import 'package:newprovider/src/views/tabs_page.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO Provider NewsProvider  1.1
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new NewsProvider() ),
      ],
      child: MaterialApp(
        title: 'Material App',
        theme: miTema,
        debugShowCheckedModeBanner: false,
        home: Tabspage()
      ),
    );
  }
}