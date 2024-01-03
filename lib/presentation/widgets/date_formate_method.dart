import 'package:intl/intl.dart';

class DateTimeInfo {
  final String formattedDate;
  final String formattedTime;

  DateTimeInfo({required this.formattedDate, required this.formattedTime});
}

DateTimeInfo formatDate(int index, List fRes) {
  if (index >= 0 && index < fRes.length) {
    String inputDateString = fRes[index].reservation!.onschedEventTime ??
        "2023-11-30T21:30:00+00:00";

    DateTime dateTime = DateTime.parse(inputDateString).toLocal();

    String formattedDate = DateFormat("MMM d, yyyy").format(dateTime);
    String formattedTime = DateFormat("hh:mm a").format(dateTime);

    return DateTimeInfo(
        formattedDate: formattedDate, formattedTime: formattedTime);
  } else {
    return DateTimeInfo(formattedDate: 'Invalid index', formattedTime: '');
  }
}
