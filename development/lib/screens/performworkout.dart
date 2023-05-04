// CIS099-2 Mobile Application Development.
// Assignment 2.
// ActiGym - Workout creator, tracker and logger.
// Kyle Keene - Welch, 2101940
// performworkout.dart

import 'package:flutter/material.dart';
import 'package:actigym/components/sqlhelper.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class PerformWorkout extends StatefulWidget {
  final currentId;
  final workoutId;

  const PerformWorkout({Key? key, this.currentId, this.workoutId})
      : super(key: key);

  @override
  State<PerformWorkout> createState() => _PerformWorkoutState();
}

class _PerformWorkoutState extends State<PerformWorkout> {
  List<Map<String, dynamic>> workoutExercises = [{}];
  List<Map<String, dynamic>> currentWorkout = [{}];
  int exerciseCounter = 1;
  int setCounter = 1;
  bool isVisible = true;
  final StopWatchTimer _stopWatchTimer =
      StopWatchTimer(mode: StopWatchMode.countUp);
  var stopWatchValue;
  final StopWatchTimer _stopWatchTimer2 =
      StopWatchTimer(mode: StopWatchMode.countDown);
  TextEditingController notesCtrl = TextEditingController();
  TextEditingController repsCtrl = TextEditingController();
  TextEditingController weightCtrl = TextEditingController();
  List<int> setReps = [];
  List<int> setWeights = [];

  // Gets the current workout to be performed.
  void _getWorkouts() async {
    currentWorkout = await SQLHelper.getWorkout(widget.workoutId.toString());
  }

  // Gets the exercises for the current workout to be performed.
  void _getExercises() async {
    workoutExercises =
        await SQLHelper.getWorkoutExercises(widget.workoutId.toString());
  }

  // Upon intializing the page get the current workout and exercises and set the preset time for the stop watch.
  @override
  initState() {
    super.initState();
    _getExercises();
    _getWorkouts();
    notesCtrl.text = '';
    _stopWatchTimer2.setPresetTime(mSec: 120000);
  }

