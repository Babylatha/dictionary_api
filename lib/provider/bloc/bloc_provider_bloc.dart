import 'package:bloc/bloc.dart';
import 'package:dictionary_api/models/dictionary_model.dart';
import 'package:dictionary_api/services/api_service.dart';
import 'package:meta/meta.dart';

part 'bloc_provider_event.dart';
part 'bloc_provider_state.dart';

class BlocProviderBloc extends Bloc<BlocProviderEvent, BlocProviderState> {
  final _service = ApiService();
  DictionaryModel? dictValue;

  Future<DictionaryModel?>? getValues(String value) async {
    final response = await _service.fetchApi(value);
    if (response != null) {
      dictValue = response;
      return response;
    } else {
      return null;
    }
  }

  BlocProviderBloc() : super(BlocProviderInitial()) {
    on<BlocProviderEvent>((event, emit) async {
      if (event is FetchDictionaryValues) {
        emit(DictionaryLoading());

        try {
          final dictValue = await getValues(event.query);
          emit(DictionaryLoaded(dictValue!.list));
        } catch (e) {
          emit(DictionaryError('An error occurred: $e'));
        }
      }
    });
  }
}
