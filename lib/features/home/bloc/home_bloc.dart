import 'package:crypto_coins_list/repositories/products/models/product.dart';
import 'package:crypto_coins_list/repositories/products/products_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.repository) : super(HomeInitial()) {
    on<LoadHomeProducts>(_loadHome);
  }
  ProductsRepository repository;

  Future<void> _loadHome(
      LoadHomeProducts event, Emitter<HomeState> emit) async {
    try {
      if (state is! HomeLoaded) emit(HomeLoading());
      final randomProducts = await repository.fetchRandomProducts();
      emit(HomeLoaded(randomProducts));
    } catch (e, st) {
      emit(HomeLoadingFailure(e, st));
    }
  }
}
