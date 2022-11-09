import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqllitedb/DatabaseHandler.dart';
import 'package:sqllitedb/ModUserDATA.dart';
import 'package:sqllitedb/userRepo.dart';

RxList<ModSaleOrderItems>? l_ListSaleOrderItems = <ModSaleOrderItems>[].obs;
late ModSaleOrderItems Mydata;

List<Map<String, dynamic>>? l_Userlist;

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  TextEditingController a1 = new TextEditingController();
  TextEditingController a2 = new TextEditingController();
  TextEditingController a3 = new TextEditingController();
  TextEditingController a4 = new TextEditingController();
  Database? _database;
  String TextFromFile = 'Empty';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFD1FFFF),
              Color(0xFF88ECF8),
              Color(0xFF65DCDC),
            ],
            stops: [0.1, 0.5, 0.7, 0.9],
          ),
        ),
        child: ResponsiveWrapper(
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: const [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: '4K'),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 70,
              ),
              const SizedBox(
                height: 29.0,
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Shimmer.fromColors(
                  baseColor: Colors.black12,
                  highlightColor: Colors.lightBlue.shade100,
                  child: Text(
                    "Data Insertion",
                    style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                            fontSize: 23,
                            color: Colors.lightBlue.shade100,
                            fontWeight: FontWeight.w600,
                            letterSpacing: .5)),
                  ),
                ),
              ),
              SizedBox(
                height: 77,
              ),
              IntrinsicHeight(
                child: Row(children: [
                  Flexible(
                    flex: 8,
                    child: SizedBox(
                      width: 43,
                    ),
                  ),
                  Flexible(
                    flex: 18,
                    child: TextFormField(
                      //obscureText: G_isSecurePassword,
                      controller: a1,
                      decoration: InputDecoration(
                        hintText: ' Name',
                        hintStyle: const TextStyle(color: Colors.black26),
                        labelText: ' Enter Name',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.white38)),
                        prefixIcon: const Icon(Icons.fingerprint,
                            size: 20, color: Colors.indigo),
                      ),
                    ),
                  ),
                  VerticalDivider(thickness: 1.5),
                  Flexible(
                    flex: 18,
                    child: TextFormField(
                      //obscureText: G_isSecurePassword,
                      controller: a2,
                      decoration: InputDecoration(
                        hintText: 'Address',
                        hintStyle: const TextStyle(color: Colors.black26),
                        labelText: ' Enter Address',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.white38)),
                        prefixIcon: const Icon(Icons.fingerprint,
                            size: 20, color: Colors.indigo),
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 8,
              ),
              const Divider(
                endIndent: 79,
                indent: 79,
                thickness: 1.5,
              ),
              IntrinsicHeight(
                child: Row(children: [
                  Flexible(
                    flex: 8,
                    child: SizedBox(
                      width: 43,
                    ),
                  ),
                  Flexible(
                    flex: 18,
                    child: TextFormField(
                      //obscureText: G_isSecurePassword,
                      controller: a3,
                      decoration: InputDecoration(
                        hintText: ' City',
                        hintStyle: const TextStyle(color: Colors.black26),
                        labelText: 'Enter City',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.white38)),
                        prefixIcon: const Icon(Icons.fingerprint,
                            size: 20, color: Colors.indigo),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(thickness: 1.5),
                  Flexible(
                    flex: 18,
                    child: TextFormField(
                      //obscureText: G_isSecurePassword,
                      controller: a4,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: const TextStyle(color: Colors.black26),
                        labelText: ' Enter Email',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.white38)),
                      ),
                    ),
                  ),
                ]),
              ),
              const Divider(
                endIndent: 79,
                indent: 79,
                thickness: 1.5,
              ),
              Row(children: [
                if (l_ListSaleOrderItems == null) ...[
                  const Text(""),
                ] else ...[
                  Expanded(
                    child: Obx(() => ListView.builder(
                          shrinkWrap: true,
                          itemCount: l_ListSaleOrderItems?.length,
                          itemBuilder: ((context, index) {
                            return Column(
                              children: [
                                SizedBox(
                                  width: 460,
                                  height: 79,
                                  child: Card(
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Stack(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Colors.white,
                                                      Colors.white
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                boxShadow: const [
                                              BoxShadow(
                                                offset: Offset(0, 4),
                                                color: Colors.teal,
                                                blurRadius: 10,
                                              )
                                            ])),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: ListView(
                                                children: [
                                                  ListTile(
                                                    isThreeLine: true,
                                                    leading: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SizedBox(
                                                          height: 48,
                                                          child:
                                                              VerticalDivider(
                                                            thickness: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    title: Wrap(
                                                        spacing: 8,
                                                        children: [
                                                          Text('Name:'),
                                                          Text(
                                                              l_ListSaleOrderItems!
                                                                  .value[index]
                                                                  .name),
                                                        ]),
                                                    subtitle: Wrap(
                                                        spacing: 8,
                                                        children: [
                                                          Text('Address:'),
                                                          Text(
                                                              l_ListSaleOrderItems!
                                                                  .value[index]
                                                                  .adddress),
                                                          Text('City:'),
                                                          Text(
                                                              l_ListSaleOrderItems!
                                                                  .value[index]
                                                                  .city),
                                                          Text('Email:'),
                                                          Text(
                                                              l_ListSaleOrderItems!
                                                                  .value[index]
                                                                  .email),
                                                        ]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        )),
                  ),
                ],
              ]),
              SizedBox(
                height: 7,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(130.0, 0.0, 130.0, 0.0),
                child: SizedBox(
                    width: 170,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.lightBlue.shade300,
                            Colors.lightBlue.shade400,
                            Colors.lightBlueAccent.shade400,
                            Colors.lightBlueAccent.shade400,

                            //add more colors
                          ]),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.57),
                                //shadow for button
                                blurRadius: 4.5) //blur radius of shadow
                          ]),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          disabledForegroundColor:
                              Colors.transparent.withOpacity(0.58),
                          disabledBackgroundColor:
                              Colors.transparent.withOpacity(0.12),
                          shadowColor: Colors.transparent,
                          //make color or elevated button transparent
                        ),
                        onPressed: () async {
                          FncAdd(a1.text, a2.text, a3.text, a4.text);
                          // FncInsertData(a1.text, a2.text, a3.text, a4.text);
                          //FncInsertData2(a1.text, a2.text, a3.text, a4.text);
                          // FncInsertt();
                          getData();
                          FncInsertt();
                        },
                        child: Text("Add Data",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: .5)),
                      ),
                    )),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(130.0, 0.0, 130.0, 0.0),
                child: SizedBox(
                    width: 170,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.lightBlue.shade300,
                            Colors.lightBlue.shade400,
                            Colors.lightBlueAccent.shade400,
                            Colors.lightBlueAccent.shade400,

                            //add more colors
                          ]),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.57),
                                //shadow for button
                                blurRadius: 4.5) //blur radius of shadow
                          ]),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          disabledForegroundColor:
                              Colors.transparent.withOpacity(0.58),
                          disabledBackgroundColor:
                              Colors.transparent.withOpacity(0.12),
                          shadowColor: Colors.transparent,
                          //make color or elevated button transparent
                        ),
                        onPressed: () async {
                          FncGetUserData();
                        },
                        child: Text("Read Data",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: .5)),
                      ),
                    )),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(130.0, 0.0, 130.0, 0.0),
                child: SizedBox(
                    width: 170,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.lightBlue.shade300,
                            Colors.lightBlue.shade400,
                            Colors.lightBlueAccent.shade400,
                            Colors.lightBlueAccent.shade400,

                            //add more colors
                          ]),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.57),
                                //shadow for button
                                blurRadius: 4.5) //blur radius of shadow
                          ]),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          disabledForegroundColor:
                              Colors.transparent.withOpacity(0.58),
                          disabledBackgroundColor:
                              Colors.transparent.withOpacity(0.12),
                          shadowColor: Colors.transparent,
                          //make color or elevated button transparent
                        ),
                        onPressed: () async {
                          FncUpdateData();
                        },
                        child: Text("Update Data",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: .5)),
                      ),
                    )),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(130.0, 0.0, 130.0, 0.0),
                child: SizedBox(
                    width: 170,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.lightBlue.shade300,
                            Colors.lightBlue.shade400,
                            Colors.lightBlueAccent.shade400,
                            Colors.lightBlueAccent.shade400,

                            //add more colors
                          ]),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.57),
                                //shadow for button
                                blurRadius: 4.5) //blur radius of shadow
                          ]),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          disabledForegroundColor:
                              Colors.transparent.withOpacity(0.58),
                          disabledBackgroundColor:
                              Colors.transparent.withOpacity(0.12),
                          shadowColor: Colors.transparent,
                          //make color or elevated button transparent
                        ),
                        onPressed: () async {
                          FncDeleteData();
                        },
                        child: Text("Delete Data",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: .5)),
                      ),
                    )),
              ),
              SizedBox(height: 12),
              Container(
                height: 200,
                width: 200,
                child: Text(TextFromFile),
              )
            ],
          ),
        ),
      ),
    );
  }

  FncAdd(String nam, String adr, String cit, String eml) {
    Mydata =
        new ModSaleOrderItems(name: nam, adddress: adr, city: cit, email: eml);
    l_ListSaleOrderItems?.add(Mydata);
    print(Mydata);
  }

  Future<Database?> FncOpenDB() async {
    Directory path = await getApplicationDocumentsDirectory();

    _database = await DatabaseHelper().openDB();
    return _database;
  }

  Future<void> FncInsertData(
      String nam, String adr, String cit, String eml) async {
    _database = await FncOpenDB();
    UserRepo l_UserRepo = new UserRepo();
    l_UserRepo.FncCreateTable(_database);
    ModSaleOrderItems l_ModSaleOrderItems =
        new ModSaleOrderItems(name: nam, adddress: adr, city: cit, email: eml);

    print("Add Data");

    await _database?.insert('User', l_ModSaleOrderItems.toMap());
    await _database?.close();
  }

  Future<void> FncInsertt() async {
    _database = await FncOpenDB();
    UserRepo l_UserRepo = new UserRepo();
    l_UserRepo.FncCreateTable(_database);

    await _database?.transaction((l_transaction) async {
      await l_transaction.rawQuery(
          "INSERT INTO User(name, adddress, city,email) VALUES( 'SS', 'Karachi', 'Pakistan','iam.umairimran@gmail.com')");

      await l_transaction.rawQuery('UPDATE User SET name = "Yousaf" WHERE name = "CC"');

      await l_transaction.rawQuery('DELETE FROM User WHERE name = "RR"');


      //await l_transaction.rawQuery(
         // "INSERT INTO User(name, adddress, city,email) VALUES( 'CC', 'Lahore', 'Pakistan','iam.umairimran@gmail.com');  ");

      await l_transaction.rawQuery("Select 1/0");
    });
    print(" Data Inserted");

    // print(TextFromFile);
    //await _database?.rawQuery(TextFromFile);

    await _database?.close();
  }

  Future<void> FncUpdateData() async {
    _database = await FncOpenDB();
    UserRepo l_UserRepo = new UserRepo();
    l_UserRepo.FncCreateTable(_database);
    print("Update Data");
    await _database
        ?.rawUpdate('UPDATE User SET name = "Yousaf" WHERE name = "Rizwan"');

    await _database?.close();
  }

  Future<void> FncDeleteData() async {
    _database = await FncOpenDB();
    UserRepo l_UserRepo = new UserRepo();
    l_UserRepo.FncCreateTable(_database);
    print("Delete Data");
    await _database?.rawDelete('DELETE FROM User WHERE name = "Hamza"');

    await _database?.close();
  }

  Future<void> FncGetUserData() async {
    _database = await FncOpenDB();
    UserRepo l_UserRepo = new UserRepo();
    l_Userlist = await l_UserRepo.FncGetDataDB(_database);

    await _database?.close();
  }

  getData() async {
    String response;
    response = await rootBundle.loadString('text_notes/text');

    setState(() {
      TextFromFile = response;
    });
  }
}

Widget BuildUserList() {
  return Expanded(
    child: ListView.builder(itemBuilder: (BuildContext context, int index) {
      return Text("USER NAME${l_Userlist?[index]['name']}");
    }),
  );
}
