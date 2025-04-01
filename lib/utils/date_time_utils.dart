import 'package:intl/intl.dart';

class DateTimeUtil {
  // Get the current DateTime
  static DateTime getCurrentDateTime() {
    return DateTime.now();
  }

  // Get the current date as a formatted string (e.g., "dd-MM-yyyy")
  static String getFormattedDate() {
    DateTime now = DateTime.now();
    return DateFormat('dd-MM-yyyy').format(now);
  }

  // Get the current time as a formatted string (e.g., "HH:mm:ss")
  static String getFormattedTime() {
    DateTime now = DateTime.now();
    return DateFormat('HH:mm:ss').format(now);
  }

  // Get the current date and time as a formatted string (e.g., "dd-MM-yyyy HH:mm:ss")
  static String getFormattedDateTime() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  }
}