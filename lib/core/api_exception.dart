class ApiException implements Exception {
  final String message;
  final int? code;

  ApiException({required this.message, this.code});

  @override
  String toString() {
    if (code != null) {
      return 'ApiException (code: $code): $message';
    }
    return 'ApiException: $message';
  }
}
