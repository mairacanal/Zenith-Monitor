import 'package:flutter/material.dart';

import 'package:zenith_monitor/app/views/statistics/tabbar views/missions.dart';

class fakeStdPacket {
  int altitude;
  int time;

  fakeStdPacket({this.altitude, this.time});
}

class StatisticsView extends StatefulWidget {
  @override
  _StatisticsViewState createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Statistics",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Open Sans",
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal),
          ),
          //automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          bottom: TabBar(indicatorColor: Colors.white, tabs: <Widget>[
            Tab(text: "CURRENT MISSION"),
            Tab(text: "PAST MISSIONS")
          ]),
        ),
        body: TabBarView(
          children: <Widget>[CurrentMission(), PastMissions()],
        ),
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}
