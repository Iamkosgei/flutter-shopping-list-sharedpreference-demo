import 'package:flutter/material.dart';

import '../models/shopping_lists.dart';

class ShoppingCartDetailsPage extends StatelessWidget {
  final ShoppingList shoppingList;
  const ShoppingCartDetailsPage({Key? key, required this.shoppingList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            '${shoppingList.name}',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: shoppingList.products?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${shoppingList.products![index].name}'),
              );
            }));
  }
}
