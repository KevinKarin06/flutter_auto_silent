// import 'package:autosilentflutter/database/LocationModel.dart';
// import 'package:autosilentflutter/view_models/LocationDetaialViewModel.dart';
// import 'package:autosilentflutter/widgets/InputField.dart';
// import 'package:autosilentflutter/widgets/CustomSwitch.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';

// class LocationDetails extends StatefulWidget {
//   final LocationModel model;
//   const LocationDetails({Key key, @required this.model}) : super(key: key);

//   @override
//   _LocationDetailsState createState() => _LocationDetailsState();
// }

// class _LocationDetailsState extends State<LocationDetails> {
//   final _formKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<LocationDetailViewModel>.reactive(
//       viewModelBuilder: () => LocationDetailViewModel(),
//       onModelReady: (vModel) => vModel.initialise(),
//       builder: (BuildContext context, LocationDetailViewModel vModel,
//               Widget child) =>
//           Scaffold(
//         appBar: AppBar(
//           elevation: 0.0,
//           backgroundColor: Colors.transparent,
//           actions: [
//             IconButton(
//               tooltip: 'delete',
//               onPressed: () {},
//               icon: Icon(
//                 Icons.delete_rounded,
//                 color: Colors.red,
//               ),
//             )
//           ],
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SingleChildScrollView(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     InputField(
//                       label: 'Location',
//                       text: widget.model.title,
//                       enabled: true,
//                     ),
//                     InputField(
//                       label: 'Location Details',
//                       text: widget.model.subtitle,
//                       maxLines: 3,
//                     ),
//                     InputField(
//                       label: 'Latitude',
//                       text: widget.model.latitude.toString(),
//                     ),
//                     InputField(
//                       label: 'Longitude',
//                       text: widget.model.longitude.toString(),
//                     ),
//                     InputField(
//                       label: 'Radius',
//                       text: '400',
//                       enabled: true,
//                     ),
//                     CustomSwitch(
//                         leftText: 'once',
//                         rightText: 'always',
//                         defaultValue: true,
//                         onValueChanged: (val) {
//                           print(val);
//                         }),
//                     MaterialButton(
//                       color: Colors.cyan,
//                       textColor: Colors.white,
//                       padding: EdgeInsets.all(12.0),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(8.0),
//                         ),
//                       ),
//                       onPressed: () {},
//                       child: Center(
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text('Save'),
//                             SizedBox(
//                               width: 8.0,
//                             ),
//                             Icon(Icons.check),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 16.0,
//                     ),
//                     MaterialButton(
//                       textColor: Colors.black,
//                       padding: EdgeInsets.all(12.0),
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(color: Colors.red),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(8.0),
//                         ),
//                       ),
//                       onPressed: () {},
//                       child: Center(
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text('Cancel'),
//                             SizedBox(
//                               width: 8.0,
//                             ),
//                             Icon(Icons.cancel),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
