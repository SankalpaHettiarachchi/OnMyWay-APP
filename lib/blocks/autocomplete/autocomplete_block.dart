import 'dart:async';
import 'package:onmyway/models/place_autocomplete_model.dart';
import 'package:onmyway/repositories/places/place_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part "autocomplete_events.dart";
part "autocomplete_state.dart";

class AutoCompleteBlock extends Bloc<AutoCompleteEvent, AutoCompleteState> {
  final PlacesRepository _placesRepository;
  StreamSubscription? _placesSubscription;

  AutoCompleteBlock({required PlacesRepository placesRepository})
      : _placesRepository = placesRepository,
        super(AutoCompleteLoading());

  @override
  Stream<AutoCompleteState> mapEventToState(
    AutoCompleteEvent event,
  ) async* {
    if (event is LoadAutoComplete) {
      yield* _mapLoadAutocompleteToState(event);
    }
  }

  Stream<AutoCompleteState> _mapLoadAutocompleteToState(
    LoadAutoComplete event) async*{
      _placesSubscription?.cancel();

      final List<PlaceAutocomplete> autocomplete =
        await _placesRepository.getAutocomplete(event.searchInput);
    
      yield AutoCompleteLoaded(autocomplete:autocomplete);
    }
}
