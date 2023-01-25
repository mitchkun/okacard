import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:okacard/model/avatar.dart';
import 'package:checkmark/checkmark.dart';
import 'package:okacard/navigation/custom_tab_bar.dart';
import 'package:okacard/rive_app/theme.dart';
import 'package:okacard/screens/profile.dart';
import 'package:okacard/widgets/appbar.dart';
import 'package:rive/rive.dart' hide LinearGradient;
import 'package:okacard/rive_app/assets.dart' as app_assets;
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

Widget commonTabScene(String tabName) {
  return Container(
      color: RiveAppTheme.background,
      alignment: Alignment.center,
      child: Text(tabName,
          style: const TextStyle(
              fontSize: 28, fontFamily: "Poppins", color: Colors.black)));
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late SMITrigger _successAnim;
  late SMITrigger _errorAnim;
  late SMITrigger _confettiAnim;
  String scantxt = "Scanning";

  late AnimationController? _animationController;
  late Animation<double> _sidebarAnim;
  Widget _tabBody = Container(color: RiveAppTheme.background);
  final List<Widget> _screens = [
    HomeScreen(),
    commonTabScene("Search"),
    commonTabScene("Timer"),
    commonTabScene("Bell"),
    commonTabScene("User"),
  ];
  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 200), upperBound: 1, vsync: this)
      ..addListener(() {
        setState(() {});
      });
    _sidebarAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.linear,
    ));
  }

  bool _isLoading = false;
  void _onCheckRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    _successAnim = controller.findInput<bool>("Check") as SMITrigger;
    _errorAnim = controller.findInput<bool>("Error") as SMITrigger;
  }

  void _onConfettiRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    _confettiAnim =
        controller.findInput<bool>("Trigger explosion") as SMITrigger;
  }

  bool checked = false;
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
            Center(
                child: InkWell(
                    onTap: () {
                      ScanDialog();
                    },
                    child: _CardWidget())),
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
          ]),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, _sidebarAnim.value * 300),
        child: CustomTabBar(
          onTabChange: (tabIndex) {
            setState(
              () {
                _tabBody = _screens[tabIndex];
              },
            );
          },
        ),
      ),
      // ),
    );
  }

  ScanDialog() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 4), () {
      _successAnim.fire();
    });

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
        scantxt = "Complete";
      });
      _confettiAnim.fire();
    });
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.of(context)
          .pushReplacement(CupertinoPageRoute(builder: (_) => Profile()));
    });
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          backgroundColor: RiveAppTheme.background2,
          elevation: 50.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // CircularProgressIndicator(),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          if (_isLoading)
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: RiveAnimation.asset(
                                app_assets.checkRiv,
                                onInit: _onCheckRiveInit,
                              ),
                            ),
                          Positioned.fill(
                            child: SizedBox(
                              width: 500,
                              height: 500,
                              child: Transform.scale(
                                scale: 3,
                                child: RiveAnimation.asset(
                                  app_assets.confettiRiv,
                                  onInit: _onConfettiRiveInit,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Text(
                        scantxt,
                        style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w400,
                        ), //Textstyle
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _CardWidget() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 50,
      shadowColor: Colors.black12,
      color: RiveAppTheme.background2.withOpacity(0.8), //Colors.black,
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
