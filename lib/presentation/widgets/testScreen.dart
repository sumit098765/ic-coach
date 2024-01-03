// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class MyTimePicker extends StatefulWidget {
//   @override
//   _MyTimePickerState createState() => _MyTimePickerState();
// }

// class _MyTimePickerState extends State<MyTimePicker> {
//   TimeOfDay _selectedTime = TimeOfDay.now();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cupertino Time Picker'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Selected Time: ${_selectedTime.format(context)}',
//               style: const TextStyle(fontSize: 30),
//             ),
//             const SizedBox(height: 20),
//             CupertinoButton(
//               color: Colors.blue,
//               child: const Text('Select Time'),
//               onPressed: () {
//                 _showCupertinoTimePicker(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _showCupertinoTimePicker(BuildContext context) {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (_) => Container(
//         height: 150,
//         color: Colors.white,
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child: CupertinoDatePicker(
//               //  use24hFormat: true,
//                 mode: CupertinoDatePickerMode.time,
//                 initialDateTime: DateTime(
//                     2023, 11, 30, _selectedTime.hour, _selectedTime.minute),
//                 onDateTimeChanged: (val) {
//                   setState(() {
//                     _selectedTime =
//                         TimeOfDay(hour: val.hour, minute: val.minute);
//                   });
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';

// // class CustomCupertinoTimePicker extends StatefulWidget {
// //   @override
// //   _CustomCupertinoTimePickerState createState() =>
// //       _CustomCupertinoTimePickerState();
// // }

// // class _CustomCupertinoTimePickerState extends State<CustomCupertinoTimePicker> {
// //   int selectedHour = DateTime.now().hour;
// //   int selectedMinute = DateTime.now().minute;
// //   String selectedPeriod = 'AM';

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Custom Cupertino Time Picker'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             Text(
// //               '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod',
// //               style: TextStyle(fontSize: 30),
// //             ),
// //             Container(
// //               height: 200,
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: <Widget>[
// //                   Expanded(child: _buildHourPicker()),
// //                   //Container(width: 2, color: Colors.black),
// //                   Expanded(child: _buildMinutePicker()),
// //                   //Container(width: 2, color: Colors.black),
// //                   Expanded(child: _buildPeriodPicker()),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildHourPicker() {
// //     return CupertinoPicker(
// //       itemExtent: 30.0,
// //       useMagnifier: true,
// //       onSelectedItemChanged: (value) {
// //         setState(() {
// //           selectedHour = value;
// //         });
// //       },
// //       children: List<Widget>.generate(12, (index) => Text('${index + 1}')),
// //     );
// //   }

// //   Widget _buildMinutePicker() {
// //     return CupertinoPicker(
// //       itemExtent: 30,
// //       useMagnifier: true,
// //       onSelectedItemChanged: (value) {
// //         setState(() {
// //           selectedMinute = value;
// //         });
// //       },
// //       children: List<Widget>.generate(
// //           60, (index) => Text(index.toString().padLeft(2, '0'))),
// //     );
// //   }

// //   Widget _buildPeriodPicker() {
// //     return CupertinoPicker(
// //       itemExtent: 30,
// //       useMagnifier: true,
// //       onSelectedItemChanged: (value) {
// //         setState(() {
// //           selectedPeriod = value == 0 ? 'AM' : 'PM';
// //         });
// //       },
// //       children: const <Widget>[Text('AM'), Text('PM')],
// //     );
// //   }
// // }
