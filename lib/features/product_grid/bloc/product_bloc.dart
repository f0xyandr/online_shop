import 'package:crypto_coins_list/repositories/products/abstract_products_repository.dart';
import 'package:crypto_coins_list/repositories/products/models/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this.productsRepository) : super(ProductInitial()) {
    on<LoadProduct>(_loadProduct);
  }
  _loadProduct(LoadProduct event, Emitter<ProductState> emit) async {
    try {
      if (state is! ProductLoaded) emit(const ProductLoading());
      final productList =
          await productsRepository.getProductList(event.categoryId);
      debugPrint("ProductList $productList");
      emit(ProductLoaded(productList: productList));
    } catch (e, st) {
      emit(ProductLoadingFailure(exception: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  final AbstractProductsRepository productsRepository;
}
