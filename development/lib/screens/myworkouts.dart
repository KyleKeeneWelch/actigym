// CIS099-2 Mobile Application Development.
// Assignment 2.
// ActiGym - Workout creator, tracker and logger.
// Kyle Keene - Welch, 2101940
// myworkouts.dart

import 'package:actigym/screens/performworkout.dart';
import 'package:flutter/material.dart';
import 'package:actigym/screens/advice.dart';
import 'package:actigym/screens/myperformance.dart';
import 'package:actigym/screens/home.dart';
import 'package:actigym/screens/modifyworkout.dart';
import 'package:actigym/components/sqlhelper.dart';

class MyWorkouts extends StatefulWidget {
  final currentId;

  const MyWorkouts({Key? key, this.currentId}) : super(key: key);

  @override
  State<MyWorkouts> createState() => _MyWorkoutsState();
}

class _MyWorkoutsState extends State<MyWorkouts> {
  List<Map<String, dynamic>> accountWorkouts = [{}];
  List<Map<String, dynamic>> workoutExercises = [{}];
  List<Map<String, dynamic>> preBuiltWorkouts = [{}];
  final TextEditingController workoutNamectrl = TextEditingController();
  final TextEditingController workoutNumExercisectrl = TextEditingController();
  final TextEditingController testctrl = TextEditingController();
  int selectedIndex = 0;
  int pbSelectedIndex = 0;
  bool createdPBWorkouts = false;

  // Gets the exercises for the currently selected workout.
  void _getExercises() async {
    workoutExercises = await SQLHelper.getWorkoutExercises(
        accountWorkouts[selectedIndex]['id'].toString());
  }

  // Gets the workouts for the workout list.
  void _getWorkouts() async {
    accountWorkouts = await SQLHelper.getAccountWorkouts(widget.currentId);
  }

  // Gets the pre-built workouts for the pre-built workout list.
  Future<void> _getPBWorkouts() async {
    preBuiltWorkouts = await SQLHelper.getAccountWorkouts('9999');
  }

  // Creates exercises for the pre-built workouts upon initialization.
  void _createPBExercises() async {
    await _getPBWorkouts();
    await SQLHelper.createExercise(
        preBuiltWorkouts[0]['id'].toString(), 'Bench Press', 50, 3, 0, '');
    await SQLHelper.createExercise(
        preBuiltWorkouts[0]['id'].toString(), 'Squats', 50, 3, 0, '');
  }

  // Creates pre-built workouts upon initialization.
  void _createPBWorkouts() async {
    // Only creates once.
    if (createdPBWorkouts == false) {
      setState(() {
        createdPBWorkouts = true;
      });
      await SQLHelper.createWorkout('9999', 'Full Body Workout', 5);
      // Creates exercises once workouts have been created.
      _createPBExercises();
    }
  }

