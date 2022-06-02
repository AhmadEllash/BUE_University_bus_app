import 'package:bue_university_project/domain/cubit/user/user_cubit.dart';
import 'package:bue_university_project/presentation/resources/assets_manager.dart';
import 'package:bue_university_project/presentation/resources/routes_manager.dart';
import 'package:bue_university_project/presentation/user/edit_user_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllUsersView extends StatefulWidget {
  const AllUsersView({Key? key}) : super(key: key);

  @override
  _AllUsersViewState createState() => _AllUsersViewState();
}

class _AllUsersViewState extends State<AllUsersView> {

  var users;
  late List allUsers;
  bool state = true;

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('All Users'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, AppRoutes.addUserScreen);
        },
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if(state is GetAllUsersSLoadingState){
            return const Center(child: CircularProgressIndicator(),);
          }else if(state is GetAllUsersSuccessState){
            final users = state.users;
            return SafeArea(
              child: Container(
                decoration:   const BoxDecoration(
                  image:  DecorationImage(image :AssetImage(AppAssets.background), fit: BoxFit.cover,),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                      itemCount:users.length, itemBuilder: (context, index) {
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
                                    Text("userName :  "),

                                    Text(users[index].username ?? ""),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text("Role :  "),

                                    Text(users[index].role ?? ""),
                                  ],
                                ),

                              ],
                            ),
                          ),
                    Row(children: [
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditUserView(userName:users[index].username ,
                          password:users[index].password ,
                          email: users[index].email,
                          role: users[index].role,
                        )));//todo add route
                      }, icon: const Icon(Icons.edit)),
                      const SizedBox(width: 5,),
                      IconButton(onPressed: ()async{
                        await FirebaseFirestore.instance.collection('users').doc(users[index].uid).delete();
                      }, icon: const Icon(Icons.delete,color: Colors.red,)),
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

          }else if(state is GetAllUsersSFailedState){
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
