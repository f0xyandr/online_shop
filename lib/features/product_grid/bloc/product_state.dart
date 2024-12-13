part of 'product_bloc.dart';

class ProductState {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {
  const ProductLoading();

  @override
  List<Object> get props => [];
}

class ProductLoaded extends ProductState {
  const ProductLoaded({required this.productList});
  final List<Product> productList;

  @override
  List<Object> get props => [productList];
}

class ProductLoadingFailure extends ProductState {
  const ProductLoadingFailure({this.exception});
  final Object? exception;
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}
