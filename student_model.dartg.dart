class StudentModel {
  final String uid;
  final String registrationCode;
  final String fullName;
  final String email;
  final String? certificateUrl;

  StudentModel({
    required this.uid,
    required this.registrationCode,
    required this.fullName,
    required this.email,
    this.certificateUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'registrationCode': registrationCode,
      'fullName': fullName,
      'email': email,
      'certificateUrl': certificateUrl,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map, String docId) {
    return StudentModel(
      uid: docId,
      registrationCode: map['registrationCode'] ?? '2116',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      certificateUrl: map['certificateUrl'],
    );
  }
}