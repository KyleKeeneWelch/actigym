// CIS099-2 Mobile Application Development.
// Assignment 2.
// ActiGym - Workout creator, tracker and logger.
// Kyle Keene - Welch, 2101940
// advice.dart

import 'package:flutter/material.dart';
import 'package:actigym/screens/myperformance.dart';
import 'package:actigym/screens/home.dart';
import 'package:actigym/screens/myworkouts.dart';

class Advice extends StatefulWidget {
  final currentId;

  const Advice({Key? key, this.currentId}) : super(key: key);

  @override
  State<Advice> createState() => _AdviceState();
}

class _AdviceState extends State<Advice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advice'),
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
              // Page name, associated icon, and description.
              ListTile(
                  title: Text('Home',
                      style: Theme.of(context).textTheme.headline2),
                  trailing: Icon(Icons.home),
                  subtitle: Text(
                      'Allocate exercise days, change profile picture and links to other areas.'),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                  tileColor: Theme.of(context).scaffoldBackgroundColor,
                  onTap: () {
                    // Go to corresponding page and pass through currentId.
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
            ],
          )),
      body: SingleChildScrollView(
          child: Center(
              child: Container(
                  child: Column(children: [
        Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              // Show image banner.
              image: AssetImage('assets/images/adviceimage.jpg'),
              fit: BoxFit.cover,
            ))),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                // Show quote.
                child: Text(
                  '"All progress takes place outside your comfort zone" - Michael John Bobok',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Helvetica',
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[600],
                      border: Border.all(
                          width: 3,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5)),
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
                        // Talk on progressive overload.
                        Text(
                          'Want to see some results? Progressive overload is a strategy to building muscle that works with increasing weight and rep ranges.',
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Work between a defined rep range for a particular exercise consistently and aim to increase the weight after reaching the top end of the range. Increasing the weight means more work for the muscles.',
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Progressive increase of the weight and the amount of achieved reps will be the stimulus that builds the muscles you are aiming for.',
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Try it out today!',
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 20),
              Text('Need Help?',
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.center),
              SizedBox(height: 20),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[600],
                      border: Border.all(
                          width: 3,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5)),
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
                        // Talk on how to use the app.
                        Text(
                          'ActiGym provides you your free account, and the tools to create, perform and track your workouts. It provides a log and performance summary of your workouts and aids your progress in reaching your fitness goals.',
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Change or reset your profile picture and logout by pressing the "account" icon in the home page. Navigate to other pages by pressing the "hamburger" icon found at the top left and selecting which page you wish to go to.',
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Create a new workout in My Workouts by pressing "Create New" and edit this by pressing "Edit". Pressing the "delete" icon will prompt to delete the selected workout and its corresponding exercises. By pressing "Refresh" you can refresh the current page to display up to date information to changes made to your account.',
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'You can start a workout by pressing "Start" either on a selected create workout or pre-built workout. Also, by pressing "Start Unplanned Workout" you can begin a workout that contains no parameters and will still be logged.',
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'In Modify Workout, you can add a new exercise to a selected workout by filling in the information and pressing "Create Exercise". You can also delete and clear exercises through pressing "Delete" and "Clear". "Start" will start the workout as before.',
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'When performing a workout, you can see the current exercise, last achieved reps, number of sets, last achieved weight and notes. Edit the notes as required and enter the new set information and press "Continue" to rest and progress onto the next set. Pressing "End Workout" will save the current workout no matter where you choose to end it.',
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Go to My Performance to see a detailed log and performance metrics of your workouts of which you can use to assist your fitness goals.',
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 20),
              Text('Reaching Out',
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.center),
              SizedBox(height: 20),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[600],
                      border: Border.all(
                          width: 3,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5)),
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
                        // How to reach ActiGym.
                        Text(
                          'Need more help, some information or want to contact a developer? Take a look at the following ways you can contact us:',
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 10),
                        // Displays contact methods as list tiles with associated icon/image, name of method and content.
                        ListTile(
                          leading: Icon(Icons.mail),
                          title: Text('Email',
                              style: Theme.of(context).textTheme.headline3),
                          subtitle: Text('actigym@outlook.com',
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                        ListTile(
                          leading: Icon(Icons.call),
                          title: Text('Telephone',
                              style: Theme.of(context).textTheme.headline3),
                          subtitle: Text('01234 543368',
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                        ListTile(
                          leading: Icon(Icons.language),
                          title: Text('Web',
                              style: Theme.of(context).textTheme.headline3),
                          subtitle: Text('actigym.com',
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                        ListTile(
                          leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage('assets/images/facebook.png'),
                                fit: BoxFit.cover,
                              ))),
                          title: Text('Facebook',
                              style: Theme.of(context).textTheme.headline3),
                          subtitle: Text('@ActiGym',
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                        ListTile(
                          leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image:
                                    AssetImage('assets/images/instagram.png'),
                                fit: BoxFit.cover,
                              ))),
                          title: Text('Instagram',
                              style: Theme.of(context).textTheme.headline3),
                          subtitle: Text('@ActiGym',
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        )
      ])))),
    );
  }
}
