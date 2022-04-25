import 'dart:convert';

class Contact {
  int? id;
  String name;
  String contact;
  
  Contact({this.id, required this.contact, required this.name});

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    id:json['id'],
    name: json['name'],
    contact: json['contact'],
    );

  Map<String, dynamic> toJson() => {
      'id':id,
      'name':name,
      'contact': contact,
  };
}