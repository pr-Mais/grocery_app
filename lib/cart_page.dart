import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  CartPage({
    Key key,
    this.cards,
    this.total,
  }) : super(key: key);
  final List<Widget> cards;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return cards[index];
              },
            ),
          ),
          SizedBox(height: 50),
          Text("Total: ${total.toString()}\$",
              style: TextStyle(
                fontSize: 30,
              )),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
