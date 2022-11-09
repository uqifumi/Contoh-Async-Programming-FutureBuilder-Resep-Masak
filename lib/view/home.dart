import 'package:flutter/material.dart';
import 'package:async_programming_futurebuilder_resepmasak/view/detailmasak.dart';
import 'package:async_programming_futurebuilder_resepmasak/viewmodel/fetchdatamasak.dart';
import 'package:async_programming_futurebuilder_resepmasak/model/resep.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masak Apa'),
      ),
      body: FutureBuilder<List<Result>>(
          future: fetchMasak(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              const Center(
                child: Text('Gagal ambil data...'),
              );
            }
            return snapshot.hasData
                ? ListMasak(result: snapshot.data)
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class ListMasak extends StatelessWidget {
  const ListMasak({Key? key, required this.result}) : super(key: key);
   final List<Result>? result;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: result?.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Detail(
                            result: result![index],
                          )));
            },
            child: Card(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(
                      result![index].thumb,
                      height: 75,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(result![index].title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        Text("Level: ${result![index].difficulty}"),
                        Text("Penyajian: ${result![index].serving}"),
                        Text("Waktu: ${result![index].times}")
                      ],
                    ),
                  ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
