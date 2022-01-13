import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Controller extends GetxController {
  final dados = {}.obs;
  final data = 0.obs;
  final load = true.obs;

  final statusError = false.obs;

  @override
  void onReady() {
    super.onReady();
    getJson();
  }

  Future<void> getJson() async {
    try {
      var url = Uri.parse(
        'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson',
      );
      http.Response response = await http.get(url);
      dados.addAll(
        json.decode(response.body),
      );
    } catch (err) {
      statusError.value = false;
    } finally {
      load.value = false;
    }
  }
}
