// CIS099-2 Mobile Application Development.
// Assignment 2.
// ActiGym - Workout creator, tracker and logger.
// Kyle Keene - Welch, 2101940
// modifyworkout.dart

import 'package:actigym/screens/performworkout.dart';
import 'package:flutter/material.dart';
import 'package:actigym/screens/advice.dart';
import 'package:actigym/screens/myperformance.dart';
import 'package:actigym/screens/home.dart';
import 'package:actigym/screens/myworkouts.dart';
import 'package:actigym/components/sqlhelper.dart';

class ModifyWorkout extends StatefulWidget {
  final currentId;
  final workoutId;

  const ModifyWorkout({Key? key, this.currentId, this.workoutId})
      : super(key: key);

  @override
  State<ModifyWorkout> createState() => _ModifyWorkoutState();
}

class _ModifyWorkoutState extends State<ModifyWorkout> {
  TextEditingController exerciseNameCtrl = TextEditingController();
  TextEditingController exerciseSetsCtrl = TextEditingController();
  TextEditingController exerciseWeightCtrl = TextEditingController();
  TextEditingController exerciseNameEditCtrl = TextEditingController();
  TextEditingController exerciseSetsEditCtrl = TextEditingController();
  TextEditingController exerciseWeightEditCtrl = TextEditingController();
  TextEditingController testCtrl = TextEditingController();
  List<Map<String, dynamic>> workoutExercises = [{}];
  int selectedIndex = 0;

  // Gets all the exercises for the workout currently being modified.
  void _getExercises() async {
    workoutExercises =
        await SQLHelper.getWorkoutExercises(widget.workoutId.toString());
  }