  // Upon intialization of the page, create pre-built workouts and get the user's workouts and exercises.
  @override
  initState() {
    super.initState();
    _createPBWorkouts();
    _getWorkouts();
    _getExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('My Workouts', style: Theme.of(context).textTheme.headline2),
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
                    title: Text('My Performance',
                        style: Theme.of(context).textTheme.headline2),
                    trailing: Icon(Icons.fitness_center),
                    subtitle: Text(
                        'Analyse your recent sessions and measure your progress.'),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                    tileColor: Theme.of(context).scaffoldBackgroundColor,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyPerformance(currentId: widget.currentId)));
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
                child: Container(
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(children: [
                          Row(children: [
                            Container(
                              width: 175,
                              child: Text('My Workouts',
                                  style: Theme.of(context).textTheme.bodyText2,
                                  textAlign: TextAlign.center),
                            ),
                            SizedBox(width: 20),
                            Container(
                              width: 175,
                              child: Text('Exercises',
                                  style: Theme.of(context).textTheme.bodyText2,
                                  textAlign: TextAlign.center),
                            ),
                          ]),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 450,
                                  width: 175,
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
                                      // List view to show user workouts as list tiles.
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        // If user has no workouts, show no list tiles otherwise, show as many list tiles as there are workouts.
                                        itemCount: accountWorkouts.isEmpty
                                            ? 0
                                            : accountWorkouts.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Material(
                                            type: MaterialType.transparency,
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                      // Shows workout name.
                                                      accountWorkouts[index]
                                                              ["workoutName"]
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3),
                                                  // Selected list tile index is selected index.
                                                  selected:
                                                      index == selectedIndex,
                                                  // Selected list tile colour is primary.
                                                  selectedTileColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                  // When tapped, set selected index as selected list tile index. Get exercises to update interface with currently selected workout.
                                                  onTap: () {
                                                    setState(() {
                                                      selectedIndex = index;
                                                      _getExercises();
                                                    });
                                                  },
                                                  trailing: IconButton(
                                                      icon: Icon(Icons
                                                          .backspace_rounded),
                                                      // When pressed, show bottom sheet that prompts the user if they are sure they want to delete the workout.
                                                      onPressed: () {
                                                        showModalBottomSheet<
                                                                void>(
                                                            backgroundColor: Theme
                                                                    .of(context)
                                                                .scaffoldBackgroundColor,
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Container(
                                                                  height: 200,
                                                                  child: Padding(
                                                                      padding: EdgeInsets.all(5),
                                                                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                        Text(
                                                                            'Are you sure you want to delete this workout?',
                                                                            style:
                                                                                Theme.of(context).textTheme.bodyText2),
                                                                        SizedBox(
                                                                            height:
                                                                                10),
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              Container(
                                                                                width: 100,
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
                                                                                  // When pressed, deletes the currently selected workout.
                                                                                  onPressed: () {
                                                                                    try {
                                                                                      int deleteItem = accountWorkouts[index]['id'];
                                                                                      SQLHelper.deleteWorkout(deleteItem);
                                                                                      // Gets workouts and exercises to reflect changes to interface.
                                                                                      setState(() {
                                                                                        _getWorkouts();
                                                                                        _getExercises();
                                                                                      });
                                                                                      Navigator.pop(context);
                                                                                      // Inform user.
                                                                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                                        content: Text('Delete Successful. Please refresh.',
                                                                                            style: TextStyle(
                                                                                              color: Colors.white,
                                                                                            )),
                                                                                        backgroundColor: Colors.black,
                                                                                      ));
                                                                                    } catch (e) {
                                                                                      Navigator.pop(context);
                                                                                      // Inform user of error.
                                                                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                                        content: Text('Delete Unsuccessful',
                                                                                            style: TextStyle(
                                                                                              color: Colors.white,
                                                                                            )),
                                                                                        backgroundColor: Colors.black,
                                                                                      ));
                                                                                    }
                                                                                  },
                                                                                  child: Text('Yes', style: Theme.of(context).textTheme.bodyText1),
                                                                                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, elevation: 0),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: 100,
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
                                                                                  // When pressed, pops the navigator stack so that the bottom sheet disappears.
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Text('No', style: Theme.of(context).textTheme.bodyText1),
                                                                                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, elevation: 0),
                                                                                ),
                                                                              ),
                                                                            ])
                                                                      ])));
                                                            });
                                                      }),
                                                ),
                                                Divider(),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      width: 130,
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
                                        // When pressed, shows bottom sheet with text input and buttons for creating new workout.
                                        onPressed: () {
                                          showModalBottomSheet<void>(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                              ),
                                              backgroundColor: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              20, 0, 0, 0),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          'Workout Name',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            50,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black45,
                                                              spreadRadius: 2,
                                                              blurRadius: 7,
                                                              offset:
                                                                  Offset(0, 3),
                                                            ),
                                                          ],
                                                        ),
                                                        child: TextField(
                                                            controller:
                                                                workoutNamectrl,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              hintText:
                                                                  'Enter Workout Name...',
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      800]),
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .white70,
                                                            ))),
                                                    SizedBox(height: 10),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              20, 0, 0, 0),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          'Number Exercises',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            50,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black45,
                                                              spreadRadius: 2,
                                                              blurRadius: 7,
                                                              offset:
                                                                  Offset(0, 3),
                                                            ),
                                                          ],
                                                        ),
                                                        child: TextField(
                                                            controller:
                                                                workoutNumExercisectrl,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              hintText:
                                                                  'Enter Number Exercises...',
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      800]),
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .white70,
                                                            ))),
                                                    SizedBox(height: 30),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              50,
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black45,
                                                            spreadRadius: 2,
                                                            blurRadius: 7,
                                                            offset:
                                                                Offset(0, 3),
                                                          ),
                                                        ],
                                                      ),
                                                      child: ElevatedButton(
                                                        // When pressed, creates new workout with account Id and text inputs for name and number of exercises.
                                                        onPressed: () {
                                                          try {
                                                            SQLHelper.createWorkout(
                                                                widget
                                                                    .currentId,
                                                                workoutNamectrl
                                                                    .text,
                                                                int.parse(
                                                                    workoutNumExercisectrl
                                                                        .text));
                                                            workoutNamectrl
                                                                .text = '';
                                                            workoutNumExercisectrl
                                                                .text = '';
                                                            Navigator.pop(
                                                                context);
                                                            // Inform user.
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                  'Creation Successful. Please refresh.',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  )),
                                                              backgroundColor:
                                                                  Colors.black,
                                                            ));
                                                            // Gets workouts and exercises to reflect changes to interface.
                                                            setState(() {
                                                              _getWorkouts();
                                                              _getExercises();
                                                            });
                                                          } catch (e) {
                                                            workoutNamectrl
                                                                .text = '';
                                                            workoutNumExercisectrl
                                                                .text = '';
                                                            Navigator.pop(
                                                                context);
                                                            // Inform user of error.
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                  'Creation Unsuccessful. Please try again',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  )),
                                                              backgroundColor:
                                                                  Colors.black,
                                                            ));
                                                          }
                                                        },
                                                        child: Text('Create',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1),
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                            elevation: 0),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                              });
                                        },
                                        child: Text('Create New',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            elevation: 0),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      width: 130,
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
                                        // When pressed, gets workouts, exercises and pre-built workouts to update interface.
                                        onPressed: () {
                                          setState(() {
                                            _getWorkouts();
                                            _getExercises();
                                            _getPBWorkouts();
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
                                    SizedBox(height: 10),
                                  ])),
                              Container(
                                  height: 450,
                                  width: 175,
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
                                        // List view to display exercises for currently selected workout as list tiles.
                                        child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            // If there are no exercises in current workout, show no list tiles otherwise, show as many list tiles as there are exercises.
                                            itemCount: workoutExercises.isEmpty
                                                ? 0
                                                : workoutExercises.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(
                                                children: [
                                                  ListTile(
                                                      title: Text(
                                                          // Show exercise name, weight, sets and reps.
                                                          workoutExercises[
                                                                      index][
                                                                  'exerciseName']
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline3),
                                                      subtitle: Text(
                                                          'Weight (kg): ' +
                                                              workoutExercises[
                                                                          index]
                                                                      ['weight']
                                                                  .toString() +
                                                              ', Sets: ' +
                                                              workoutExercises[
                                                                          index]
                                                                      ['sets']
                                                                  .toString() +
                                                              ', Reps: ' +
                                                              workoutExercises[
                                                                          index]
                                                                      ['reps']
                                                                  .toString())),
                                                  Divider(),
                                                ],
                                              );
                                            })),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        Container(
                                          width: 130,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                            // When pressed, go to modify workout and pass in the accountId and workoutId of the currently selected workout.
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ModifyWorkout(
                                                              currentId: widget
                                                                  .currentId,
                                                              workoutId:
                                                                  accountWorkouts[
                                                                          selectedIndex]
                                                                      ['id'])));
                                            },
                                            child: Text('Edit',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                elevation: 0),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          width: 130,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                            // When pressed gp to perform workout to start the currently selected workout.
                                            onPressed: () {
                                              // If there are exercises to start.
                                              if (workoutExercises.isNotEmpty) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PerformWorkout(
                                                                currentId: widget
                                                                    .currentId,
                                                                workoutId:
                                                                    accountWorkouts[
                                                                            selectedIndex]
                                                                        [
                                                                        'id'])));
                                              } else {
                                                // Inform user of error.
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                      'Need at least 1 exercise to start workout.',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      )),
                                                  backgroundColor: Colors.black,
                                                ));
                                              }
                                            },
                                            child: Text('Start',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                elevation: 0),
                                          ),
                                        ),
                                      ]),
                                    )
                                  ]))
                            ],
                          ),
                          SizedBox(height: 10),
                          Text('Pre-Built Workouts',
                              style: Theme.of(context).textTheme.bodyText2),
                          SizedBox(height: 10),
                          Container(
                              height: 250,
                              width: 500,
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
                                  // List view to display pre-built workouts as list tiles.
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      // If there are no pre-built workouts then show no list tiles otherwise, show as many list tiles as there are pre-built workouts.
                                      itemCount: preBuiltWorkouts.isEmpty
                                          ? 0
                                          : preBuiltWorkouts.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Material(
                                          type: MaterialType.transparency,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                  title: Text(
                                                      // Show workout name.
                                                      preBuiltWorkouts[index]
                                                              ['workoutName']
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3),
                                                  // Selected list tile index is selected index.
                                                  selected:
                                                      index == pbSelectedIndex,
                                                  // Selected list tile colour is primary.
                                                  selectedTileColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                  // When pressed, set pre-built selected index as selected list tile index.
                                                  onTap: () {
                                                    setState(() {
                                                      pbSelectedIndex = index;
                                                    });
                                                  }),
                                              Divider(),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                                Container(
                                  width: 330,
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
                                    // When pressed, go to performworkout to start the currently selected pre-built exercise.
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PerformWorkout(
                                                      currentId:
                                                          widget.currentId,
                                                      workoutId: preBuiltWorkouts[
                                                              pbSelectedIndex]
                                                          ['id'])));
                                    },
                                    child: Text('Start',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        elevation: 0),
                                  ),
                                ),
                                SizedBox(height: 10)
                              ])),
                          SizedBox(height: 20),
                          Container(
                            width: 500,
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
                              // When pressed, go to performworkout to start an unplanned workout. Page knows the workoutId of 10000 is an unplanned workout and will display elements as required.
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PerformWorkout(
                                            currentId: widget.currentId,
                                            workoutId: 10000)));
                              },
                              child: Text('Start Unplanned Workout',
                                  style: Theme.of(context).textTheme.bodyText1),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  elevation: 0),
                            ),
                          ),
                        ]))))));
  }
}
