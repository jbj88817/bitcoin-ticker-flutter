import 'dart:convert';

import 'package:http/http.dart' as http;

const BASE_URL = 'rest.coinapi.io';
const API_KEY = 'C1605A22-ECEA-4222-8939-8DC02154C718';

Future<double> getRate(String coin, String currency) async {
  http.Response response = await http.get(Uri.https(
      BASE_URL, '/v1/exchangerate/$coin/$currency', {'apikey': API_KEY}));
  final Map<String, dynamic> object = JsonDecoder().convert(response.body);
  return object['rate'];
}
