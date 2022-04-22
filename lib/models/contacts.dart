import 'dart:convert';

class Contact {
  int? id;
  String? name;
  String? contact;
  
  Contact({this.id,this.contact,this.name});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    result.addAll({'name': name});
    result.addAll({'contact': contact});
  
    return result;
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      contact: map['contact'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) => Contact.fromMap(json.decode(source));
}
