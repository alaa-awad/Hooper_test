import 'package:equatable/equatable.dart';

class Email extends Equatable {
  final int id;
  final String title;
  final String description;
  final String imgLink;
  final String email;

  const Email({
    required this.id,
    required this.title,
    required this.description,
    required this.imgLink,
    required this.email,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, description, imgLink, email];

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        imgLink: json["img_link"],
        email: json["email"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "img_link": imgLink,
      "email": email,
    };
  }
}
