import 'package:flutter/material.dart';
import 'package:okacard/model/avatar.dart';

import 'package:okacard/widgets/appbar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: const AppBarContent(),
          ),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                height: 140.0,
                child: ListView.separated(
                  itemCount: 3,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 10,
                    );
                  },
                  itemBuilder: (_, i) => Avatar(avatarStr: i),
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Center(child: _CardWidget()),
              const SizedBox(
                height: 20,
              ),
              Center(child: Icon(Icons.qr_code_scanner, size: 100)),
              Center(
                  child: Text(
                'SCAN QR CODE',
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w400,
                ), //Textstyle
              )),
            ])
        // ),
        );
  }

  Widget _CardWidget() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 50,
      shadowColor: Colors.black12,
      color: Colors.black,
      child: SizedBox(
        width: 300,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
              child: Column(
            children: [
              Text(
                'TAP CARD',
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.w500,
                ), //Textstyle
              ),
              Image.asset('assets/images/scan.png', height: 120),
            ],
          )), //Column
        ), //Padding
      ), //SizedBox
    );
  }
}
