import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/shopping_list_cubit/shopping_list_cubit.dart';
import 'add_shopping_list_page.dart';
import 'shopping_cart_details_page.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({Key? key}) : super(key: key);

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ShoppingListCubit>().getShoppingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const Text(
            'Shopping List',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<ShoppingListCubit>().deleteAllShoppingLists();
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ],
        ),
        body: BlocBuilder<ShoppingListCubit, ShoppingListState>(
          builder: (context, state) {
            if (state is ShoppingListLoaded) {
              var _shoppingList = state.shoppingList.shoppingList;
              return _shoppingList?.isEmpty ?? true
                  ? const Center(
                      child: Text('No items'),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: _shoppingList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        ShoppingCartDetailsPage(
                                            shoppingList:
                                                _shoppingList![index]))));
                          },
                          title: Text('${_shoppingList![index].name}'),
                          subtitle: Text(
                              '${_shoppingList[index].products?.length ?? 0} product(s)'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              context
                                  .read<ShoppingListCubit>()
                                  .deleteOneShoppingList(
                                      _shoppingList[index].id ?? 0);
                            },
                          ),
                        );
                      });
            }
            return Container();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddShoppingListPage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ));
  }
}
