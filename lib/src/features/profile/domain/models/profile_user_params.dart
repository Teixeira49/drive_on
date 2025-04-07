
class ProfileUserParams {

  ProfileUserParams({required this.id});

  final int id;

  int getUserId(){
    return id;
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': id,
    };
  }

}