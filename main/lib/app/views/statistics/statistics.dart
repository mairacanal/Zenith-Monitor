import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
          children: <Widget>[OverviewView(), PastMissions()],
        ),
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}

class OverviewView extends StatefulWidget {
  @override
  _OverviewViewState createState() => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView> {
  Stream<fakeStdPacket> fakeDataSend =
      Stream<fakeStdPacket>.periodic(Duration(seconds: 1), (int count) {
    return (fakeStdPacket(
        altitude: (4 * count * count - 8 * count), time: count));
  }).take(200);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ChartsCard(
            input: fakeDataSend,
            dataName: "Altitude",
          ),
        ],
      ),
    );
  }
}

class PastMissions extends StatefulWidget {
  @override
  _PastMissionsState createState() => _PastMissionsState();
}

class _PastMissionsState extends State<PastMissions> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ChartsCard extends StatefulWidget {
  final Stream<fakeStdPacket> input;
  final String dataName;

  ChartsCard({Key key, this.input, this.dataName}) : super(key: key);

  @override
  _ChartsCardState createState() => _ChartsCardState();
}

class _ChartsCardState extends State<ChartsCard> {
  List<fakeStdPacket> accumulator = [];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SpecificChartView(
                    dataName: widget.dataName,
                    accumulator: accumulator,
                  )),
        )
      },
      child: StreamBuilder(
          stream: widget.input,
          builder: (context, AsyncSnapshot<fakeStdPacket> snapshot) {
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              accumulator.add(snapshot.data);

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 300,
                  child: Card(
                    color: Colors.white,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                          title: Text(
                            // TODO: Makes more flexble (waits definition of data structure)
                            widget.dataName,
                            style: TextStyle(
                                fontFamily: "Open Sans",
                                color: Colors.black54,
                                fontSize: 18),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Text(
                              "${accumulator.last.altitude} km",
                              style: TextStyle(
                                  fontFamily: "Open Sans",
                                  color: Colors.black87,
                                  fontSize: 25),
                            ),
                          ),
                        ),
                        Charts(
                          data: accumulator,
                          height: 200,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              // TODO: CircularProgressIndicator
            }
          }),
    );
  }
}

class SpecificChartView extends StatefulWidget {
  String dataName;
  List<fakeStdPacket> accumulator;

  SpecificChartView({this.dataName, this.accumulator});

  @override
  _SpecificChartViewState createState() => _SpecificChartViewState();
}

class _SpecificChartViewState extends State<SpecificChartView> {
  Widget _buildCards(Color color, List<Widget> widgetTheme) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgetTheme,
          ),
        ),
      ),
    );
  }

  List<Widget> _actualValue() {
    return <Widget>[
      Container(
        height: 25,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "Altitude",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Container(
            height: 39,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                widget.accumulator.last.altitude.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.5),
            child: Container(
              height: 22,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  "km",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: widget.accumulator.last.altitude <
                    widget.accumulator[widget.accumulator.length - 2].altitude
                ? Icon(
                    Icons.arrow_drop_down,
                    size: 39,
                    color: Colors.redAccent[700],
                  )
                : Icon(
                    Icons.arrow_drop_up,
                    size: 39,
                    color: Colors.greenAccent[700],
                  ),
          )
        ]),
      ),
    ];
  }

  List<Widget> _comparison() {
    return <Widget>[
      Container(
        height: 25,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "Comparison",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool isLandscape = orientation == Orientation.landscape;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: isLandscape == false
            ? AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  widget.dataName,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Open Sans",
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal),
                ),
                centerTitle: true,
              )
            : null,
        body: OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white30,
                  ),
                  child: Charts(
                    data: widget.accumulator,
                    height: 400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          flex: 3,
                          child: _buildCards(Colors.grey[900], _actualValue())),
                      Expanded(
                          flex: 2,
                          child: _buildCards(Colors.grey[800], _comparison()))
                    ],
                  ),
                )
              ],
            );
          } else {
            return Expanded(
              child: Container(
                child: Charts(
                  data: widget.accumulator,
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}

class Charts extends StatefulWidget {
  List<fakeStdPacket> data;
  double height;

  Charts({this.data, this.height});

  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<fakeStdPacket, int>> series = [
      charts.Series(
        id: "Altitude",
        data: widget.data,
        // TODO: Makes more flexble (waits definition of data structure)
        domainFn: (fakeStdPacket series, _) => series.time,
        measureFn: (fakeStdPacket series, _) => series.altitude,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.grey),
      )
    ];

    return Padding(
      padding:
          const EdgeInsets.only(top: 0, bottom: 8.0, right: 8.0, left: 8.0),
      child: Container(
        height: widget.height,
        child: new charts.LineChart(series,
            animate: false,
            defaultRenderer:
                new charts.LineRendererConfig(includePoints: false)),
      ),
    );
  }
}
