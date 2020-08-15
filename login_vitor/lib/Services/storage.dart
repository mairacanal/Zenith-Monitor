import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class StorageService{

  final File file;
  StorageService({ this.file });

  String fileURL;

  //final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://zenith-monitor-login.appspot.com');

  Future uploadFile(File file) async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child('UsersImages/${Path.basename(file.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.onComplete;
    print('File Uploaded');
    fileURL = await storageReference.getDownloadURL();

    return fileURL;
  }
}