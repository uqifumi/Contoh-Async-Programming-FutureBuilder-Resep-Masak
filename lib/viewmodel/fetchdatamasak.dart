import 'package:http/http.dart';
import 'package:async_programming_futurebuilder_resepmasak/model/resep.dart';

Future<List<Result>> fetchMasak() async {
  List<Result> datamasak;

  Response response = await get(Uri.parse(
      'https://masak-apa-tomorisakura.vercel.app/api/recipes-length/?limit=10'));
  
  if (response.statusCode == 200) {
    final masak = masakFromJson(response.body);
    Map jsonMasak = masak.toJson();
    List listMasak = jsonMasak["results"] as List;
    datamasak = listMasak.map<Result>((json) => Result.fromJson(json)).toList();
    return datamasak;
  } else {
    throw Exception('Failed to load data masak');
  }
}

Future<List<Result>> fetchCariResep(String katakunci) async {
  List<Result> dataresep;

  Response response = await get(Uri.parse(
      'https://masak-apa.tomorisakura.vercel.app/api/search/?q=$katakunci'));
  
  if (response.statusCode == 200) {
    final masak = masakFromJson(response.body);
    Map jsonMasak = masak.toJson();
    List listMasak = jsonMasak["results"] as List;
    dataresep = listMasak.map<Result>((json) => Result.fromJson(json)).toList();
    return dataresep;
  } else {
    throw Exception('Failed to load data masak');
  }
}
