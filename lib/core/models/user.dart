
class User {
  User({
    required this.uID,
    required this.name,
    required this.email,
    required this.isAdmin,
  });
  final String uID;
  final String name;
  final String email;
  final bool isAdmin;

  factory User.fromMap(String uid, Map<String, dynamic> data) {
    return User(
      uID: uid,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      isAdmin: data['isAdmin'] ?? false,
    );
  }
}
