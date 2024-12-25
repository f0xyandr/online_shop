part of "home_bloc.dart";

class HomeState {}

class HomeLoaded extends HomeState {
  HomeLoaded(this.randomProducts);
  final List<Product> randomProducts;
}

class HomeLoading extends HomeState {}

class HomeLoadingFailure extends HomeState {
  HomeLoadingFailure(this.e, this.st);
  Object e;
  Object st;
}

class HomeInitial extends HomeState {}
