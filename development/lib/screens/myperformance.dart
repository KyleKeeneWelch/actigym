// CIS099-2 Mobile Application Development.
// Assignment 2.
// ActiGym - Workout creator, tracker and logger.
// Kyle Keene - Welch, 2101940
// myperformance.dart

import 'package:flutter/material.dart';
import 'package:actigym/screens/advice.dart';
import 'package:actigym/screens/home.dart';
import 'package:actigym/screens/myworkouts.dart';
import 'package:actigym/components/sqlhelper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyPerformance extends StatefulWidget {
  final currentId;

  const MyPerformance({Key? key, this.currentId}) : super(key: key);

  @override
  State<MyPerformance> createState() => _MyPerformanceState();
}

class _MyPerformanceState extends State<MyPerformance> {
  int selectedIndex = 0;
  List<Map<String, dynamic>> accountSessions = [{}];
  List<Map<String, dynamic>> accountWorkouts = [{}];
  List<Map<String, dynamic>> workoutExercises = [{}];
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  void _updateData() async {
    data.clear();
    workoutExercises =
        await _getExercises(accountWorkouts[selectedIndex]['id']);
    for (int i = 0; i < workoutExercises.length; i++) {
      data.add(_ChartData(workoutExercises[i]['exerciseName'].toString(),
          double.parse(workoutExercises[i]['weight'].toString())));
    }
  }

  void _getWorkouts() async {
    accountWorkouts = await SQLHelper.getAccountWorkouts(widget.currentId);
  }

  Future<List<Map<String, dynamic>>> _getExercises(int workoutId) async {
    return await SQLHelper.getWorkoutExercises(workoutId.toString());
  }

  void _getSessions() async {
    accountSessions =
        await SQLHelper.getAccountSessions(widget.currentId.toString());
  }

