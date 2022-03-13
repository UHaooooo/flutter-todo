import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/db_helper.dart';
import 'home.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();

    setupDbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromARGB(255, 20, 33, 61),
        body: Center(
          child: SpinKitFadingCircle(
            color: Color.fromARGB(255, 252, 163, 17),
            size: 40.0,
          ),
        ));
  }

  void setupDbHelper() async {
    await dbHelper.initDb();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home(dbHelper: dbHelper)),
    );
  }
}
