import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String id;
  String name;
  String email;
  String contact;
  DateTime dob;
  String profilePictureUrl;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.contact,
    required this.dob,
    required this.profilePictureUrl,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      contact: json['contact'] as String? ?? '',
      dob: (json['dob'] as Timestamp).toDate(),   
      profilePictureUrl: json['profilePictureUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'contact': contact,
      'dob': Timestamp.fromDate(dob),   
      'profilePictureUrl': profilePictureUrl,
    };
  }
}