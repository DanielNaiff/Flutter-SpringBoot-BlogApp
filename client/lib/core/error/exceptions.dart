class ServerException implements Exception {
  final String message;

  ServerException([this.message = 'Erro desconhecido no servidor']);

  @override
  String toString() => 'ServerException: $message';
}
