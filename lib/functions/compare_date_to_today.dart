String compareDateToToday(DateTime date) {
  String status = 'Upcomming';
  DateTime today = DateTime.now();
  if (date.year <= today.year &&
      date.month <= today.month &&
      date.day <= today.day) {
    status = 'Completed';
  }
  return status;
}
