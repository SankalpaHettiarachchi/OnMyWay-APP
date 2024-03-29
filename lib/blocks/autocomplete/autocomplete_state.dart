part of 'autocomplete_block.dart';

abstract class AutoCompleteState extends Equatable {
  const AutoCompleteState();

  @override
  List<Object> get props => [];

}

class AutoCompleteLoading extends AutoCompleteState {}

class AutoCompleteLoaded extends AutoCompleteState {
  final List<PlaceAutocomplete> autocomplete;
  const AutoCompleteLoaded({required this.autocomplete});
  @override
  List<Object> get props => [autocomplete];
}

class AutoCompleteError extends AutoCompleteState {}