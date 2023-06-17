class UserModel {
  final String uid;
  final String docId;
  String name;
  final String email;
  final String gender;
  String phoneNumber;

  UserModel({
    required this.docId,
    required this.uid,
    required this.name,
    required this.email,
    required this.gender,
    required this.phoneNumber,
  });

  // factory UserModel.fromMap(Map<String, dynamic> map) {
  //   return UserModel(
  //     uid: map['uid'] ?? '',
  //     name: map['name'] ?? '',
  //     email: map['email'] ?? '',
  //     gender: map['gender'] ?? '',
  //     phoneNumber: map['phoneNumber'] ?? '',
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     "uid": uid,
  //     "name": name,
  //     "email": email,
  //     "gender": gender,
  //     "phoneNumber": phoneNumber,
  //   };
  // }
}
