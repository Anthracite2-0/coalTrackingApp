import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

  const ProfileListItem({
    super.key,
    required this.icon,
    this.text = "",
    this.hasNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Container(
      height: width * 0.13,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.15,
      ).copyWith(
        bottom: width * 0.035,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.3),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: width * 0.07,
            color: Colors.black,
          ),
          SizedBox(width: width * 0.04),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          if (hasNavigation)
            Icon(
              LineAwesomeIcons.angle_right,
              size: width * 0.07,
            ),
        ],
      ),
    );
  }
}
