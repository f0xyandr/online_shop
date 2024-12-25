// ignore_for_file: unused_catch_stack

import 'package:crypto_coins_list/repositories/products/models/cart_item.dart';
import 'package:crypto_coins_list/repositories/products/products_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this.repository) : super(CartInitial()) {
    on<LoadCartItems>(_onLoadCartItems);
    on<DeleteCartItems>(_onDeleteCartItems);
  }

  ProductsRepository repository;

  Future<void> _onLoadCartItems(
      LoadCartItems event, Emitter<CartState> emit) async {
    try {
      if (state is! CartLoaded) {
        emit(CartLoading());
      }
      final cartItemsList = await repository.getCartList();
      emit(CartLoaded(cartItemsList: cartItemsList));
    } catch (e, st) {
      emit(CartLoadingFailure(e: e, st: st));
    }
  }

  Future<void> _onDeleteCartItems(
      DeleteCartItems event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        final currentState = state as CartLoaded;

        // Удаляем записи из базы данных
        await repository.deleteCartItems(event.userId, event.productIds);

        // Фильтруем удалённые товары из локального состояния
        final updatedCartItems = currentState.cartItemsList
            .where((item) => !event.productIds.contains(item.product.id))
            .toList();

        // Обновляем состояние
        emit(CartLoaded(cartItemsList: updatedCartItems));
      } catch (e, st) {
        emit(CartLoadingFailure(e: e, st: st));
      }
    }
  }

  // _load(LoadCartItems event, Emitter<CartState> state) {}
}
