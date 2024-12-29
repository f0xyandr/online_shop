part of 'product_card_bloc.dart';

class ProductCardState {
  const ProductCardState();

  @override
  List<Object> get props => [];
}

class ProductCardInitial extends ProductCardState {
  const ProductCardInitial();

  @override
  List<Object> get props => [];
}

class ProductCardLoaded extends ProductCardState {
  const ProductCardLoaded(this.product);

  final Product product;
  @override
  List<Object> get props => [];
}

class ProductCardLoading extends ProductCardState {}

class ProductCardLoadingFailure extends ProductCardState {}
