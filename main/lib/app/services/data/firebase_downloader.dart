import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zenith_monitor/app/models/data_packet.dart';

class FirebaseReceiver {
  var _statusStream = StreamController<int>();
  CollectionReference _subCollectionReference;
  var _dataStream = StreamController<TargetTrajectory>();

  Future<void> init() async {
    _statusStream.add(1);
    _subCollectionReference = FirebaseFirestore.instance
        .collection("missoes")
        .doc("test-launch")
        .collection("logs");

    _statusStream.add(1);

    _subCollectionReference
        .orderBy("id")
        .snapshots(includeMetadataChanges: false)
        .listen((event) {
      for (var change in event.docChanges) {
        TargetTrajectory packet = parser(change.doc);
        _dataStream.add(packet);
      }
    });
    _statusStream.add(10);
  }

  TargetTrajectory parser(DocumentSnapshot doc) {
    // if(...) //TODO: Check if is valid Packet
    return TargetTrajectory(
      position: LatLng(doc.data()["lat"], doc.data()["lng"]),
      altitude: doc.data()["alt"],
      speed: doc.data()["vel"],
      id: doc.data()["id"],
    );
  }

  Stream<TargetTrajectory> receive() {
    return _dataStream.stream;
  }

  Stream<int> status() {
    return _statusStream.stream;
  }

  void dispose() {
    _statusStream.close();
    _dataStream.close();
  }
}
