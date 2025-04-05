import 'package:minimal_flutter_app/utils/constants/enums.dart';
import 'package:minimal_flutter_app/utils/formatters/formatter.dart';

class UserModel {
  final String? id;
  String firstName;
  String lastName;
  String userName;
  String email;
  String phoneNumber;
  String profilePicture;
  AppRole role;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel(
      {this.id,
      required this.email,
      this.firstName = '',
      this.lastName = '',
      this.userName = '',
      this.phoneNumber = '',
      this.profilePicture = '',
      this.role = AppRole.user,
      this.createdAt,
      this.updatedAt});

  String getFullName() => '$firstName $lastName';
  String getFormattedDate() => Formatter.formatDate(createdAt);
  String getFormattedUpdatedDate() => Formatter.formatDate(updatedAt);
  String getFormattedPhoneNumber() => Formatter.formatPhoneNumber(phoneNumber);

  static UserModel empty() => UserModel(email: '');

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': userName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Role': role.name.toString(),
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt = DateTime.now()
    };
  }

  // factory UserModel.fromSnapshot(DocumentSanpshot<Map<String, dynamic>> document){
  //   if document.data
  // }
}
