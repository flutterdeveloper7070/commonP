import 'package:predator_pest/app/common_imports/common_imports.dart';

String dateTime24HourFormat = 'dd MMM yyyy hh:mm:ss';
String paidOrReceiveDate = 'dd MMM yyyy';
String paidOrReceiveTime = 'hh:mm a';
String timeFormat12h = 'hh:mm a';

parseDate(DateTime date, {format}) {
  if (date == null) return "";
  //DateFormat format = DateFormat("dd MMM yyyy", "gu"); for gujarati
  DateFormat dateFormat = DateFormat(format??"dd MMM yyyy");
  return dateFormat.format(date);
}

formatTimeOfDay(context, t){
  final localizations = MaterialLocalizations.of(context);
  final formattedTimeOfDay = localizations.formatTimeOfDay(t);
  return formattedTimeOfDay;
}

// getLocalDateFromUTCTS(Timestamp timestamp){
//   return timestamp.toDate();
// }

getDateTimeInUTC(){
  //DateTime utcDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(DateTime.now().toString());
  return DateTime.now();
}

getDateTimeStringForReference(DateTime d){
  //return parseDate(d, format: "ddMMMyyyyHH:mm:ss");
  return d.millisecondsSinceEpoch.toString();
}