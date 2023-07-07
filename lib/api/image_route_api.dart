import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageRouteApi {
  static const _baseUrl = 'https://maps.googleapis.com/maps/api';
  static const _apiKey = 'AIzaSyBscF7jto3agk8vn5CjvSdNkMigQ2KMnh8';

  // 1 - Tj
  // 2 - Mikrotrans
  // 3 - MRT
  // 4 - KRL
  // 5 - LRT

  static Future<String> getPhoto(kode) async {
    // QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
    //     .collection('transport')
    //     .where('kode', isEqualTo: rute)
    //     .get();
    
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child('$kode.jpg'); 
    final imageUrl = await ref.getDownloadURL();

    return imageUrl;
  }

  static Future getList(id) async {
    QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
        .collection('transport')
        .where('id', isEqualTo: id)
        .get();
    List<Map<String, dynamic>> dataset = data.docs;
    return data.docs;
  }
}
