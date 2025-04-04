import '../../data/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required super.userId,
      required super.userEmail,
      required super.userPassword,
      required super.userName,
      required super.userType,
      super.userDepartment});

  factory UserModel.fromJson(json) {
    return UserModel(
      userId: json['user']['id'],
      userEmail: json['user']['id'],
      userPassword: json['user']['id'],
      userName: json['user']['id'],
      userType: json['user']['id'],
      userDepartment: json['user']['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'userPassword': userPassword,
      'userName': userName,
      'userType': userType,
      'userDepartment': userDepartment,
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      userId: user.userId,
      userEmail: user.userEmail,
      userPassword: user.userPassword,
      userName: user.userPassword,
      userType: user.userType,
      userDepartment: user.userDepartment,
    );
  }
}
