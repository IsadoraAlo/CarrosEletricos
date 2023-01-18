class User {
  int? id;
  String username;
  String name;
  String email;
  String password;

  User({
    this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.password,
  });
}
