import 'package:bue_university_project/domain/cubit/buses/bus_cubit.dart';
import 'package:bue_university_project/domain/cubit/user/user_cubit.dart';
import 'package:bue_university_project/presentation/bus_numbers/edit_bus_number.dart';
import 'package:bue_university_project/presentation/resources/assets_manager.dart';
import 'package:bue_university_project/presentation/resources/routes_manager.dart';
import 'package:bue_university_project/presentation/user/edit_user_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllBusView extends StatefulWidget {
  const AllBusView({Key? key}) : super(key: key);

  @override
  _AllBusViewState createState() => _AllBusViewState();
}

class _AllBusViewState extends State<AllBusView> {

  var users;
  late List allUsers;
  bool state = true;

  @override
  void initState() {
    BlocProvider.of<BusCubit>(context).getAllBuses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('All Buses'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, AppRoutes.addBusRoute);
        },
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<BusCubit, BusState>(
        builder: (context, state) {
          if(state is GetAllBusesLoadingState){
            return const Center(child: CircularProgressIndicator(),);
          }else if(state is GetAllBusesSuccessState){
            final buses = state.buses;
            return SafeArea(
              child: Container(
                decoration:  const BoxDecoration(
                  image:  DecorationImage(image :AssetImage(AppAssets.background), fit: BoxFit.cover,),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    itemCount:buses.length, itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height:0.14 * h ,
                      color: Colors.black26,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text("Bus Number :  "),

                                    Text(buses[index].busNumber ?? ""),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text("Start From :  "),

                                    Text(buses[index].destination ?? ""),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          Row(children: [
                            IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditBusNumberView(
                                busNumber:buses[index].busNumber ,
                                destination: buses[index].destination,
                                time:buses[index].time ,
                              )));
                            }, icon: const Icon(Icons.edit)),
                            const SizedBox(width: 5,),
                            // IconButton(onPressed: (){
                            //
                            // }, icon: const Icon(Icons.delete,color: Colors.red,)),
                          ],),

                        ],
                      ),
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                    return  SizedBox(
                      height: 10,
                    );
                  },),
                ),
              ),
            );

          }else if(state is GetAllBusesFailedState){
            return  Center(child: Text(state.errorMessage),);
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
