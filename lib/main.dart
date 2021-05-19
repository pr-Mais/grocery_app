import 'package:flutter/material.dart';
import 'package:grocery_app/cart_page.dart';
import 'package:grocery_app/grocery_item_card.dart';
import 'package:grocery_app/items.dart';


void main() => runApp(GroceryApp());

class GroceryApp extends StatelessWidget {
  const GroceryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GroceryItem> _items = [];
  List<GroceryItem> _cart = [];

  @override
  void initState() {
    // Map our data into Models
    _items = items
        .map(
          (item) => GroceryItem.fromMap(item),
        )
        .toList();

    // Cart is initially empty
    _cart = [];

    super.initState();
  }

  void _pushCart() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return CartPage(
            cart: _cart,
            cartChanged: (value) {
              setState(() {
                _cart = value;
              });
            },
          );
        },
      ),
    );
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
          return GroceryItemCard(
            cart: _cart,
            item: _items[index],
            onChanged: (bool inCart) => setState(() {
              if (inCart)
                _cart.remove(_items[index]);
              else
                _cart.add(_items[index]);
            }),
          );
        },
      ),
    );
  }
}

class GroceryItemCard extends StatelessWidget {
  GroceryItemCard({
    Key? key,
    required this.cart,
    required this.item,
    required this.onChanged,
  }) : super(key: key);

  late final List<GroceryItem> cart;
  late final GroceryItem item;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    bool _inCart = cart.contains(item);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: ListTile(
        tileColor: Colors.white,
        leading: Container(
          width: 50,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(item.img),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          item.name,
          overflow: TextOverflow.clip,
          style: Theme.of(context).textTheme.headline1,
        ),
        subtitle: Text(
          "Price: ${item.price.toString()}\$",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        trailing: IconButton(
          onPressed: () => onChanged(_inCart),
          icon: _inCart ? Icon(Icons.remove_shopping_cart_rounded) : Icon(Icons.add_shopping_cart_rounded),
          color: _inCart ? Colors.red : Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
