class User {
  final int? id;
  final String username;
  final String password;
  final String email; // New email field

  User({
    this.id,
    required this.username,
    required this.password,
    required this.email, // Include email in constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email, // Add email to the map
    };
  }

  // Factory constructor to create a User object from a map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      username: map['username'] as String,
      password: map['password'] as String,
      email: map['email'] as String, // Extract email from the map
    );
  }
}
