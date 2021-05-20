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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery App"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(8.0),
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
              tileColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
