import 'package:flutter/material.dart';
import 'package:grocery_app/grocery_item_model.dart';
import 'package:grocery_app/items.dart';

void main() => runApp(GroceryApp());

class GroceryApp extends StatelessWidget {
  const GroceryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(primaryColor: Colors.green),
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
  List<GroceryItem> _groceryItems = [];
  List<GroceryItem> _cart = [];
  
  @override
  void initState() {
    // Map our data into Models
    _groceryItems = items
        .map(
          (item) => GroceryItem.fromMap(item),
        )
        .toList();

    // Cart is initially empty
    _cart = [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery App"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          bool inCart = _cart.contains(_groceryItems[index]);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              tileColor: Colors.white,
              title: Text('${_groceryItems[index].name}'),
              leading: Container(
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_groceryItems[index].img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              subtitle: Text(
                "Price: ${items[index]['price']}\$",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              trailing: Material(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (!inCart)
                        _cart.add(_groceryItems[index]);
                      else
                        _cart.remove(_groceryItems[index]);
                    });
                  },
                  icon: inCart ? Icon(Icons.remove_shopping_cart_rounded) : Icon(Icons.add_shopping_cart_rounded),
                  color: inCart ? Colors.red : Theme.of(context).primaryColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
