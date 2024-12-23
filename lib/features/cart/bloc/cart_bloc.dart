// ignore_for_file: unused_catch_stack

import 'package:crypto_coins_list/repositories/products/models/cart_item.dart';
import 'package:crypto_coins_list/repositories/products/products_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this.repository) : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      try {
        if (state is! CartLoaded) {
          emit(CartLoading());
        }
        final cartItemsList = await repository.getCartList();
        emit(CartLoaded(cartItemsList: cartItemsList));
      } catch (e, st) {
        emit(CartLoadingFailure(e: e, st: st));
      }
    });
  }
  ProductsRepository repository;
  // _load(LoadCartItems event, Emitter<CartState> state) {}
}