  // Get exercises on initialization.
  @override
  initState() {
    super.initState();
    _getExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Modify Workout',
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
                        'View your created workouts or have a look at some pre-built.'),
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
                          Center(
                              child: Text('Add Exercise',
                                  style:
                                      Theme.of(context).textTheme.bodyText2)),
                          SizedBox(height: 10),
                          Container(
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
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 140,
                                          child: Text('Exercise Name',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              textAlign: TextAlign.center),
                                        ),
                                        Container(
                                          width: 200,
                                          decoration: BoxDecoration(
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
                                          child: TextField(
                                              controller: exerciseNameCtrl,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                hintText:
                                                    'Enter exercise name...',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[800]),
                                                filled: true,
                                                fillColor: Colors.white70,
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 140,
                                          child: Text('Number Sets',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              textAlign: TextAlign.center),
                                        ),
                                        Container(
                                          width: 200,
                                          decoration: BoxDecoration(
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
                                          child: TextField(
                                              controller: exerciseSetsCtrl,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                hintText:
                                                    'Enter number sets...',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[800]),
                                                filled: true,
                                                fillColor: Colors.white70,
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 140,
                                          child: Text('Working Weight (kg)',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              textAlign: TextAlign.center),
                                        ),
                                        Container(
                                          width: 200,
                                          decoration: BoxDecoration(
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
                                          child: TextField(
                                              controller: exerciseWeightCtrl,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                hintText: 'Enter weight...',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[800]),
                                                filled: true,
                                                fillColor: Colors.white70,
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          50,
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
                                        // When pressed, creates a new exercise with the current workoutId and the provided name, weight, sets text input.
                                        onPressed: () {
                                          try {
                                            SQLHelper.createExercise(
                                                widget.workoutId.toString(),
                                                exerciseNameCtrl.text,
                                                int.parse(
                                                    exerciseWeightCtrl.text),
                                                int.parse(
                                                    exerciseSetsCtrl.text),
                                                0,
                                                '');
                                            _getExercises();
                                            exerciseWeightCtrl.text = '';
                                            exerciseSetsCtrl.text = '';
                                            exerciseNameCtrl.text = '';
                                            //Inform user.
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text('Exercise Created',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  )),
                                              backgroundColor: Colors.black,
                                            ));
                                          } catch (e) {
                                            exerciseWeightCtrl.text = '';
                                            exerciseSetsCtrl.text = '';
                                            exerciseNameCtrl.text = '';
                                            // Inform user of error.
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content:
                                                  Text('Creation Unsuccessful',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      )),
                                              backgroundColor: Colors.black,
                                            ));
                                          }
                                        },
                                        child: Text('Create Exercise',
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
                              )),
                          SizedBox(height: 10),
                          Center(
                            child: Text('Exercise List',
                                style: Theme.of(context).textTheme.bodyText2),
                          ),
                          SizedBox(height: 10),
                          Container(
                              height: 450,
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
                                    // List view to display the exercises in the workout as list tiles.
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        // If there are no exercises then show no list tiles otherwise, show the amount of list tiles for the amount of exercises in the workout.
                                        itemCount: workoutExercises.isEmpty
                                            ? 0
                                            : workoutExercises.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Material(
                                            type: MaterialType.transparency,
                                            child: Column(
                                              children: [
                                                ListTile(
                                                    // Selected list tile is the selected index.
                                                    selected:
                                                        index == selectedIndex,
                                                    // Show selected as primary colour.
                                                    selectedTileColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    // When tapped, set selected index as index of tapped list tile.
                                                    onTap: () {
                                                      setState(() {
                                                        selectedIndex = index;
                                                      });
                                                    },
                                                    title: Text(
                                                        // Show exercise name, weight, sets and reps of current list tile exercise.
                                                        workoutExercises[index]
                                                                ['exerciseName']
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline3),
                                                    subtitle: Text('Weight (kg): ' +
                                                        workoutExercises[index]
                                                                ['weight']
                                                            .toString() +
                                                        ',           Sets: ' +
                                                        workoutExercises[index]
                                                                ['sets']
                                                            .toString() +
                                                        ',           Reps: ' +
                                                        workoutExercises[index]
                                                                ['reps']
                                                            .toString())),
                                                Divider(),
                                              ],
                                            ),
                                          );
                                        })),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: 100,
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
                                            // When pressed, show bottom sheet text text inputs and buttons for editing exercise.
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                  ),
                                                  isScrollControlled: true,
                                                  backgroundColor: Theme.of(
                                                          context)
                                                      .scaffoldBackgroundColor,
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                        height: 500,
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                        'Exercise Name',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        50,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color:
                                                                              Colors.black45,
                                                                          spreadRadius:
                                                                              2,
                                                                          blurRadius:
                                                                              7,
                                                                          offset: Offset(
                                                                              0,
                                                                              3),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child: TextField(
                                                                        controller: exerciseNameEditCtrl,
                                                                        decoration: InputDecoration(
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                          hintText:
                                                                              'Enter exercise name...',
                                                                          hintStyle:
                                                                              TextStyle(color: Colors.grey[800]),
                                                                          filled:
                                                                              true,
                                                                          fillColor:
                                                                              Colors.white70,
                                                                        )),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                        'Number Sets',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        50,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color:
                                                                              Colors.black45,
                                                                          spreadRadius:
                                                                              2,
                                                                          blurRadius:
                                                                              7,
                                                                          offset: Offset(
                                                                              0,
                                                                              3),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child: TextField(
                                                                        controller: exerciseSetsEditCtrl,
                                                                        decoration: InputDecoration(
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                          hintText:
                                                                              'Enter number sets...',
                                                                          hintStyle:
                                                                              TextStyle(color: Colors.grey[800]),
                                                                          filled:
                                                                              true,
                                                                          fillColor:
                                                                              Colors.white70,
                                                                        )),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                        'Working Weight (kg)',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        50,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color:
                                                                              Colors.black45,
                                                                          spreadRadius:
                                                                              2,
                                                                          blurRadius:
                                                                              7,
                                                                          offset: Offset(
                                                                              0,
                                                                              3),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child: TextField(
                                                                        controller: exerciseWeightEditCtrl,
                                                                        decoration: InputDecoration(
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10.0),
                                                                          ),
                                                                          hintText:
                                                                              'Enter weight...',
                                                                          hintStyle:
                                                                              TextStyle(color: Colors.grey[800]),
                                                                          filled:
                                                                              true,
                                                                          fillColor:
                                                                              Colors.white70,
                                                                        )),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          20),
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        50,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color:
                                                                              Colors.black45,
                                                                          spreadRadius:
                                                                              2,
                                                                          blurRadius:
                                                                              7,
                                                                          offset: Offset(
                                                                              0,
                                                                              3),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child:
                                                                        ElevatedButton(
                                                                      // When pressed, update the selected exercise with new text input values for name, weight, sets.
                                                                      onPressed:
                                                                          () {
                                                                        try {
                                                                          SQLHelper.updateExercise(
                                                                              workoutExercises[selectedIndex]['id'].toString(),
                                                                              exerciseNameEditCtrl.text,
                                                                              int.parse(exerciseWeightEditCtrl.text),
                                                                              int.parse(exerciseSetsEditCtrl.text),
                                                                              workoutExercises[selectedIndex]['reps'],
                                                                              workoutExercises[selectedIndex]['notes']);
                                                                          setState(
                                                                              () {
                                                                            // Get exercises again to update interface.
                                                                            _getExercises();
                                                                          });
                                                                          Navigator.pop(
                                                                              context);
                                                                          // Inform user.
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(const SnackBar(
                                                                            content: Text('Exercise Updated. Please refresh.',
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                )),
                                                                            backgroundColor:
                                                                                Colors.black,
                                                                          ));
                                                                          exerciseSetsEditCtrl.text =
                                                                              '';
                                                                          exerciseWeightEditCtrl.text =
                                                                              '';
                                                                          exerciseNameEditCtrl.text =
                                                                              '';
                                                                        } catch (e) {
                                                                          Navigator.pop(
                                                                              context);
                                                                          // Inform user of error.
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(const SnackBar(
                                                                            content: Text('Update Unsuccessful',
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                )),
                                                                            backgroundColor:
                                                                                Colors.black,
                                                                          ));
                                                                          exerciseSetsEditCtrl.text =
                                                                              '';
                                                                          exerciseWeightEditCtrl.text =
                                                                              '';
                                                                          exerciseNameEditCtrl.text =
                                                                              '';
                                                                        }
                                                                      },
                                                                      child: Text(
                                                                          'Update',
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText1),
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor: Theme.of(context)
                                                                              .primaryColor,
                                                                          elevation:
                                                                              0),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        50,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color:
                                                                              Colors.black45,
                                                                          spreadRadius:
                                                                              2,
                                                                          blurRadius:
                                                                              7,
                                                                          offset: Offset(
                                                                              0,
                                                                              3),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child:
                                                                        ElevatedButton(
                                                                      // When pressed, pop the navigator stack causing the bottom sheet to disappear.
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          'Cancel',
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText1),
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor: Theme.of(context)
                                                                              .primaryColor,
                                                                          elevation:
                                                                              0),
                                                                    ),
                                                                  ),
                                                                ])));
                                                  });
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
                                          width: 100,
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
                                            // When pressed, show bottom sheet asking if user is sure they want to delete the exercise.
                                            onPressed: () {
                                              showModalBottomSheet<void>(
                                                  backgroundColor: Theme.of(
                                                          context)
                                                      .scaffoldBackgroundColor,
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                        height: 200,
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                      'Are you sure you want to delete this exercise?',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText2),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              100,
                                                                          decoration:
                                                                              BoxDecoration(
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
                                                                          child:
                                                                              ElevatedButton(
                                                                            // When pressed, deletes the selected exercise.
                                                                            onPressed:
                                                                                () {
                                                                              try {
                                                                                int deleteItem = workoutExercises[selectedIndex]['id'];
                                                                                SQLHelper.deleteExercise(deleteItem);
                                                                                setState(() {
                                                                                  // Gets exercises to update the interface.
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
                                                                            child:
                                                                                Text('Yes', style: Theme.of(context).textTheme.bodyText1),
                                                                            style:
                                                                                ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, elevation: 0),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              100,
                                                                          decoration:
                                                                              BoxDecoration(
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
                                                                          child:
                                                                              ElevatedButton(
                                                                            // When pressed, pops the navigator stack so that the bottom sheet disappears.
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Text('No', style: Theme.of(context).textTheme.bodyText1),
                                                                            style:
                                                                                ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, elevation: 0),
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
                                                    Theme.of(context)
                                                        .primaryColor,
                                                elevation: 0),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
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
                                            // When pressed, gets the exercises again so that any changes can be reflected upon the interface.
                                            onPressed: () {
                                              setState(() {
                                                _getExercises();
                                              });
                                            },
                                            child: Text('Refresh',
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
                              ])),
                          SizedBox(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 175,
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
                                    // When pressed, shows bottom sheet that prompts if user is sure they want to clear all exercises from the workout.
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
                                                              'Are you sure you want to clear all exercises?',
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
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .black45,
                                                                        spreadRadius:
                                                                            2,
                                                                        blurRadius:
                                                                            7,
                                                                        offset: Offset(
                                                                            0,
                                                                            3),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child:
                                                                      ElevatedButton(
                                                                    // When pressed, goes through each exercise in the workout and deletes it.
                                                                    onPressed:
                                                                        () {
                                                                      try {
                                                                        for (int i =
                                                                                0;
                                                                            i < workoutExercises.length;
                                                                            i++) {
                                                                          SQLHelper.deleteExercise(workoutExercises[i]
                                                                              [
                                                                              'id']);
                                                                        }
                                                                        setState(
                                                                            () {
                                                                          _getExercises();
                                                                        });
                                                                        Navigator.pop(
                                                                            context);
                                                                        // Inform user.
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(const SnackBar(
                                                                          content: Text(
                                                                              'Exercises successfully cleared. Please refresh.',
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                              )),
                                                                          backgroundColor:
                                                                              Colors.black,
                                                                        ));
                                                                      } catch (e) {
                                                                        Navigator.pop(
                                                                            context);
                                                                        // Inform user of error.
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(const SnackBar(
                                                                          content: Text(
                                                                              'Exercise clearing was unsuccessful.',
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                              )),
                                                                          backgroundColor:
                                                                              Colors.black,
                                                                        ));
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                        'Yes',
                                                                        style: Theme.of(context)
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
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .black45,
                                                                        spreadRadius:
                                                                            2,
                                                                        blurRadius:
                                                                            7,
                                                                        offset: Offset(
                                                                            0,
                                                                            3),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child:
                                                                      ElevatedButton(
                                                                    // When pressed, pops the navigator stack so that the bottom sheet disappears.
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        'No',
                                                                        style: Theme.of(context)
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
                                    child: Text('Clear',
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
                                  width: 175,
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
                                    // When pressed, goes to perform workout passing in the workout Id of the workout the user wants to start and their account Id.
                                    onPressed: () {
                                      // If there are exercises to perform.
                                      if (workoutExercises.isNotEmpty) {
                                        // Go to perform workout and start chosen workout.
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PerformWorkout(
                                                        currentId:
                                                            widget.currentId,
                                                        workoutId:
                                                            widget.workoutId)));
                                      } else {
                                        // Inform user of error.
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
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
                                            Theme.of(context).primaryColor,
                                        elevation: 0),
                                  ),
                                ),
                              ])
                        ]))))));
  }
}
