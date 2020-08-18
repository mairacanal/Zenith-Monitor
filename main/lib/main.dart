import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/app/bloc/data_bloc/data_bloc.dart';
import 'package:zenith_monitor/app/bloc/location_bloc/location_bloc.dart';
import 'package:zenith_monitor/app/bloc/login_bloc/login_bloc.dart';
import 'package:zenith_monitor/app/bloc/map_bloc/map_bloc.dart';
import 'package:zenith_monitor/app/bloc/status_bloc/status_bloc.dart';
import 'package:zenith_monitor/app/bloc/terminal_bloc/terminal_bloc.dart';
import 'package:zenith_monitor/app/components/firebase_authentication.dart';
import 'package:zenith_monitor/app/components/firebase_receiver.dart';
import 'package:zenith_monitor/app/components/firebase_uploader.dart';
import 'package:zenith_monitor/app/components/local_database.dart';
import 'package:zenith_monitor/app/components/usb.dart';
import 'package:zenith_monitor/app/components/location.dart';
import 'package:zenith_monitor/app/bloc/logger_bloc/logger_bloc.dart';
import 'package:zenith_monitor/app/views/loginPage/login.dart';

<<<<<<< HEAD
// import 'app/views/loginPage/fakeLoginPage.dart';
import 'app/views/mainScreen/widgets/mainScreenWidget.dart';
=======
import 'app/views/loginPage/fakeLoginPage.dart';
import 'app/views/mainScreen/widgets/main_screen_widget.dart';
>>>>>>> origin/master
import 'app/views/terminal/terminal.dart';

void main() {
  runApp(Application());
}

// just in case
class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //eventually this will be the only provider in the file
        BlocProvider(
          create: (context) => LoginBloc(
            AuthManager(),
          ),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => DataBloc(
            FirebaseReceiver(),
            UsbManager(),
          ),
        ),
        BlocProvider(
          create: (context) => LocationBloc(LocationManager()),
        ),
        BlocProvider(
          create: (context) => MapBloc(
            BlocProvider.of<LocationBloc>(context),
            BlocProvider.of<DataBloc>(context),
          ),
        ),
        BlocProvider(
          create: (context) => LoggerBloc(
            BlocProvider.of<DataBloc>(context),
            FirebaseUploader(),
            LocalDatabase(),
            // BlocProvider.of<LoginBloc>(context).authManager,
          ),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => StatusBloc(
            BlocProvider.of<DataBloc>(context).dataReceiver,
            BlocProvider.of<LoggerBloc>(context).dataUploader,
            BlocProvider.of<DataBloc>(context).usbManager,
          ),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => TerminalBloc(
            BlocProvider.of<DataBloc>(context),
            BlocProvider.of<StatusBloc>(context),
          ),
        ),
      ],
      child: MaterialApp(
        showPerformanceOverlay: false, // shows fps
        debugShowCheckedModeBanner: false,
        title: 'Main Screen',
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => Login(),
          '/map': (context) => MainScreen(),
          '/terminal': (context) => TerminalView2(),
        },
      ),
    );
  }
}
