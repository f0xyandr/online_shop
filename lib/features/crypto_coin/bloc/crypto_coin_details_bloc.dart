// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:crypto_coins_list/repositories/crypto_coins/abstrarct_coins_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../repositories/crypto_coins/models/models.dart';
part 'crypto_coin_details_event.dart';
part 'crypto_coin_details_state.dart';

class CryptoCoinDetailsBloc
    extends Bloc<CryptoCoinDetailsEvent, CryptoCoinDetailsState> {
  CryptoCoinDetailsBloc(this.coinsRepository)
      : super(const CryptoCoinDetailsState()) {
    on<LoadCryptoCoinDetails>(_load);
  }
  final AbstractCoinsRepository coinsRepository;

  Future<void> _load(LoadCryptoCoinDetails event,
      Emitter<CryptoCoinDetailsState> state) async {
    try {
      if (state is! CryptoCoinDetailsLoaded) {
        emit(const CryptoCoinDetailsLoading());
      }
      final coin = await coinsRepository.getCoinDetails(event.currencyCode);
      emit(CryptoCoinDetailsLoaded(coin));
    } catch (e, st) {
      emit(CryptoCoinDetailsLoadingFailure(exception: e));
      GetIt.I<Talker>().handle(e, st);
    }
  }
}
