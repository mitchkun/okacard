import 'package:flutter/material.dart';

class AppBarContent extends StatelessWidget {
  const AppBarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: <Widget>[
              IconButton(
                alignment: Alignment.bottomCenter,
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                  size: 36.0,
                ),
                onPressed: () {},
              ),
              Container(
                child: Center(
                    child: Image.asset('assets/images/banner_logo_black.png',
                        height: 40)),
              ),
              const Spacer(),
              IconButton(
                alignment: Alignment.centerRight,
                icon: const Icon(
                  Icons.search,
                  size: 40,
                  color: Colors.black,
                ),
                color: Colors.white,
                onPressed: () {},
              ),
              IconButton(
                alignment: Alignment.centerRight,
                icon: const Icon(
                  Icons.toggle_on_outlined,
                  size: 40,
                  color: Colors.black,
                ),
                color: Colors.white,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
