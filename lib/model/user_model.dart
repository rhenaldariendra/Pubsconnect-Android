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

}
