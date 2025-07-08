import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

// This tutorial could help you understand more about building an app with Flutter.
// https://codelabs.developers.google.com/codelabs/flutter-codelab-first#0
// It is recommended but not required.

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMU Data Recording',
      theme: ThemeData(
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // TODO: Add a boolean variable, recording, to the help indicate whether we are recording the sensor data.
  

  // TODO: Add all variables for retrieving sensor data events, update times, and intervals
  // TODO: Initiate _streamSubscriptions to retrieve all StreamSubscriptions in an array.


  // TODO: Initiate a DatabaseHelper instance. 
  // DatabaseHelper class is at the end of this file and requires your implementation.


  @override
  Widget build(BuildContext context) {
    // return a Scaffold object for the UI elements.
    return Scaffold(
        body: 
      );
  }

  // TODO: implement this function to stop recording sensor data by cancelling the _streamSubscriptions
  void stopRecording() {
    
  }

  // TODO: start recording sensor data by adding subscriptions for
  // UserAccelerometerEvent, accelerometerEventStream, gyroscopeEventStream, magnetometerEventStream
  // use StreamSubscriptions.add function
  void startRecording() {

  }
}

// Define a class with all desired variables to store in the table
class ImuData {
  // TODO: Define all variables in this class here


  // Define the initiation of the class instance
  ImuData({

  });

  // TODO: Convert a IMU data into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {
      
    };
  }
}

// Define a DatabaseHelper class 
class DatabaseHelper {
  // TODO: create static variables to store to the same database 
  // and construct a global/static DatabaseHelper instance


  // TODO: Define the function to get all items from database
  Future<Database> get database async {

  }

  // TODO: Open the database and create the table if it doesn't exist.
  _initDatabase() async {

  }

  // TODO: SQL code to create the database table.
  Future _onCreate(Database db, int version) async {
    
  }

  // TODO: Method to insert IMU data into the database.
  Future<void> insertImuData(ImuData imuData) async {
    
  }

  // TODO: Write a function to export the database using Share.shareXFiles()
  Future<void> exportDatabase() async {

  }
}