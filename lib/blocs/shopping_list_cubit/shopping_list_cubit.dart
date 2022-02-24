import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/shopping_lists.dart';
import '../../services/shared_pref.dart';

part 'shopping_list_state.dart';

class ShoppingListCubit extends Cubit<ShoppingListState> {
  ShoppingListCubit() : super(ShoppingListInitial());

  Future<void> getShoppingList() async {
    emit(ShoppingListLoading());

    try {
      var _shoppingList = await SharedPref.getString('shopping_list');
      if (_shoppingList != null) {
        emit(ShoppingListLoaded(
            ShoppingLists.fromJson(jsonDecode(_shoppingList))));
      } else {
        emit(ShoppingListLoaded(ShoppingLists(shoppingList: <ShoppingList>[])));
      }
    } catch (e) {
      log('$e');
      emit(ShoppingListLoaded(ShoppingLists(shoppingList: <ShoppingList>[])));
    }
  }

  Future<void> addShopingList(ShoppingList shoppingList) async {
    var _shoppingList = await SharedPref.getString('shopping_list');
    if (_shoppingList != null) {
      var _currentShopping = ShoppingLists.fromJson(jsonDecode(_shoppingList));

      _currentShopping.shoppingList?.add(shoppingList);

      await SharedPref.setString(
          'shopping_list', jsonEncode(_currentShopping.toJson()));
    } else {
      var _newShoppingList = ShoppingLists(shoppingList: [shoppingList]);
      await SharedPref.setString(
          'shopping_list', jsonEncode(_newShoppingList.toJson()));
    }

    getShoppingList();
  }

  Future<void> deleteOneShoppingList(int id) async {
    var _shoppingList = await SharedPref.getString('shopping_list');
    if (_shoppingList != null) {
      var _currentShopping = ShoppingLists.fromJson(jsonDecode(_shoppingList));

      _currentShopping.shoppingList = _currentShopping.shoppingList
          ?.where((element) => element.id != id)
          .toList();
      await SharedPref.setString(
          'shopping_list', jsonEncode(_currentShopping.toJson()));
    }
    getShoppingList();
  }

  Future<void> deleteAllShoppingLists() async {
    await SharedPref.deleteAll();
    getShoppingList();
  }
}
