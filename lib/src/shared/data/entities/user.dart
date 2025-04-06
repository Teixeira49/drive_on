class User {
  int userId;
  String userEmail;
  String userPassword;
  String userName;
  String userType;
  String? userDepartment;

  User(
      {required this.userId,
      required this.userEmail,
      required this.userPassword,
      required this.userName,
      required this.userType,
      this.userDepartment});
}
