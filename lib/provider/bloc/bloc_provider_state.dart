part of 'bloc_provider_bloc.dart';

@immutable
abstract class BlocProviderState {}

class BlocProviderInitial extends BlocProviderState {}

class DictionaryLoading extends BlocProviderState {}

class DictionaryLoaded extends BlocProviderState {
  final List<ListElement> list;

  DictionaryLoaded(this.list);
}

class DictionaryError extends BlocProviderState {
  final String errorMessage;

  DictionaryError(this.errorMessage);
}
