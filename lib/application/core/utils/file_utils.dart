import 'dart:io';

extension FileUtils on File {
  int get sizeInKb => lengthSync() ~/ 1024;
  double get sizeInMbDouble => lengthSync() / (1024 * 1024);
}
