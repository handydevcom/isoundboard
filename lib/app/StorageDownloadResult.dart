class StorageDownloadResult {
  bool isSuccess;

  String displayError;
  Exception exception;
  StackTrace stackTrace;

  StorageDownloadResult(
      this.isSuccess, this.displayError, this.exception, this.stackTrace);

  static StorageDownloadResult success() =>
      StorageDownloadResult(true, null, null, null);

  static StorageDownloadResult error(
          String displayError, Exception exception, StackTrace stackTrace) =>
      StorageDownloadResult(false, displayError, exception, stackTrace);
}
