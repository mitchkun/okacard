import 'package:flutter/material.dart';

class AppBarContent extends StatelessWidget {
  const AppBarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.menu,
                color: Colors.black,
                size: 32.0,
              ),
              Image.asset('assets/images/banner_logo_black.png', height: 50),
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