  initState() {
    data = [];
    super.initState();
    _tooltip = TooltipBehavior(enable: true);
    _getSessions();
    _getWorkouts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Performance',
              style: Theme.of(context).textTheme.headline2),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        // Page Navigation
        drawer: Drawer(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            // Displays pages in listview as list tiles.
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  height: 100,
                  // Show logo.
                  child: Image.asset('assets/images/actigymlogo2.png'),
                  width: double.infinity,
                ),
                // Place divider between each element.
                Divider(),
                ListTile(
                    // Page name, associated icon, and description.
                    title: Text('Home',
                        style: Theme.of(context).textTheme.headline2),
                    trailing: Icon(Icons.home),
                    subtitle: Text(
                        'Allocate exercise days, change profile picture and links to other areas.'),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                    tileColor: Theme.of(context).scaffoldBackgroundColor,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomePage(currentId: widget.currentId)));
                    }),
                Divider(),
                ListTile(
                    title: Text('My Workouts',
                        style: Theme.of(context).textTheme.headline2),
                    trailing: Icon(Icons.assignment),
                    subtitle: Text(
                        'View your created workouts, create a new one or have a look at some pre-built.'),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                    tileColor: Theme.of(context).scaffoldBackgroundColor,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyWorkouts(currentId: widget.currentId)));
                    }),
                Divider(),
                ListTile(
                    title: Text('Advice',
                        style: Theme.of(context).textTheme.headline2),
                    trailing: Icon(Icons.info),
                    subtitle: Text(
                        'Read up on some of the latest advice and guidelines to get you started on your fitness journey.'),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                    tileColor: Theme.of(context).scaffoldBackgroundColor,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Advice(
                                    currentId: widget.currentId,
                                  )));
                    }),
                Divider(),
              ],
            )),
        body: SingleChildScrollView(
            child: Center(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  child: Column(children: [
                Container(
                    alignment: Alignment.center,
                    child: Text('Session Log',
                        style: Theme.of(context).textTheme.bodyText2)),
                SizedBox(height: 10),
                Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width - 50,
                    decoration: BoxDecoration(
                        color: Colors.grey[600],
                        border: Border.all(
                            width: 3,
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                              // Shows list view of list tiles that display session information.
                              child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            // Create as many list tiles as there are sessions logged.
                            itemCount: accountSessions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Material(
                                type: MaterialType.transparency,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                          // Show session number, workout name of session, date and time of session and duration.
                                          (index + 1).toString() +
                                              ": " +
                                              accountSessions[index]
                                                      ['workoutName']
                                                  .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3),
                                      subtitle: Text(
                                          'Date: ' +
                                              accountSessions[index]
                                                      ['workoutDate']
                                                  .toString() +
                                              '    Duration: ' +
                                              accountSessions[index]
                                                      ['workoutTime']
                                                  .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2),
                                      // Selected list tile is selected index.
                                      selected: index == selectedIndex,
                                      // Selected list tile colour is primary.
                                      selectedTileColor:
                                          Theme.of(context).primaryColor,
                                      // When tapped, set selected index as index of tapped list tile.
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                    ),
                                    Divider(),
                                  ],
                                ),
                              );
                            },
                          )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black45,
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  // When pressed, shows bottom sheet which prompts the user if they are sure they want to delete a session.
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                              height: 200,
                                              child: Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            'Are you sure you want to delete this session?',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2),
                                                        SizedBox(height: 10),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .black45,
                                                                      spreadRadius:
                                                                          2,
                                                                      blurRadius:
                                                                          7,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              3),
                                                                    ),
                                                                  ],
                                                                ),
                                                                child:
                                                                    ElevatedButton(
                                                                  // When pressed, deletes the selected session.
                                                                  onPressed:
                                                                      () {
                                                                    try {
                                                                      int deleteItem =
                                                                          accountSessions[selectedIndex]
                                                                              [
                                                                              'id'];
                                                                      SQLHelper
                                                                          .deleteSession(
                                                                              deleteItem);
                                                                      setState(
                                                                          () {
                                                                        // Gets sessions to update the interface.
                                                                        _getSessions();
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                      // Inform user.
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              const SnackBar(
                                                                        content: Text(
                                                                            'Delete Successful. Please refresh.',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                            )),
                                                                        backgroundColor:
                                                                            Colors.black,
                                                                      ));
                                                                    } catch (e) {
                                                                      Navigator.pop(
                                                                          context);
                                                                      // Inform user of error.
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              const SnackBar(
                                                                        content: Text(
                                                                            'Delete Unsuccessful',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                            )),
                                                                        backgroundColor:
                                                                            Colors.black,
                                                                      ));
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                      'Yes',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1),
                                                                  style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          Theme.of(context)
                                                                              .primaryColor,
                                                                      elevation:
                                                                          0),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 100,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .black45,
                                                                      spreadRadius:
                                                                          2,
                                                                      blurRadius:
                                                                          7,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              3),
                                                                    ),
                                                                  ],
                                                                ),
                                                                child:
                                                                    ElevatedButton(
                                                                  // When pressed, pops the navigator stack so the bottom sheet disappears.
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      'No',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1),
                                                                  style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          Theme.of(context)
                                                                              .primaryColor,
                                                                      elevation:
                                                                          0),
                                                                ),
                                                              ),
                                                            ])
                                                      ])));
                                        });
                                  },
                                  child: Text('Delete',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      elevation: 0),
                                ),
                              ),
                              Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black45,
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  // When pressed, gets the sessions and workouts so that the interface can update.
                                  onPressed: () {
                                    setState(() {
                                      _getSessions();
                                      _getWorkouts();
                                    });
                                  },
                                  child: Text('Refresh',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      elevation: 0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    alignment: Alignment.center,
                    child: Text('Workout Statistics',
                        style: Theme.of(context).textTheme.bodyText2)),
                SizedBox(height: 20),
                Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width - 50,
                    decoration: BoxDecoration(
                        color: Colors.grey[600],
                        border: Border.all(
                            width: 3,
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: Column(children: [
                      Expanded(
                        // List view to display list of workouts as list tiles.
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          // If account has no workouts, show no list tiles otherwise, show the amount of list tiles as workouts.
                          itemCount: accountWorkouts.isEmpty
                              ? 0
                              : accountWorkouts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Material(
                              type: MaterialType.transparency,
                              child: Column(
                                children: [
                                  ListTile(
                                    // Show workout name.
                                    title: Text(
                                        accountWorkouts[index]["workoutName"]
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                        textAlign: TextAlign.center),
                                    // Selected list tile index is selected index.
                                    selected: index == selectedIndex,
                                    // Selected list tile colour is primary.
                                    selectedTileColor:
                                        Theme.of(context).primaryColor,
                                    // When tapped, set selectedIndex as index of pressed list tile. Update the graph to reflect the data of the currently selected workout.
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                        _updateData();
                                      });
                                    },
                                  ),
                                  Divider(),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ])),
                SizedBox(height: 20),
                // Weight per exercise graph.
                SfCartesianChart(
                    title: ChartTitle(text: 'Weight per Exercise (kg)'),
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis:
                        NumericAxis(minimum: 0, maximum: 100, interval: 20),
                    tooltipBehavior: _tooltip,
                    series: <ChartSeries<_ChartData, String>>[
                      ColumnSeries<_ChartData, String>(
                          // Data source for graph is list named data. Maps the x and y values of the graph to x and y in chart data.
                          dataSource: data,
                          xValueMapper: (_ChartData data, _) => data.x,
                          yValueMapper: (_ChartData data, _) => data.y,
                          name: 'Weight per Exercise',
                          color: Color.fromRGBO(8, 142, 255, 1))
                    ])
              ]))),
        )));
  }
}

// Class that upon call to its constructor, sets the x and y values for the graph.
class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
