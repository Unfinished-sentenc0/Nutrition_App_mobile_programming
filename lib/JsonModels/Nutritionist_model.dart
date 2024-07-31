class NutritionistModel {
  final String username;
  final String password;
  final String email;
  final String qualificationImage;
  final String description;
  final int isApproved;

  NutritionistModel({
    required this.username,
    required this.password,
    required this.email,
    required this.qualificationImage,
    required this.description,
    required this.isApproved,
  });

  factory NutritionistModel.fromMap(Map<String, dynamic> map) {
    return NutritionistModel(
      username: map['username'],
      password: map['password'],
      email: map['email'],
      qualificationImage: map['qualificationImage'],
      description: map['description'],
      isApproved: map['isApproved'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'qualificationImage': qualificationImage,
      'description': description,
      'isApproved': isApproved,
    };
  }
}
