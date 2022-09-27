class SavePostFailure implements Exception {
  final String message;

  const SavePostFailure({
    this.message = "An unknown exception occurred",
  });

  /// create an message
  /// froma firebase code
  factory SavePostFailure.fromCode(String code) {
    switch (code) {
      case "":
        return SavePostFailure();
      default:
        return SavePostFailure();
    }
  }
}
