
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:onmyway/blocks/autocomplete/autocomplete_block.dart';
import 'package:onmyway/repositories/places/place_repository.dart';
import 'package:onmyway/views/customerMap.dart';
import 'package:onmyway/views/home.dart';
import 'package:onmyway/views/login.dart';
import 'package:onmyway/views/home.dart';
import 'package:onmyway/views/addCustomer.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  runApp(const OnMyWay());
}

class OnMyWay extends StatelessWidget {
  const OnMyWay({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');
    
    return MultiRepositoryProvider(
        providers: [RepositoryProvider<PlacesRepository>(
              create: (_) => PlacesRepository(),
            ),
        ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AutoCompleteBlock(
                  placesRepository: context.read<PlacesRepository>())
                  ..add(LoadAutoComplete())),
                  ],
                  child: GetMaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: "OnMyWay",
                    // home: token == null ? const Login() : const Home(),
                    home: Customer(),
                  ),
            ),
      );
  }
}
