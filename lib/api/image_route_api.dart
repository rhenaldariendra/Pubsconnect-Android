import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageRouteApi {
  // static const _baseUrl = 'https://maps.googleapis.com/maps/api';
  // static const _apiKey = 'AIzaSyBscF7jto3agk8vn5CjvSdNkMigQ2KMnh8';
  // 1 - Tj
  // 2 - Mikrotrans
  // 3 - MRT
  // 4 - KRL
  // 5 - LRT

  static Future<String> getPhoto(id, kode) async {
    final storage = FirebaseStorage.instance;
    String basePath = '';

    switch (id) {
      case 1:
        basePath = 'transjakarta/';
        break;
      case 2:
        basePath = 'mrt/';
        break;
      case 3:
        basePath = 'mikrotrans/';
        break;
      case 4:
        basePath = 'lrt/';
        break;
      case 5:
        basePath = 'krl/';
        break;
      default:
        break;
    }

    final ref = storage.ref().child('$basePath$kode.jpg');
    final imageUrl = await ref.getDownloadURL();

    return imageUrl;
  }

  static Future<List<Map<String, dynamic>>> getList(id) async {
    // QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
    //     .collection('transport')
    //     .where('id', isEqualTo: id)
    //     .get();
    QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
        .collection('transport')
        // .orderBy('kode', descending: false)
        .where('id', isEqualTo: id)
        .orderBy("kode", descending: false)
        .get();
    List<Map<String, dynamic>> dataset = [];
    int length = data.docs.length;

    for (int i = 0; i < length; i++) {
      dataset.add(data.docs[i].data());
    }

    // dataset.sort((a, b) {
    //   final String idA = a['kode'];
    //   final String idB = b['kode'];

    //   final RegExp numRegex = RegExp(r'\d+');
    //   final RegExp alphaRegex = RegExp(r'[a-zA-Z]+');

    //   final int numA = int.parse(numRegex.stringMatch(idA ?? '') ?? '');
    //   final int numB = int.parse(numRegex.stringMatch(idB ?? '') ?? '');

    //   final String alphaA = alphaRegex.stringMatch(idA ?? '') ?? '';
    //   final String alphaB = alphaRegex.stringMatch(idB ?? '') ?? '';

    //   if (numA == numB) {
    //     return alphaA.compareTo(alphaB);
    //   } else {
    //     return numA.compareTo(numB);
    //   }
    // });

    // dataset.forEach((map) {
    //   print("id: ${map['kode']}");
    // });

    return dataset;
  }
}
