
abstract class Failure {
  final String? failType;
  final String message;

  Failure(this.message, this.failType);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  ServerFailure(super.message, super.failType);
}

class CacheFailure extends Failure {
  CacheFailure(super.message, super.failType);
}

class LocalProcessFailure extends Failure {
  LocalProcessFailure(super.message, super.failType);
}

class OtherFailure extends Failure {
  OtherFailure(super.message, super.failType);
}