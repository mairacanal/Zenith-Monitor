import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class fakeStdPacket {
  int altitude;
  int time;

  fakeStdPacket({this.altitude, this.time});
}

class CurrentMission extends StatelessWidget {
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

class ChartsCard extends StatelessWidget {
  final Stream<fakeStdPacket> input;
  final String dataName;

  ChartsCard({Key key, this.input, this.dataName}) : super(key: key);

  List<fakeStdPacket> accumulator = [];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: StreamBuilder(
          stream: input,
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
                            dataName,
                            style: TextStyle(
                                fontFamily: "Open Sans",
                                color: Colors.black54,
                                fontSize: 18),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${accumulator.last.altitude} km",
                                  style: TextStyle(
                                      fontFamily: "Open Sans",
                                      color: Colors.black87,
                                      fontSize: 25),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: accumulator.last.altitude <
                                          accumulator[accumulator.length - 2]
                                              .altitude
                                      ? Icon(
                                          Icons.arrow_drop_down,
                                          size: 25,
                                          color: Colors.redAccent[700],
                                        )
                                      : Icon(
                                          Icons.arrow_drop_up,
                                          size: 25,
                                          color: Colors.greenAccent[700],
                                        ),
                                )
                              ],
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

class Charts extends StatelessWidget {
  List<fakeStdPacket> data;
  double height;

  Charts({this.data, this.height});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<fakeStdPacket, int>> series = [
      charts.Series(
        id: "Altitude",
        data: data,
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
        height: height,
        child: new charts.LineChart(series,
            animate: false,
            defaultRenderer:
                new charts.LineRendererConfig(includePoints: false)),
      ),
    );
  }
}
