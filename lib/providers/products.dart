import 'package:Shop_App/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://www.phoenixfm.com/wp-content/uploads/2020/04/112-trousers.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://i.etsystatic.com/12986271/r/il/0c7dda/2057119263/il_570xN.2057119263_hyb6.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want',
      price: 49.99,
      imageUrl: 'https://pngimg.com/uploads/frying_pan/frying_pan_PNG8347.png',
    ),
    Product(
      id: 'p5',
      title: 'Watch',
      description: 'It can change your time from bad to good',
      price: 50.50,
      imageUrl:
          'https://i.gadgets360cdn.com/products/large/realme-watch-670x800-1590388807.jpg',
    ),
    Product(
      id: 'p6',
      title: 'Nike Shoes',
      description: 'Just Do It',
      price: 45.25,
      imageUrl:
          'https://n3.sdlcdn.com/imgs/i/z/e/Nike-Air-Max-2017-Blue-SDL648900888-1-60f11.jpg',
    ),
    Product(
      id: 'p7',
      title: 'Iphone 11',
      description: 'Mobile of the century',
      price: 65.25,
      imageUrl:
          'https://cairosales.com/31379-thickbox_default/apple-iphone-11pro-with-facetime-64-gb-space-grey.jpg',
    ),
  ];
  var _showFavoritesOnly = false;
  List<Product> get items {
    // if(_showFavoritesOnly){
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly(){
  //   _showFavoritesOnly=true;
  //   notifyListeners();
  // }
  // void showAll(){
  //   _showFavoritesOnly=false;
  //   notifyListeners();
  // }
  Future<void> addProduct(Product product) {
    const url =
        'https://shop-app-2107-default-rtdb.firebaseio.com/products.json';
    return http
        .post(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'price': product.price,
              'imageURL': product.imageUrl,
              'isFavorite': product.isFavorite
            }))
        .then((response) {
      print(json.decode(response.body));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    });
  }
}
