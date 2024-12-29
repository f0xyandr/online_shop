// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'checkout_bloc.dart';

class CheckoutEvent {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class LoadPayment extends CheckoutEvent {
  final List<CartItem> cartItems;

  LoadPayment(this.cartItems);

  @override
  List<Object> get props => [cartItems];
}

class LoadCheckOut extends CheckoutEvent {}
