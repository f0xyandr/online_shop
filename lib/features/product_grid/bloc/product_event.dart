part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProduct extends ProductEvent {
  const LoadProduct({required this.categoryId});
  final int categoryId;

  @override
  List<Object> get props => super.props..add(categoryId);
}

class LoadFilteredProduct extends ProductEvent {
  const LoadFilteredProduct({required this.minPrice, required this.maxPrice});

  final double minPrice;
  final double maxPrice;

  @override
  List<Object> get props => super.props..addAll([minPrice, maxPrice]);
}
