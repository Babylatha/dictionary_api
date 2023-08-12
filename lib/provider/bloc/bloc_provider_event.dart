part of 'bloc_provider_bloc.dart';

@immutable
abstract class BlocProviderEvent {}

class FetchDictionaryValues extends BlocProviderEvent {
  final String query;

  FetchDictionaryValues(this.query);
}
