import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class MoreOptionsBottomSheet extends StatelessWidget {
  final Function onColorPress;

  MoreOptionsBottomSheet({
    @required this.onColorPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: moreOptions
          .map(
            (e) => ListTile(
              onTap: () {},
              title: Text(
                e.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: Icon(
                e.icon,
                color: Colors.black,
              ),
            ),
          )
          .toList(),
    );
  }
}
