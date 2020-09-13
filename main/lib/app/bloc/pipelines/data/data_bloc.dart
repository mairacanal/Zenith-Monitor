import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zenith_monitor/app/services/mock/firebase_receiver.dart';
import 'package:zenith_monitor/app/services/mock/usb.dart';
import 'package:zenith_monitor/app/models/data_packet.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final FirebaseReceiver dataReceiver;
  final UsbManager usbManager;
  StreamSubscription _src;
  DataBloc(this.dataReceiver, this.usbManager) : super(DataInitial());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is DataStart) {
      _src?.cancel();
      _src = dataReceiver.receive().listen((packet) {
        add(DataNewPacket(packet));
      });
    }
    if (event is UsbStart) {
      _src?.cancel();
      await usbManager.init();
      _src = usbManager.receive().listen((packet) {
        add(DataNewPacket(packet));
      });
    }
    if (event is DataNewPacket) {
      yield DataUpdated(event.packet);
    }
  }

  void dispose() {
    _src?.cancel();
  }
}
