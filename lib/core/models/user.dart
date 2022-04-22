class User {
  final String username;

  final String name;

  final String surname;

  final String mail;

  final String birth;

  final String sex;

  final String language;

  bool isAdvertiser;

  User({
    required this.name,
    required this.surname,
    required this.mail,
    required this.birth,
    required this.sex,
    required this.language,
    this.isAdvertiser = false,
    required this.username,
  });

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        name = json['name'],
        surname = json['surname'],
        mail = json['mail'],
        birth = json['birth'],
        sex = json['sex'],
        language = json['language'],
        isAdvertiser = json['isAdvertiser'];
}
