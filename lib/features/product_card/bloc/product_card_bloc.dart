// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:crypto_coins_list/repositories/products/models/models.dart';
import 'package:crypto_coins_list/repositories/products/products_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'product_card_event.dart';
part 'product_card_state.dart';

class ProductCardBloc extends Bloc<ProductCardEvent, ProductCardState> {
  ProductCardBloc(this.productsRepository) : super(const ProductCardInitial()) {
    on<LoadProductCard>(_load);
  }
  Future<void> _load(
      LoadProductCard event, Emitter<ProductCardState> state) async {
    try {
      if (state is! ProductCardLoaded) emit(ProductCardLoading());
      final productCard = await productsRepository.getProduct(event.product.id);
      emit(const ProductCardLoaded());
    } catch (e, st) {
      emit(ProductCardLoadingFailure());
      GetIt.I<Talker>().handle(e, st);
    }
  }

  ProductsRepository productsRepository;
}
