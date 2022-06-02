import 'package:bue_university_project/domain/models.dart';
import 'package:bue_university_project/presentation/resources/assets_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class ReservationView extends StatefulWidget {
  // const ({Key? key}) : super(key: key);
  String? userName;
  String? role;
  String? busId;
  String? reservationId;
  ReservationView(
      {this.userName, this.role, this.busId, this.reservationId});
  @override
  _ReservationViewState createState() => _ReservationViewState();
}

class _ReservationViewState extends State<ReservationView> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Reservation History'),
        ),
        body: Container(
          decoration:  const BoxDecoration(
            image:  DecorationImage(image :AssetImage(AppAssets.background), fit: BoxFit.cover,),
          ),
          child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('busNumbers')
                  .doc(widget.busId)
                  .collection('reservations')
                  .orderBy('date').get(),
              builder: (context, snapshot) {
                List<ReservationModel> data = snapshot.data!.docs
                    .map((doc) => ReservationModel.fromJson(doc))
                    .toList();
                var inputFormat = DateFormat('dd/MM/yyyy HH:mm');

                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                            width: double.infinity,
                            height: 0.18 * h,
                            color: Colors.black26,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(13.0),
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text("userName :  "),
                                                Text(data[index].userName ?? "")
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                Text("uid :  "),
                                                Text(data[index].uid ?? ""),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Date :  "),
                                                    Text(inputFormat
                                                        .format(data[index]
                                                        .date!
                                                        .toDate())
                                                        .toString()
                                                        ),
                                                  ],
                                                ),
                                                IconButton(
                                                    onPressed: () async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                          'busNumbers')
                                                          .doc(widget.busId)
                                                          .collection(
                                                          'reservations')
                                                          .doc(data[index].uid)
                                                          .delete();
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('users')
                                                          .doc(data[index].uid)
                                                          .update({
                                                        'reservationId': '',
                                                        'isReserved': false,
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    )),
                                              ],
                                            ),
                                          ]))
                                ]));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));

  }
}
