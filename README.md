# Actigym

## Summary
This project uses the popular framework by Google `Flutter` to implement a Mobile Application Solution to assist many fitness related problems. ActiGym is a workout planner and log that will help you to create or select pre-built workouts to do all while monitoring your sessions and measuring your progress.

`Dart` as the official langauge, is used to build several components known as `widgets` which can be used to structure and present key areas. Each `widget` is designed to serve a particular function and the derived order and properties of such `widgets` make up the look and feel of the application to the user. Flutter is used to generate natively-compiled applications for multiple platforms including both `Android` and `iOS`.

ActiGym maintains a connection to a `MSAccess` database of which is used to store and access user data including accounts, sessions and workouts. A user is able to create a free account that they can use to specify days they plan to go to the gym, create new workouts, edit workouts, start workouts or view their performance. The interface allows for easy and convenient access to immediately start a workout as well as create and edit workouts to meet individual needs. Users that do not wish for the full process and prefer an abstracted experience can start with the pre-built workouts or select to perform an unplanned workout which provides only the basic workout components such as the timer.

## Features
- **MSAccess Database Connectivity** - Application instantiates and populates an MSAccess database with the relevant user information such as user accounts, sessions and workouts. 

- **Create and Edit Workouts** - ActiGym provides an easy interface for creating new and editing existing workouts. Exercises contained within a workout are clearly displayed in a list and the appropriate buttons to modify the workout and included exercises are provided. When suitable, a user can easily start the selected workout.

- **Intuitive Workout Execution** - Users are granted with an easy to follow workout execution where they can clearly see the workout they are performing, the current exercise they are on as well as other information such as the number of sets, the set number they are on, previous achieved reps, previous weight and workout notes.

- **Performance Tracking** - Provides a session log to see what workouts you have done and when and for how long they lasted. Also provides performance graphs which graphically show your progress on various areas.

- **Unplanned and Pre-built Workouts** - Users that don't want to worry about creating their own workouts or want to get straight into a workout can start an unplanned or pre-built workout. Unplanned workouts provide basic functionality to perform and log the workout without indication of exercises and sets. Pre-built workouts are as the name suggests pre-made so that you can stimulate an area or muscle group without worrying about adjusting your own workout.

- **Profile Picture Modification** - A user with a newly registered account will have their profile picture set as the default anonymous image. Users are able to update this by taking a new photo or accessing one taken from their gallery.
