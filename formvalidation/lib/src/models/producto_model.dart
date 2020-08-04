// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

//recibe un json-String  -> regresa un NewProductoModel
ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

//NewProductoModel -> to Json-String
String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    ProductoModel({
        this.id,
        this.titulo = '',
        this.valor = 0.0,
        this.disponible = true,
        this.fotoUrl,
    });

    String id;
    String titulo;
    double valor;
    bool disponible;
    String fotoUrl;


    //MAP TO newProducto
    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id          : json["id"],
        titulo      : json["titulo"],
        valor       : json["valor"],
        disponible  : json["disponible"],
        fotoUrl     : json["fotoUrl"],
    );

    //nEWpRODUCTO to Json
    Map<String, dynamic> toJson() => {
        // "id"          : id,
        "titulo"      : titulo,
        "valor"       : valor,
        "disponible"  : disponible,
        "fotoUrl"     : fotoUrl,
    };
}
