import 'package:flutter/material.dart';

class Avatar extends StatefulWidget {
  final int avatarStr;
  const Avatar({
    Key? key,
    required this.avatarStr,
  }) : super(key: key);

  @override
  AvatarState createState() => AvatarState();
}

class AvatarState extends State<Avatar> {
  static const List<String> urls = [
    "https://gravatar.com/avatar/17f2aaf83563cc792954abad7e3b9bc2?s=400&d=robohash&r=x",
    "https://gravatar.com/avatar/6e7db8b5e40de27a6c8087b27b0e10f0?s=400&d=robohash&r=x",
    "https://media.licdn.com/dms/image/C4D03AQGVMxKtGo8d1Q/profile-displayphoto-shrink_200_200/0/1583928044629?e=1679529600&v=beta&t=WPxNmDaVtJ9ACGc9PCtEAfFO54rg00oZ5c1WtdsGg7M"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 120.0,
        height: 120.0,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        child: CircleAvatar(
          backgroundImage: NetworkImage(urls[widget.avatarStr]),
        ),
      ),
      const SizedBox(
        height: 2,
      ),
      Text("User ${widget.avatarStr + 1}")
    ]);
  }
}
