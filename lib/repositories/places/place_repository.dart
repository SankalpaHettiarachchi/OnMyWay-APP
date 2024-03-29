import 'package:onmyway/repositories/places/base_places_repository.dart';
import 'package:onmyway/models/place_autocomplete_model.dart';
import 'package:onmyway/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesRepository extends BasePlacesRepository {
  final String key = GOOGLE_MAPS_API_KEY;
  final String types = 'geocode';

  Future<List<PlaceAutocomplete>> getAutocomplete(String searchInput) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&types=$types&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['predictions'] as List;

    return results.map((place) => PlaceAutocomplete.fromJson(place)).toList();
  }
}
