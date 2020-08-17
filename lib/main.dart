import 'package:flutter/material.dart';

import 'cart_page.dart';
import 'grocery_item_card.dart';

void main() => runApp(GroceryApp());

class GroceryApp extends StatelessWidget {
  const GroceryApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GroceryItem> _items = [
    GroceryItem(img: "assets/tomato.jpg", name: "Tomato", price: 1),
    GroceryItem(img: "assets/orange.jpg", name: "Orange", price: 1),
    GroceryItem(img: "assets/toothpaste.jpeg", name: "Toothpaste", price: 1),
    GroceryItem(img: "assets/chips.jpeg", name: "Chips", price: 1),
    GroceryItem(img: "assets/bread.jpg", name: "Bread", price: 1),
    GroceryItem(img: "assets/chocolate.jpg", name: "Chocolate", price: 1),
    GroceryItem(img: "assets/coffee.jpg", name: "Coffee", price: 1),
    GroceryItem(img: "assets/potato.jpg", name: "Potato", price: 1),
    GroceryItem(img: "assets/flour.jpg", name: "Flour", price: 1),
  ];

  List<GroceryItem> _cart = [];

  void _pushCart() {
    final _cards = _cart.map((item) {
      return Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(item.img ?? "assets/placeholder.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Price: ${item.price.toString()}\$",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }).toList();

    double _total = 0.0;

    for (var item in _cart) {
      _total += item.price;
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return CartPage(
          cards: _cards,
          total: _total,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery App"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: _pushCart,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return _buildItemCard(_items[index]);
        },
      ),
    );
  }

  Widget _buildItemCard(GroceryItem item) {
    bool _inCart = _cart.contains(item);
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 10,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(item.img ?? "assets/placeholder.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Price: ${item.price.toString()}\$",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                FlatButton.icon(
                  onPressed: () {
                    setState(() {
                      if (_inCart)
                        _cart.remove(item);
                      else
                        _cart.add(item);

                      _inCart = _cart.contains(item);
                    });
                  },
                  icon: _inCart ? Icon(Icons.remove) : Icon(Icons.add),
                  label:
                      _inCart ? Text("Remove from Cart") : Text("Add to Cart"),
                  color: _inCart ? Colors.red : Theme.of(context).primaryColor,
                  textColor: Colors.white,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
