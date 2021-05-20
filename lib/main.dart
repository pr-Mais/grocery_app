import 'package:flutter/material.dart';
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
  List<Map<String, dynamic>> cart = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery App"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          bool inCart = cart.contains(items[index]);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              tileColor: Colors.white,
              title: Text('${items[index]['name']}'),
              leading: Container(
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(items[index]['img']),
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
                        cart.add(items[index]);
                      else
                        cart.remove(items[index]);
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
