
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newprovider/src/models/news_model.dart';
import 'package:newprovider/src/theme/tema.dart';

class ListaNoticias extends StatelessWidget {
  
  final List<Article> noticias;

  // de esta forma siempre siempre necesitamos trabajar con noticias sin {}
  const ListaNoticias(this.noticias);

  

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) {
      // return Text(this.noticias[index].title);
      return _Noticia(noticia: this.noticias[index], index: index);
     },
    );
    
  }
}

class _Noticia extends StatelessWidget {
  
  final Article noticia;
  final int index;

  const _Noticia({
    @required this.noticia, 
    @required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TarjetaTopBar(noticia,index),
        _TarjetaTitulo(noticia),
        _TarjetaImagen(noticia),
        _TarjetaBody(noticia),
        _TarjetasBotones(),
        SizedBox(height: 10,),
        Divider()
      ],

    );
  }
}

class _TarjetasBotones extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          RawMaterialButton(
            onPressed: () {},
            fillColor: miTema.accentColor,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20) ),
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 10,),
          
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20) ),
            child: Icon(Icons.more),
          )
        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;
  const _TarjetaBody(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text((noticia.description !=null) ? noticia.description : ''),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {

  final Article noticia;
  final int index;

  const _TarjetaTopBar(this.noticia,this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Text('${index+1}. ', style: TextStyle( color: miTema.accentColor),),
          Text('${noticia.source.name}. '),

        ],
      ),
    );
  }
}


class _TarjetaTitulo extends StatelessWidget {
  
  final Article noticia;
  const _TarjetaTitulo(this.noticia);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15 ),
      child: Text(noticia.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article noticia;
  const _TarjetaImagen(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only( topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: (noticia.urlToImage != null)
            ?CachedNetworkImage(
              imageUrl: noticia.urlToImage,
              placeholder: (context, url) =>  Image.asset('assets/loading.gif'),
              errorWidget: (context, url, error) => Image(image: AssetImage('assets/image_default.png'),),
              )
            : Image.asset('assets/image_default.png'),
          // child: (noticia.urlToImage != null)

          //   ?FadeInImage(
          //     placeholder: AssetImage('assets/loading.gif'), 
          //     image: NetworkImage(noticia.urlToImage),
          //   )
          //   : Image(image: AssetImage('assets/image_default.png'),)

          
        ),
      ),
    );
  }
}