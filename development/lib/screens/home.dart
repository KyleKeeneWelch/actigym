// CIS099-2 Mobile Application Development.
// Assignment 2.
// ActiGym - Workout creator, tracker and logger.
// Kyle Keene - Welch, 2101940
// home.dart

import 'dart:io';
import 'package:actigym/components/sqlhelper.dart';
import 'package:actigym/screens/login.dart';
import 'package:actigym/screens/myworkouts.dart';
import 'package:actigym/screens/advice.dart';
import 'package:actigym/screens/myperformance.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  final currentId;

  const HomePage({Key? key, this.currentId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var imageFile;
  var imagePicker;
  var dayFocus;
  List<TextEditingController> dayControllers = [
    for (int i = 0; i <= 7; i++) TextEditingController()
  ];
  List<String> weekdays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  // Creates new dayfocus upon app initialization. Gets day focus if already edited and displays modifications to the text controllers.
  void _createDayFocus() async {
    await SQLHelper.createDayFocus(widget.currentId);
    dayFocus = await SQLHelper.getDayFocus(widget.currentId);
    dayControllers[0].text = dayFocus[0]['sunday'].toString();
    dayControllers[1].text = dayFocus[0]['monday'].toString();
    dayControllers[2].text = dayFocus[0]['tuesday'].toString();
    dayControllers[3].text = dayFocus[0]['wednesday'].toString();
    dayControllers[4].text = dayFocus[0]['thursday'].toString();
    dayControllers[5].text = dayFocus[0]['friday'].toString();
    dayControllers[6].text = dayFocus[0]['saturday'].toString();
  }

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
    _createDayFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home', style: Theme.of(context).textTheme.headline2),
          backgroundColor: Theme.of(context).primaryColor,
          actions: <Widget>[
            // Custom account icon button. Enables user to change profile picture and logout.
            IconButton(
                // Show account icon.
                icon: Icon(Icons.account_box_rounded),
                onPressed: () {
                  // When pressed, show bottom sheet with profile picture and logout button.
                  showModalBottomSheet<void>(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                            height: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                    child: SizedBox.fromSize(
                                        size: Size.fromRadius(100),
                                        // If the image file is not empty, show the image file otherwise, show the default profile pic.
                                        child: imageFile != null
                                            ? Image.file(
                                                File(imageFile!.path),
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                'assets/images/defaultuser.png'))),
                                SizedBox(
                                  height: 20,
                                ),
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
                                    // When pressed, show bottom sheet with options to change profile pic.
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
                                                height: 300,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
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
                                                            color: Colors
                                                                .black45
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 2,
                                                            blurRadius: 7,
                                                            offset:
                                                                Offset(0, 3),
                                                          ),
                                                        ],
                                                      ),
                                                      child: ElevatedButton(
                                                        // When pressed, capture new photo and save as image file, then display image as profile picture.
                                                        onPressed: () async {
                                                          XFile image = await imagePicker.pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .camera,
                                                              imageQuality: 50,
                                                              preferredCameraDevice:
                                                                  CameraDevice
                                                                      .front);
                                                          setState(() {
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                            imageFile = XFile(
                                                                image.path);
                                                          });
                                                          // Inform user.
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                            content: Text(
                                                                'Profile Picture Changed',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                            backgroundColor:
                                                                Colors.black,
                                                          ));
                                                        },
                                                        child: Text(
                                                            'Take Photo',
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
                                                        // When pressed, open gallery and select image then use image as profile picture.
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                          XFile image = await imagePicker.pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery,
                                                              imageQuality: 50,
                                                              preferredCameraDevice:
                                                                  CameraDevice
                                                                      .front);
                                                          setState(() {
                                                            imageFile = XFile(
                                                                image.path);
                                                          });
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                            content: Text(
                                                                'Profile Picture Changed',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                            backgroundColor:
                                                                Colors.black,
                                                          ));
                                                        },
                                                        child: Text(
                                                            'Pick From Gallery',
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
                                                        // When pressed, set image as null therefore causing the profile pic to display default pic.
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                          imageFile = null;
                                                          // Inform user.
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                            content: Text(
                                                                'Profile Picture Reset',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                            backgroundColor:
                                                                Colors.black,
                                                          ));
                                                        },
                                                        child: Text('Reset',
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
                                    child: Text('Change Profile Picture',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        elevation: 0),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
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
                                    // When pressed, logout and go back to login page.
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
                                    },
                                    child: Text('Log out ',
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
                            ));
                      });
                })
          ],
        ),
        // Navigation
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
                // Page name, associated icon, and description.
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
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // Show logo banner.
                      child: Image.asset('assets/images/actigymlogo2.png',
                          fit: BoxFit.fill),
                    ),
                    Divider(),
                    SizedBox(height: 30),
                    Text(
                      'Welcome',
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
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
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              // Welcome message and direction.
                              Text(
                                'ActiGym is your personal fitness planner, tracker and log which provides all the neccessary features and guidance to allow you to reach your fitness goals.',
                                style: Theme.of(context).textTheme.bodyText2,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'View your created workouts, create new workouts, perform one of your workouts, try a pre-built one, or start a completely unplanned workout! Look up some of the best guidance in the industry and track your performace over time with detailed graphs and statistics of your progress.',
                                style: Theme.of(context).textTheme.bodyText2,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'All included with your free account here with ActiGym.',
                                style: Theme.of(context).textTheme.bodyText2,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )),
                    SizedBox(height: 30),
                    Text('Time to get started!',
                        style: Theme.of(context).textTheme.headline1),
                    // Prompts to modify day focus.
                    Text(
                        'Select your focus for each day you plan on improving your fitness',
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center),
                    SizedBox(height: 30),
                    Container(
                        height: 300,
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
                            padding: const EdgeInsets.all(10.0),
                            child: Column(children: [
                              Expanded(
                                // Creates day focus as listview with separated list tiles.
                                child: ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8),
                                  // Amount of list tiles is the same as number of days.
                                  itemCount: dayControllers.length - 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                        child: Row(children: [
                                      Container(
                                        width: 120,
                                        // Display the day from the current list tile index.
                                        child: Text(weekdays[index],
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3),
                                      ),
                                      Container(
                                        width: 160,
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
                                            controller: dayControllers[index],
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              hintText: 'Enter day focus...',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[800]),
                                              filled: true,
                                              fillColor: Colors.white70,
                                            )),
                                      ),
                                      IconButton(
                                          icon: Icon(Icons.backspace_rounded),
                                          // Quickly clears the day focus day text.
                                          onPressed: () {
                                            dayControllers[index].text = '';
                                          }),
                                      SizedBox(height: 75)
                                    ]));
                                  },
                                  // Specifies how the list tiles will be separated.
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(),
                                ),
                              ),
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
                                  // When pressed, update the day focus of the currentId with the new entered text from the controllers.
                                  onPressed: () {
                                    try {
                                      SQLHelper.updateDayFocus(
                                          widget.currentId,
                                          dayControllers[0].text,
                                          dayControllers[1].text,
                                          dayControllers[2].text,
                                          dayControllers[3].text,
                                          dayControllers[4].text,
                                          dayControllers[5].text,
                                          dayControllers[6].text);

                                      //Inform user.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Save Successful',
                                            style: TextStyle(
                                              color: Colors.white,
                                            )),
                                        backgroundColor: Colors.black,
                                      ));
                                    } catch (e) {
                                      // Inform user of error.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Save Unsuccessful',
                                            style: TextStyle(
                                              color: Colors.white,
                                            )),
                                        backgroundColor: Colors.black,
                                      ));
                                    }
                                  },
                                  child: Text('Save',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      elevation: 0),
                                ),
                              ),
                            ]))),
                    SizedBox(height: 30),
                    Text('Ready to Workout?',
                        style: Theme.of(context).textTheme.headline1),
                    Text(
                        'Create your own workout, your reps, your weight, your style',
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center),
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
                        // When pressed, go to my workouts page to create new workout.
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            // Guide for when user reaches new page.
                            content: Text(
                                'Press "create new" to create a new workout then press "edit" to add some exercises.',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            backgroundColor: Colors.black,
                          ));
                          // Go to my workouts page.
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyWorkouts(currentId: widget.currentId)));
                        },
                        child: Text('Create New Workout',
                            style: Theme.of(context).textTheme.bodyText1),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            elevation: 0),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text('Already have a workout?',
                        style: Theme.of(context).textTheme.headline1,
                        textAlign: TextAlign.center),
                    Text(
                        'Perform one of your created workouts, start an unplanned workout or try out one pre-built!',
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center),
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
                        // When pressed, go to my workouts to start a workout.
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            duration: const Duration(seconds: 10),
                            // Guide for when user reaches new page.
                            content: Text(
                                'Please select one of your workouts then start, a pre-built workout then start or press "Start Unplanned Workout" to start a workout.',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            backgroundColor: Colors.black,
                          ));
                          // Go to my workouts page to start workout.
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyWorkouts(currentId: widget.currentId)));
                        },
                        child: Text('Start a Workout',
                            style: Theme.of(context).textTheme.bodyText1),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            elevation: 0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
