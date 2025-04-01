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


  static String formatDateTime(String dateTimeStr) {
    try {
      // Parse the input string to a DateTime object
      DateTime dateTime = DateTime.parse(dateTimeStr);

      // Create a DateFormat instance with the desired output format
      DateFormat formatter = DateFormat('d-MMM-yyyy h:mm a');

      // Format the DateTime object and return the result
      return formatter.format(dateTime);
    } catch (e) {
      // Handle parsing errors
      print('Error parsing date: $e');
      return dateTimeStr; // Return the original string if parsing fails
    }
  }

}