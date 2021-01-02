import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String photoUrl;

  User({
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phoneNumber,
    this.photoUrl,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      password: map['password'],
      phoneNumber: map['phoneNumber'],
      photoUrl: map['photoUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
    };
  }

  @override
  List<Object> get props => [firstName, lastName, email, password, phoneNumber];
}
