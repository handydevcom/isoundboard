import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:isoundboard/app/StorageDownloadResult.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getFilePath(String path) async {
  final Directory systemDir = Platform.isIOS
      ? await getTemporaryDirectory()
      : await getApplicationDocumentsDirectory();
  return '${systemDir.path}$path';
}

Future<bool> isFileExist(String path) async {
  String filePath = await getFilePath(path);
  bool result = await File(filePath).exists();
  return result;
}

Future<void> deleteFileIfExist(String localPath) async {
  File file = File(localPath);
  if (await file.exists()) {
    await file.delete(recursive: true);
  }
}

Future<StorageDownloadResult> downloadFile(
    String filePath, String storagePath) async {
  final String localPath = await getFilePath(filePath);

  try {
    StorageReference ref =
        await FirebaseStorage.instance.getReferenceFromUrl(storagePath);
    final String url = await ref.getDownloadURL();

    await deleteFileIfExist(localPath);

    final File file = File(localPath);
    await file.create(recursive: true);

    final StorageFileDownloadTask task = ref.writeToFile(file);
    await task.future;

    final String name = await ref.getName();
    final String bucket = await ref.getBucket();
    final String path = await ref.getPath();

    print('Success!\n Downloaded $name \n from url: $url @ bucket: $bucket\n '
        'at path: $path \n');
    return StorageDownloadResult.success();
  } catch (exception, stackTrace) {
    deleteFileIfExist(localPath);
    return StorageDownloadResult.error(
        exception.message, exception, stackTrace);
  }
}
