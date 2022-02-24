import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/shopping_list_cubit/shopping_list_cubit.dart';
import '../models/shopping_lists.dart';

class AddShoppingListPage extends StatefulWidget {
  const AddShoppingListPage({Key? key}) : super(key: key);

  @override
  _AddShoppingListPageState createState() => _AddShoppingListPageState();
}

class _AddShoppingListPageState extends State<AddShoppingListPage> {
  List<Product> products = [];

  final _productFormKey = GlobalKey<FormState>();

  final _productListFormKey = GlobalKey<FormState>();

  String? _productName, _productListName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          'Add shopping list',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _productListFormKey,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter the product list name",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the product list name';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _productListName = val;
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Products'),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          builder: (context) {
                            return SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Add product'),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Form(
                                      key: _productFormKey,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: "Enter the product name",
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            borderSide: const BorderSide(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter the product name';
                                          }
                                          return null;
                                        },
                                        onSaved: (val) {
                                          _productName = val;
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_productFormKey.currentState!
                                            .validate()) {
                                          _productFormKey.currentState?.save();
                                          products.add(Product(
                                            name: _productName,
                                            id: DateTime.now()
                                                .millisecondsSinceEpoch,
                                          ));
                                          setState(() {});
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Text('Add Product'),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: const Text('Add product'),
                  ),
                ],
              ),
              Expanded(
                  child: ListView.separated(
                itemBuilder: (BuildContext context, int index) => ListTile(
                  title: Text('${products[index].name}'),
                  trailing: IconButton(
                      onPressed: () {
                        products = products
                            .where(
                                (element) => element.id != products[index].id)
                            .toList();
                        setState(() {});
                      },
                      icon: const Icon(Icons.close)),
                ),
                itemCount: products.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              )),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_productListFormKey.currentState!.validate()) {
                      _productListFormKey.currentState?.save();

                      if (products.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Add atleast one product to the shopping list')),
                        );
                        return;
                      }

                      context.read<ShoppingListCubit>().addShopingList(
                          ShoppingList(
                              id: DateTime.now().millisecondsSinceEpoch,
                              name: _productListName,
                              products: products));

                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add Shopping List'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
