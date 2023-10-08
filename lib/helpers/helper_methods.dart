// return a formatted data as a string

import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp timestamp) {
  // Timestamp is the obnject we retrive from firebase
  // so to display it, lets convert it to a String
  DateTime dateTime = timestamp.toDate();

  // get year
  String year = dateTime.year.toString();

  // get month
  String month = dateTime.month.toString();

  // get day
  String day = dateTime.month.toString();

  // get hour 
  String hour = dateTime.hour.toString();

  // get minute
  String minute = dateTime.minute.toString();

  // final formatted String date
  String formattedDate = '$day/$month/$year $hour:$minute';

  return formattedDate;
}