import 'package:flutter/material.dart';
import 'package:async_programming_futurebuilder_resepmasak/model/resep.dart';
import 'package:async_programming_futurebuilder_resepmasak/model/detailresep.dart';
import 'package:async_programming_futurebuilder_resepmasak/viewmodel/fetchdetailmasak.dart';

class Detail extends StatelessWidget {
  const Detail({Key? key, required this.result}) : super(key: key);
  final Result result;

  @override
  Widget build(BuildContext context) {
    String judul = result.key;
    return Scaffold(
      body: FutureBuilder<DetailMasak>(
          future: fetchDetailMasak(judul),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              const Center(
                child: Text('Gagal ambil data...'),
              );
            }
            return snapshot.hasData
                ? TampilCaraMasak(datadetailmasak: snapshot.data)
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class TampilCaraMasak extends StatelessWidget {
  const TampilCaraMasak({Key? key, required this.datadetailmasak}) : super(key: key);
  final DetailMasak? datadetailmasak;
  final bool? gambar = true;

  @override
  Widget build(BuildContext context) {
    // Widget bagian judul.
    Widget bagianJudul = Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(datadetailmasak!.results.title,
                      style: Theme.of(context).textTheme.headline6),
                ),
                Text('Level: ${datadetailmasak!.results.difficulty}'),
                Text('Penyajian: ${datadetailmasak!.results.servings}'),
                Text('Waktu: ${datadetailmasak!.results.times}'),
              ]))
        ],
      ),
    );

    // Widget bagian deskripsi.
    Widget bagianDeskripsi = Container(
      padding: const EdgeInsets.all(16),
      child: Text(
        datadetailmasak!.results.desc,
        style: const TextStyle(height: 1.5, fontSize: 14),
        softWrap: true,
        textAlign: TextAlign.justify,
      ),
    );

    // Bagian gambar.
    Widget bagianGambar = (datadetailmasak!.results.thumb != null)
        ? Image.network(
            datadetailmasak!.results.thumb,
            width: 600,
            fit: BoxFit.cover,
          )
        : Image.asset(
            'asset/gambar/Gambar-tidak-tersedia.png',
            width: 600,
            fit: BoxFit.cover,
          );

    // Bagian bahan-bahan
    List<String>? itemBahan = datadetailmasak!.results.ingredient;
    Widget bagianBahan = Column(
      children: [const Text('Bahan-bahan:', ),
        Column(
          children: itemBahan.map((bahan) {
            return ListTile(
              title: Text(
                bahan,
                style: const TextStyle(height: 1.5, fontSize: 14),
              ),
            );
          }).toList(),
        ),
      ],
    );

     // Bagian cara masak
    List<String>? itemTahap = datadetailmasak!.results.step;
    Widget bagianTahap = Column(
      children: [const Text('Cara masak:', ),
        Column(
          children: itemTahap.map((cara) {
            return ListTile(
              title: Text(
                cara,
                style: const TextStyle(height: 1.5, fontSize: 14),
              ),
            );
          }).toList(),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cara Masak'),
      ),
      body: ListView(
        children: <Widget>[
          // Bagian gambar
          bagianGambar,
          // Bagian judul
          bagianJudul,
          // Bagian deskripsi
          bagianDeskripsi,
          // Bagian bahan
          bagianBahan,
          // Bagian tahap
          bagianTahap,
        ],
      ),
    );
  }
}
