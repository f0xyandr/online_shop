// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'checkout_bloc.dart';

class CheckoutState {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class TokenLoading extends CheckoutState {}

class TokenLoaded extends CheckoutState {
  Object payment;
  TokenLoaded(
    this.payment,
  );
}

class TokenLoadingFailure extends CheckoutState {
  Object? e;
  Object? st;
  TokenLoadingFailure({
    this.e,
    this.st,
  });
}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoadingFailure extends CheckoutState {
  Object? e;
  Object? st;
  CheckoutLoadingFailure({
    this.e,
    this.st,
  });
}
