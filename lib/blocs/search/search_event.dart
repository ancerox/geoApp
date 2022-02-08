part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnShowMarkEvent extends SearchEvent {}

class OffShowMarkEvent extends SearchEvent {}
