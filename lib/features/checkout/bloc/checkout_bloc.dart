import 'package:crypto_coins_list/repositories/products/products_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/products/models/models.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc({required this.repository}) : super(CheckoutInitial()) {
    on<LoadPayment>(_loadPayPal);
  }

  final ProductsRepository repository;

  Future<void> _loadPayPal(
      LoadPayment event, Emitter<CheckoutState> emit) async {
    try {
      // Получаем токен доступа
      final accessToken = await repository.getPayPalAccessToken();
      emit(TokenLoaded(accessToken));

      // Создаем платеж
      final double total = event.cartItems
          .fold(0, (sum, item) => sum + item.product.price * item.quantity);
      await repository.createTestPayment(accessToken, total);
    } catch (e, st) {
      emit(TokenLoadingFailure(e: e, st: st));
    }
  }
}
