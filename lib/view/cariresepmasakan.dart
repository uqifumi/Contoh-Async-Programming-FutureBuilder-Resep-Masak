import 'package:async_programming_futurebuilder_resepmasak/model/resep.dart';
import 'package:async_programming_futurebuilder_resepmasak/view/detailmasak.dart';
import 'package:async_programming_futurebuilder_resepmasak/viewmodel/fetchdatamasak.dart';
import 'package:flutter/material.dart';

class CariResepMasakah extends StatefulWidget {
  const CariResepMasakah({super.key});

  @override
  State<CariResepMasakah> createState() => _CariResepMasakahState();
}

class _CariResepMasakahState extends State<CariResepMasakah> {
  List<Result>? daftarHasilPencarianResep;
  late List<Result> listHasilCari;
  TextEditingController controllerCari = TextEditingController();
  late String katakunci;
  late bool prosesCari;
  bool adaHasil = false;
  late Widget dialogProgress;

  @override
  Widget build(BuildContext context) {
    // Bagian field pencarian.
    Widget fieldPencarian = Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onSubmitted: (value) {
          setState(() {
            prosesCari = true;
            katakunci = value;
          });
          controllerCari.clear();
        },
        controller: controllerCari,
        textInputAction: TextInputAction.search,
        decoration: const InputDecoration(
            hintText: 'Masukkan nama resep',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
            )),
      ),
    );

    // Bagian logo pencarian.
    Widget logoCari = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.search,
          size: 40,
          color: Colors.grey,
        ),
        Text(
          'Masak apa',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        )
      ],
    );

    // Bagian futurebuilder.
    Widget tampilHasilCari = FutureBuilder<List<Result>>(
      future: fetchCariResep(katakunci),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Gagal ambil data...'),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.warning,
                size: 40,
                color: Colors.grey,
              ),
              Text(
                'Tidak ditemukan',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              )
            ],
          ));
        }
        return ListMasak(result: snapshot.data);
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Resep Masakan'),
      ),
      body: Column(
        children: [
          fieldPencarian,
          Expanded(child: (prosesCari == true) ? tampilHasilCari : logoCari),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    katakunci = '';
    prosesCari = false;
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
