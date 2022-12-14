# Contoh Asynchronous Programming Flutter (FutureBuilder)
Program yang menampilkan resep makanan untuk mendemonstrasikan asynchronous programming dengan widget future builder pada framework flutter. Agar mudah dipahami dan dikembangkan, program dibuat menjadi empat bagian yang dijadikan dalam folder yaitu model, view, dan view model seperti yang terlihat pada gambar berikut:
<br><br><img src="https://github.com/uqifumi/Contoh-Async-Programming-FutureBuilder-Resep-Masak/blob/master/dokumentasi/Gambar%2001.png" width="150"/><br>
## Model
Dari gambar terlihat bahwa bagian model terdiri dari dua file yaitu resep.dart dan detailresep.dart yang merupakan PODO (plain old dart objek) digunakan untuk membentuk format objek dari data json yang diperoleh dari server. File resep.dart digunakan untuk data json daftar resep masakan dan detailresep.dart untuk detailnya. Dari dokumentasi API JSON nya diketahui bahwa untuk data daftar masakan dan detailnya didapatkan dari JSON yang berbeda sehingga diperlukan request dengan url endpoint sendiri-sendiri. 
## View
Di bagian view digunakan untuk menampilkan data daftar resep masakan dan detailnya dengan layout tampilan yang kode programnya terdapat dalam file home.dart untuk daftar resep masakan dan detailmasak.dart untuk detailnya. Tampilan layout yang dimaksud seperti gambar berikut:
<br><br><img src="https://github.com/uqifumi/Contoh-Async-Programming-FutureBuilder-Resep-Masak/blob/master/dokumentasi/gambar%2002.png" width="250"/><br>
<br><img src="https://github.com/uqifumi/Contoh-Async-Programming-FutureBuilder-Resep-Masak/blob/master/dokumentasi/Gambar%2003.png" width="250"/><br>
Pada bagian view ini juga widget futurebuilder diterapkan.
## View Model
Sedangkan bagian viewmodel berisi mekanisme bagaimana request data json ke server dan response dari server diterima lewat internet. Dalam proses ini digunakan method get dari paket http dengan parameter url endpoint. Dalam folder ini terdapat dua file yaitu fetchdatamasak.dart untuk request daftar resep masakan dan fetchdetailmasak.dart untuk request detailnya.
## Asset
Dalam program ini disertai juga dengan gambar yang disimpan dalam folder asset/gambar/Gambar-tidak-tersedia.png untuk menangani runtime error yang diakibatkan oleh kegagalan methode Image.network() menampilkan gambar masakan pada detail resep masakan yang disebabkan oleh key thumb yang value nya null (seharusnya berisi url gambar). Adapun gambar folder yang dimaksud sebagai berikut:
<br><br><img src="https://github.com/uqifumi/Contoh-Async-Programming-FutureBuilder-Resep-Masak/blob/master/dokumentasi/Gambar%2004.png" width="250"/><br><br>
Dengan demikian jika terjadi value null pada key thumb maka gambar yang ditampilkan adalah gambar yang tersimpan dalam folder asset menggunakan method Image.asset(). Gambar tersebut adalah sebagai berikut:
<br><br><img src="https://github.com/uqifumi/Contoh-Async-Programming-FutureBuilder-Resep-Masak/blob/master/dokumentasi/Gambar%2005.png" width="300"/><br>
## Paket yang Digunakan
http: ^0.13.5 (https://pub.dev/packages/http)<br>
## Referensi 
Dokumentasi JSON API dan URL endpoint yang digunakan di program dapat diakses di:
https://github.com/tomorisakura/unofficial-masakapahariini-api
# Update (19 November 2022)
Dalam program ini ada update sebagai berikut:
# Navigasi Drawer
Navigasi drawer digunakan untuk navigasi ke bagian screen utama (home) dan screen pencarian resep makanan. Adapun tampilannya adalah sebagai berikut:<br>
- Navigasi Drawer
<br><img src="https://github.com/uqifumi/Contoh-Async-Programming-FutureBuilder-Resep-Masak/blob/master/dokumentasi/Update%2001.png" width="250"/><br>
# Screen(Halaman) Pencarian
Halaman pencarian terdiri dari widget texfield untuk memasukkan kata kunci resep masakan. Selain itu terdapat widget listview untuk menampilkan hasil pencarian sebagai keluaran dari proses pencarian yang dipanggil properti future dalam widget futurebuilder. Berikut tampilan halaman pencarian yang dimaksud:
<br>
- Halaman Pencarian
<br><img src="https://github.com/uqifumi/Contoh-Async-Programming-FutureBuilder-Resep-Masak/blob/master/dokumentasi/Update%2002.png" width="250"/><br><br>
- Input Kata kunci
<br><img src="https://github.com/uqifumi/Contoh-Async-Programming-FutureBuilder-Resep-Masak/blob/master/dokumentasi/Update%2003.png" width="250"/><br><br>
- Hasil Pencarian
<br><img src="https://github.com/uqifumi/Contoh-Async-Programming-FutureBuilder-Resep-Masak/blob/master/dokumentasi/Update%2004.png" width="250"/><br><br>
- Detail Resep Masakan
<br><img src="https://github.com/uqifumi/Contoh-Async-Programming-FutureBuilder-Resep-Masak/blob/master/dokumentasi/Update%2006.png" width="250"/><br>
# Update (27 November 2022)
## Perbaikan Bug
- Pada saat pertama kali screen pencarian digunakan untuk pencarian resep masakan, circular progress indicator tampil pada saat dijalankan request pengiriman kata kunci ke server untuk pencarian resep masakan. Ketika server merespon dan mengirimkan data hasil pencarian, maka data berhasil ditampilkan dengan widget listview di program/aplikasi. Namun pada pencarian kedua dan selanjutnya, circular progress indicator tidak tampil pada saat request ke server dijalankan dan screen tetap menampilkan list hasil pencarian resep sebelumnya. Walaupun request tetap dijalankan dan data respon dari server ditampilkan di widget listview menggantikan hasil pencarian sebelumnya.
- Kendala ini berakibat pada pengguna dapat menghentikan (interupt) proses pencarian pada saat request dan menunggu respon server dengan tap salah satu resep masakan di list hasil pencarian resep masakan sebelumnya yang berimbas ke request data detail resep masakannya ke server.
## Penambahan Fungsi
- Pada screen home tidak hanya menampilkan sepuluh resep masakan. Dengan mekanisme infinite scroll pagination/lazy loading, maka akan ditampilkan sepuluh resep masakan berikutnya jika scroll telah mencapai data resep masakan paling bawah (terakhir).

# async_programming_futurebuilder_resepmasak

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:
