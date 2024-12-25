part of 'cart_bloc.dart';

class CartEvent {}

class LoadCartItems extends CartEvent {}

class DeleteCartItems extends CartEvent {
  final userId; // ID пользователя
  final List productIds; // ID товаров для удаления

  DeleteCartItems({required this.userId, required this.productIds});
}
