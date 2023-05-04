// CIS099-2 Mobile Application Development.
// Assignment 2.
// ActiGym - Workout creator, tracker and logger.
// Kyle Keene - Welch, 2101940
// sqlhelper.dart

import 'package:sqflite/sqflite.dart' as sql;
import 'dart:async';

class SQLHelper {
  // Creates tables in database. Called through on create when connection established.
  static Future<void> createTables(sql.Database database) async {
    // accounts table.
    await database.execute("""CREATE TABLE IF NOT EXISTS accounts(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    username TEXT,
    password TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    );
    """);

    // dayfocus table.
    await database.execute("""
    CREATE TABLE IF NOT EXISTS dayfocus(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    accountId INTEGER,
    sunday TEXT,
    monday TEXT,
    tuesday TEXT,
    wednesday TEXT,
    thursday TEXT,
    friday TEXT,
    saturday TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    );
    """);

    // accountworkouts table.
    await database.execute("""
    CREATE TABLE IF NOT EXISTS accountworkouts(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    accountId INTEGER,
    workoutName TEXT,
    numExercises INTEGER,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    );
    """);

    // workoutexercises table.
    await database.execute("""
    CREATE TABLE IF NOT EXISTS workoutexercises(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    workoutId INTEGER,
    exerciseName TEXT,
    weight INTEGER,
    sets INTEGER,
    reps INTEGER,
    notes TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    );
    """);

    // workoutlog table.
    await database.execute("""
      CREATE TABLE IF NOT EXISTS workoutlog(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      accountId INTEGER,
      workoutId INTEGER,
      workoutName TEXT,
      workoutDate TEXT,
      workoutTime TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      );
    """);
  }

  // Called upon every database function to establish connection to database and create tables if not done already.
  static Future<sql.Database> db() async {
    return sql.openDatabase('../database/actigym_data.accdb', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  // Deletes the session with the provided id.
  static Future<void> deleteSession(int id) async {
    final db = await SQLHelper.db();

    await db.delete('workoutLog', where: 'id = ?', whereArgs: [id]);
  }

  // Deletes the exercise with the provided id.
  static Future<void> deleteExercise(int id) async {
    final db = await SQLHelper.db();

    await db.delete('workoutexercises', where: 'id = ?', whereArgs: [id]);
  }

  // Deletes the workout with the provided id.
  static Future<void> deleteWorkout(int id) async {
    final db = await SQLHelper.db();

    await db.delete('accountWorkouts', where: 'id = ?', whereArgs: [id]);
    await db
        .delete('workoutexercises', where: 'workoutId = ?', whereArgs: [id]);
  }

  // Updates the values of exercise with provided exerciseId and parameters.
  static Future<void> updateExercise(String exerciseId, String exerciseName,
      int weight, int sets, int reps, String notes) async {
    final db = await SQLHelper.db();

    final data = {
      'exerciseName': exerciseName,
      'weight': weight,
      'sets': sets,
      'reps': reps,
      'notes': notes
    };
    await db.update('workoutexercises', data,
        where: 'id = ?', whereArgs: [exerciseId]);
  }

  // Adds a new workout session to the log.
  static Future<void> addWorkoutToLog(String accountId, String workoutId,
      String workoutName, String date, String time) async {
    final db = await SQLHelper.db();

    final data = {
      'accountId': accountId,
      'workoutId': workoutId,
      'workoutName': workoutName,
      'workoutDate': date,
      'workoutTime': time
    };
    await db.insert('workoutlog', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  // Creates a new exercise in the workout with the provided workoutId and parameters.
  static Future<void> createExercise(String workoutId, String name, int weight,
      int sets, int reps, String notes) async {
    final db = await SQLHelper.db();

    final data = {
      'workoutId': workoutId,
      'exerciseName': name,
      'weight': weight,
      'sets': sets,
      'reps': reps,
      'notes': notes
    };
    await db.insert('workoutexercises', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  // Creates a new workout with the provided accountId and parameters.
  static Future<void> createWorkout(
      String accountId, String name, int numExercises) async {
    final db = await SQLHelper.db();

    final data = {
      'accountId': accountId,
      'workoutName': name,
      'numExercises': numExercises
    };
    await db.insert('accountworkouts', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  // Creates a new account with the provided parameters.
  static Future<int> createAccount(String username, String password) async {
    final db = await SQLHelper.db();

    final data = {'username': username, 'password': password};
    final id = await db.insert('accounts', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Creates a new dayfocus with the provided accountId.
  static Future<void> createDayFocus(String accountId) async {
    final db = await SQLHelper.db();

    final data = {
      'accountId': accountId,
      'sunday': "",
      'monday': "",
      'tuesday': "",
      'wednesday': "",
      'thursday': "",
      'friday': "",
      'saturday': ""
    };
    await db.insert('dayfocus', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  // Updates the dayfocus of account with provided accountId.
  static Future<void> updateDayFocus(
      String accountId,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday) async {
    final db = await SQLHelper.db();

    final data = {
      'sunday': sunday,
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'friday': friday,
      'saturday': saturday
    };

    await db.update('dayfocus', data,
        where: "accountId = ?", whereArgs: [accountId]);
  }

  // Gets the account sessions of the account with provided accountId.
  static Future<List<Map<String, dynamic>>> getAccountSessions(
      String accountId) async {
    final db = await SQLHelper.db();

    return db
        .query('workoutlog', where: 'accountId = ?', whereArgs: [accountId]);
  }

  // Gets the workout exercises of the workout with provided workoutId.
  static Future<List<Map<String, dynamic>>> getWorkoutExercises(
      String workoutId) async {
    final db = await SQLHelper.db();

    return db.query('workoutexercises',
        where: 'workoutId = ?', whereArgs: [workoutId]);
  }

  // Gets the workout of the provided workoutId.
  static Future<List<Map<String, dynamic>>> getWorkout(String workoutId) async {
    final db = await SQLHelper.db();

    return db.query('accountworkouts', where: 'id = ?', whereArgs: [workoutId]);
  }

  // Gets the workouts from the provided accountId.
  static Future<List<Map<String, dynamic>>> getAccountWorkouts(
      String accountId) async {
    final db = await SQLHelper.db();

    return db.query('accountworkouts',
        where: 'accountId = ?', whereArgs: [accountId]);
  }

  // Gets the dayfocus of the account with provided accountId.
  static Future<List<Map<String, dynamic>>> getDayFocus(
      String accountId) async {
    final db = await SQLHelper.db();

    return db.query('dayfocus', where: 'accountId = ?', whereArgs: [accountId]);
  }

  // Gets the account with provided parameters.
  static Future<List<Map<String, dynamic>>> getAccount(
      String username, String password) async {
    final db = await SQLHelper.db();

    return db.query('accounts',
        where: 'username = ? and password = ?',
        whereArgs: [username, password]);
  }
}
