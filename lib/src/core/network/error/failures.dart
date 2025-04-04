
abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

class LocalProcessFailure extends Failure {
  LocalProcessFailure(super.message);
}

class OtherFailure extends Failure {
  OtherFailure(super.message);
}