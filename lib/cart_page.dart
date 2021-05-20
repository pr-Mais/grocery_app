import 'package:flutter/material.dart';
import 'package:grocery_app/grocery_item_model.dart';
import 'package:grocery_app/main.dart';

class CartPage extends StatefulWidget {
  CartPage({
    Key? key,
    required this.cart,
    required this.cartChanged,
  }) : super(key: key);

  final List<GroceryItem> cart;
  final ValueChanged<List<GroceryItem>> cartChanged;

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double _total = 0.0;

  @override
  void initState() {
    _calculateTotal();
    super.initState();
  }

  void _calculateTotal() {
    // Reset the total to zero in case we are recalculating the price
    _total = 0.0;

    for (var item in widget.cart) {
      setState(() {
        _total += item.price;
      });
    }
  }

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
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                return GroceryItemCard(
                  cart: widget.cart,
                  item: widget.cart[index],
                  onChanged: (bool inCart) => setState(() {
                    if (inCart)
                      widget.cart.remove(widget.cart[index]);
                    else
                      widget.cart.add(widget.cart[index]);
                    widget.cartChanged(widget.cart);
                    _calculateTotal();
                  }),
                );
              },
            ),
          ),
          const SizedBox(height: 50),
          Text(
            "Total: ${_total.toString()}\$",
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
