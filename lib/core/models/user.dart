class User {
  final String username;

  final String name;

  final String surname;

  final String mail;

  final String dateOfBirth;

  final String sex;

  final String language;

  bool isAdvertiser;

  User({
    required this.name,
    required this.surname,
    required this.mail,
    required this.dateOfBirth,
    required this.sex,
    required this.language,
    this.isAdvertiser = false,
    required this.username,
  });
}
