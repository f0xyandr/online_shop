import 'package:crypto_coins_list/repositories/products/abstract_products_repository.dart';
import 'package:crypto_coins_list/repositories/products/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'product_categories_event.dart';
part 'product_categories_state.dart';

class ProductCategoriesBloc
    extends Bloc<ProductCategoriesEvent, ProductCategoriesState> {
  ProductCategoriesBloc(this.productsRepository)
      : super(ProductCategoriesInitial()) {
    on<LoadProductCategories>((event, emit) async {
      try {
        if (state is! ProductCategoriesLoaded) {
          emit(const ProductCategoriesLoading());
        }
        final productCategoriesList =
            await productsRepository.getProductCategoryList();
        emit(ProductCategoriesLoaded(
            productCategoriesList: productCategoriesList));
      } catch (e, st) {
        emit(ProductCategoriesLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      }
    });
  }
  final AbstractProductsRepository productsRepository;
}
