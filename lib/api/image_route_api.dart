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
    QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
        .collection('transport')
        .where('id', isEqualTo: id)
        .get();
    List<Map<String, dynamic>> dataset = [];
    int length = data.docs.length;

    for (int i = 0; i < length; i++) {
      dataset.add(data.docs[i].data());
    }

    return dataset;
  }
}
