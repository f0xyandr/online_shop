part of 'product_categories_bloc.dart';

class ProductCategoriesState {
  const ProductCategoriesState();

  @override
  List<Object> get props => [];
}

class ProductCategoriesLoading extends ProductCategoriesState {
  const ProductCategoriesLoading();

  @override
  List<Object> get props => [];
}

class ProductCategoriesLoaded extends ProductCategoriesState {
  const ProductCategoriesLoaded({required this.productCategoriesList});
  final List<ProductCategory> productCategoriesList;
  @override
  List<Object> get props => [productCategoriesList];
}

class ProductCategoriesLoadingFailure extends ProductCategoriesState {
  const ProductCategoriesLoadingFailure({this.exception});
  final Object? exception;
  @override
  List<Object> get props => [];
}

class ProductCategoriesInitial extends ProductCategoriesState {}
