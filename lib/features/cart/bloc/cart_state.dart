// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  List<CartItem> cartItemsList = [];
  CartLoaded({
    required this.cartItemsList,
  });
}

class CartLoading extends CartState {}

class CartLoadingFailure extends CartState {
  Object e;
  Object st;
  CartLoadingFailure({required this.e, this.st = "stacktrace is empty"});
}
