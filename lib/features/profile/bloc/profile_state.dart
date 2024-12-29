// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

class ProfileState {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoadingFailure extends ProfileState {
  Object? e;
  Object? st;
  ProfileLoadingFailure({
    required this.e,
    required this.st,
  });
}
