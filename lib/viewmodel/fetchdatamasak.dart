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
