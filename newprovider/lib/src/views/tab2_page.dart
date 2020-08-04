import 'package:flutter/material.dart';
import 'package:newprovider/src/models/category_model.dart';
import 'package:newprovider/src/provider/news_provider.dart';
import 'package:newprovider/src/theme/tema.dart';
import 'package:newprovider/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';


class Tab2page extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

  final newsProvider = Provider.of<NewsProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[

            _ListaCategorias(),

            if ( !newsProvider.isLoading )
              Expanded(
                child: ListaNoticias( newsProvider.getArticlesCategorySelect )
              ),

            if ( newsProvider.isLoading )
            Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              )
            )

         

          ],
        )
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    final categoriesList= Provider.of<NewsProvider>(context).categoriesList;

    return Container(
      width: double.infinity,
      height: 80,
      // color: Colors.red,
      child: ListView.builder(
        physics: BouncingScrollPhysics(), //crea un scroll 
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        itemBuilder: (BuildContext context, int index) {
          final cname = categoriesList[index].name;
          return Container(
            width: 95,
            child: Padding(
              padding:  EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  _CategoryButtom(categoriesModel: categoriesList[index]),
                  SizedBox(height: 5,),
                  Text('${cname[0].toUpperCase()}${cname.substring(1)}', style: TextStyle(fontSize: 12 ), )
                ],
              ),
            ),
          );
       },
      ),
    );
  }
}

class _CategoryButtom extends StatelessWidget {
  
  const _CategoryButtom({
    
    @required this.categoriesModel,
  });

  final CategoryModel categoriesModel;

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return GestureDetector(
      onTap: () {
        final newsProvider = Provider.of<NewsProvider>(context, listen: false);
        newsProvider.setselectCategory = categoriesModel.name;
        print('${categoriesModel.name}');
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          categoriesModel.icon,
          color: (this.categoriesModel.name == newsProvider.getselectCategory)
                    ? miTema.accentColor 
                    : Colors.black, 
        ),
      ),
    );
  }
}