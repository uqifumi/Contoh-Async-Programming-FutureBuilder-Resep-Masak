import 'package:flutter/material.dart';
import 'package:async_programming_futurebuilder_resepmasak/view/detailmasak.dart';
import 'package:async_programming_futurebuilder_resepmasak/viewmodel/fetchdatamasak.dart';
import 'package:async_programming_futurebuilder_resepmasak/model/resep.dart';
import 'package:async_programming_futurebuilder_resepmasak/view/navigasidrawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masak Apa'),
      ),
      drawer: const MenuDrawer(),
      body: FutureBuilder<List<Result>>(
          future: fetchMasakPage(1),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              const Center(
                child: Text('Gagal ambil data...'),
              );
            }
            return snapshot.hasData
                ? ListMasak(masak: snapshot.data)
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class ListMasak extends StatefulWidget {
  const ListMasak({Key? key, required this.masak}) : super(key: key);
  final List<Result>? masak;

  @override
  State<ListMasak> createState() => _ListMasakState();
}

class _ListMasakState extends State<ListMasak> {
  ScrollController scrollController = ScrollController();
  List<Result>? result;
  int currentPage = 1;

  bool onnotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              25) {
        fetchMasakPage(currentPage + 1).then((value) {
          currentPage = currentPage + 1;
          setState(() {
            result?.addAll(value);
          });
        });
      }
    }
    return true;
  }

  @override
  void initState() {
    result = widget.masak;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: onnotification,
      child: Center(
        child: ListView.builder(
          itemCount: result!.length,
          controller: scrollController,
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
      ),
    );
  }
}
