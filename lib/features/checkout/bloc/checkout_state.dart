part of 'checkout_bloc.dart';

class CheckoutState {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoadingFailure extends CheckoutState {}