  // Clear stop watch resources.
  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
    await _stopWatchTimer2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            // When pressed, shows bottom sheet that prompts the user if they are sure they want to quit.
            onPressed: () {
              showModalBottomSheet<void>(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                        height: 200,
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Are you sure you want to quit?',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                  SizedBox(height: 10),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                                            // When pressed, pops the navigator stack twice so that it closes the bottom sheet then goes to modifyworkout/myworkouts.
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: Text('Yes',
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
                                            // When pressed, pops the navigator stack so the bottom sheet disappears.
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('No',
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
                                      ])
                                ])));
                  });
            },
          ),
          title: Text('Perform Workout'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Container(
                    child: Column(children: [
          Container(
              alignment: Alignment.centerLeft,
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                // Show workout image.
                image: AssetImage('assets/images/performworkout.jpg'),
                fit: BoxFit.cover,
              )),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          // If the workout is unplanned show that exercise name, sets, reps and weight are unspecified (sets up to 99). Otherwise, show the name, sets, reps and weight for the current exercise the user is on.
                          widget.workoutId.toString() == '10000'
                              ? 'Exercise: Unspecified'
                              : 'Exercise ' +
                                  exerciseCounter.toString() +
                                  ': ' +
                                  workoutExercises[exerciseCounter - 1]
                                          ['exerciseName']
                                      .toString(),
                          style: Theme.of(context).textTheme.headline3),
                      SizedBox(height: 20),
                      Text(widget.workoutId.toString() == '10000'
                          ? 'Sets: Up to 99'
                          : 'Sets: ' +
                              workoutExercises[exerciseCounter - 1]['sets']
                                  .toString()),
                      SizedBox(height: 20),
                      Text(widget.workoutId.toString() == '10000'
                          ? 'Reps: Unspecified'
                          : 'Achived Reps: ' +
                              workoutExercises[exerciseCounter - 1]['reps']
                                  .toString()),
                      SizedBox(height: 20),
                      Text(widget.workoutId.toString() == '10000'
                          ? 'Weight (kg): Unspecified'
                          : 'Weight (kg): ' +
                              workoutExercises[exerciseCounter - 1]['weight']
                                  .toString())
                    ],
                  ))),
          SizedBox(height: 20),
          // Allows the start button to disappear upon start of workout.
          Visibility(
            visible: isVisible,
            child: Center(
              child: Container(
                width: 300,
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
                  // When pressed, start the stopwatch, load the first exercise notes or empty then set as no longer visible.
                  onPressed: () {
                    _stopWatchTimer.onStartTimer();
                    setState(() {
                      notesCtrl.text = widget.workoutId.toString() == '10000'
                          ? ''
                          : workoutExercises[exerciseCounter - 1]['notes']
                              .toString();
                      isVisible = false;
                    });
                  },
                  child: Text('Start',
                      style: Theme.of(context).textTheme.bodyText1),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 0),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          // Stop watch.
          StreamBuilder<int>(
            stream: _stopWatchTimer.rawTime,
            initialData: 0,
            builder: (context, snap) {
              stopWatchValue = snap.data;
              final displayTime = StopWatchTimer.getDisplayTime(stopWatchValue);
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(displayTime,
                        style: Theme.of(context).textTheme.headline2),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 10),
          Text('Notes', style: Theme.of(context).textTheme.bodyText2),
          SizedBox(height: 10),
          Container(
            constraints: BoxConstraints(maxHeight: 100),
            width: MediaQuery.of(context).size.width - 50,
            decoration: BoxDecoration(
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
            child: SingleChildScrollView(
              child: TextField(
                  maxLines: null,
                  controller: notesCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Start to display notes if any...',
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    filled: true,
                    fillColor: Colors.white70,
                  )),
            ),
          ),
          SizedBox(height: 20),
          // Displays the current set upon each increment.
          Text('Set ' + setCounter.toString(),
              style: Theme.of(context).textTheme.bodyText2),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width - 50,
            decoration: BoxDecoration(
                color: Colors.grey[600],
                border: Border.all(
                    width: 3,
                    color: Theme.of(context).primaryColor.withOpacity(0.5)),
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
                padding: const EdgeInsets.all(12.0),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Reps:              ',
                            style: Theme.of(context).textTheme.bodyText2),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
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
                          child: TextField(
                              controller: repsCtrl,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintText: 'Enter achieved reps...',
                                hintStyle: TextStyle(color: Colors.grey[800]),
                                filled: true,
                                fillColor: Colors.white70,
                              )),
                        )
                      ]),
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Weight (kg): ',
                            style: Theme.of(context).textTheme.bodyText2),
                        SizedBox(height: 10),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
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
                          child: TextField(
                              controller: weightCtrl,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintText: 'Enter achieved weight...',
                                hintStyle: TextStyle(color: Colors.grey[800]),
                                filled: true,
                                fillColor: Colors.white70,
                              )),
                        ),
                      ])
                ])),
          ),
          SizedBox(height: 30),
          Container(
            width: MediaQuery.of(context).size.width - 50,
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
              // When pressed, save set information, rest and go to next set if not finished sets for that exercise. Otherwise rest, start next exercise or display no more exercises.
              onPressed: () {
                // If not unplanned workout.
                if (widget.workoutId.toString() != '10000') {
                  // Increment set as beginning.
                  setState(() {
                    setCounter++;
                  });
                  // If sets hasn't exceeded sets for that exercise.
                  if (setCounter <=
                      workoutExercises[exerciseCounter - 1]['sets']) {
                    try {
                      // Save set information and start rest timer.
                      setReps.add(int.parse(repsCtrl.text));
                      setWeights.add(int.parse(weightCtrl.text));
                      _stopWatchTimer2.onStartTimer();
                      // Show bottom sheet with rest timer and button that closes bottom sheet if user is ready.
                      showModalBottomSheet<void>(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                                height: 200,
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Take a Break...',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1),
                                          SizedBox(height: 10),
                                          StreamBuilder<int>(
                                            stream: _stopWatchTimer2.rawTime,
                                            initialData: 0,
                                            builder: (context, snap) {
                                              stopWatchValue = snap.data;
                                              final displayTime =
                                                  StopWatchTimer.getDisplayTime(
                                                      stopWatchValue);
                                              return Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Text(displayTime,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline2),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                50,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                              // When pressed, pops the navigator stack so that the bottom sheet disappears and resets the rest timer.
                                              onPressed: () {
                                                _stopWatchTimer2.onResetTimer();
                                                Navigator.pop(context);
                                              },
                                              child: Text('Start next set',
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
                                        ])));
                          });
                    } catch (e) {
                      // If there is an error, deduct set increment and inform user of error.
                      setState(() {
                        setCounter--;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please enter valid values.',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        backgroundColor: Colors.black,
                      ));
                    }
                    repsCtrl.text = '';
                    weightCtrl.text = '';
                  }
                  // If sets has exceeded the sets for that exercise.
                  else if (setCounter >
                      workoutExercises[exerciseCounter - 1]['sets']) {
                    // If set and weight information has been entered.
                    if (setReps.isNotEmpty && setWeights.isNotEmpty) {
                      // Find greatest set reps and weight.
                      int maxReps = setReps.reduce(max);
                      int maxWeight = setWeights.reduce(max);
                      // Update current exercise with new values.
                      SQLHelper.updateExercise(
                          workoutExercises[exerciseCounter - 1]['id']
                              .toString(),
                          workoutExercises[exerciseCounter - 1]['exerciseName'],
                          maxWeight,
                          workoutExercises[exerciseCounter - 1]['sets'],
                          maxReps,
                          notesCtrl.text);
                      // If there are still exercises left in the workout.
                      if (exerciseCounter < workoutExercises.length) {
                        // Reset set counter, increment exercise counter, clear saved information, display next exercise notes.
                        setState(() {
                          setCounter = 1;
                          exerciseCounter++;
                          setReps.clear();
                          setWeights.clear();
                          notesCtrl.text =
                              workoutExercises[exerciseCounter - 1]['notes'];
                          repsCtrl.text = '';
                          weightCtrl.text = '';
                        });
                        _stopWatchTimer2.onResetTimer();
                        _stopWatchTimer2.onStartTimer();
                        // Show bottom sheet with rest timer and button to skip.
                        showModalBottomSheet<void>(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  height: 200,
                                  child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Take a Break...',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1),
                                            SizedBox(height: 10),
                                            StreamBuilder<int>(
                                              stream: _stopWatchTimer2.rawTime,
                                              initialData: 0,
                                              builder: (context, snap) {
                                                stopWatchValue = snap.data;
                                                final displayTime =
                                                    StopWatchTimer
                                                        .getDisplayTime(
                                                            stopWatchValue);
                                                return Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Text(displayTime,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline2),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  50,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
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
                                                // When pressed, pops the navigator stack so the bottom sheet disappears.
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Start next set',
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
                                          ])));
                            });
                      }
                      // No more exercises.
                      else {
                        // Return set counter as final set.
                        setState(() {
                          setCounter--;
                          repsCtrl.text = '';
                          weightCtrl.text = '';
                        });
                        // Inform user.
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              'No more exercises. Please end your workout.',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          backgroundColor: Colors.black,
                        ));
                      }
                    }
                    // There have been no set and weight information entered.
                    else {
                      // Decrement set counter as information not saved as not entered.
                      setState(() {
                        setCounter--;
                      });
                      // Inform user.
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Please ensure achieved reps and weight for the current set is provided',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        backgroundColor: Colors.black,
                      ));
                    }
                  }
                }
                // If unplanned workout.
                else {
                  repsCtrl.text = '';
                  weightCtrl.text = '';
                  // If not exceeded 99 sets.
                  if (setCounter < 99) {
                    // Increment set counter.
                    setState(() {
                      setCounter++;
                    });
                    _stopWatchTimer2.onResetTimer();
                    _stopWatchTimer2.onStartTimer();
                    // Show bottom sheet with rest timer and button to skip.
                    showModalBottomSheet<void>(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                              height: 200,
                              child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Take a Break...',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1),
                                        SizedBox(height: 10),
                                        StreamBuilder<int>(
                                          stream: _stopWatchTimer2.rawTime,
                                          initialData: 0,
                                          builder: (context, snap) {
                                            stopWatchValue = snap.data;
                                            final displayTime =
                                                StopWatchTimer.getDisplayTime(
                                                    stopWatchValue);
                                            return Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Text(displayTime,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
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
                                            // When pressed, pops the navigator stack so the bottom sheet disappears.
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Start next set',
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
                                      ])));
                        });
                  }
                  // Exceeds 99 sets.
                  else {
                    // Inform user.
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          'Maximum number of sets reached. Please end your workout.',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      backgroundColor: Colors.black,
                    ));
                  }
                }
              },
              child: Text('Continue',
                  style: Theme.of(context).textTheme.bodyText1),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  elevation: 0),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width - 50,
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
              // When pressed, shows bottom sheet prompting the user if they are sure they want to end the workout.
              onPressed: () {
                showModalBottomSheet<void>(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                          height: 200,
                          child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        'Are you sure you want to end the workout?',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                    SizedBox(height: 10),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                              // When pressed, stop the stopwatch and add the session to the log.
                                              onPressed: () {
                                                _stopWatchTimer.onStopTimer();
                                                try {
                                                  // Formats the date and time.
                                                  String currentDate =
                                                      DateFormat(
                                                              'dd/MM/yyyy HH:mm')
                                                          .format(
                                                              DateTime.now())
                                                          .toString();
                                                  // Converts stop watch time to minutes to 2 decimal places.
                                                  final displayTime =
                                                      (stopWatchValue / 60000)
                                                          .toStringAsFixed(2);
                                                  // Adds session with currentId, workoutId, workout name, date, time, and duration to the log then goes to modifyworkout/myworkout.
                                                  SQLHelper.addWorkoutToLog(
                                                      widget.currentId
                                                          .toString(),
                                                      widget.workoutId
                                                          .toString(),
                                                      currentWorkout[0]
                                                              ['workoutName']
                                                          .toString(),
                                                      currentDate,
                                                      displayTime);
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                } catch (e) {
                                                  Navigator.pop(context);
                                                  // Inform user of error.
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                        'Workout Logging Unsuccessful',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        )),
                                                    backgroundColor:
                                                        Colors.black,
                                                  ));
                                                }
                                              },
                                              child: Text('Yes',
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
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                              // When pressed, pops the navigator stack so the bottom sheet disappears.
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('No',
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
                                        ])
                                  ])));
                    });
              },
              child: Text('End Workout',
                  style: Theme.of(context).textTheme.bodyText1),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  elevation: 0),
            ),
          ),
          SizedBox(height: 20)
        ])))));
  }
}
