import 'package:flutter/material.dart';

class PopUpMenu extends StatelessWidget {
  final bool isTeacher;
  const PopUpMenu({
    Key? key,
    required this.isTeacher,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        if (value == 'Edit') {}
        if (value == 'Update') {}
        if (value == 'Report') {}
      },
      itemBuilder: (context) => isTeacher
          ? [
              const PopupMenuItem(
                value: 'Edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem(
                value: 'Update',
                child: Text('Update'),
              ),
            ]
          : [
              const PopupMenuItem(
                value: 'Report',
                child: Text('Report Abuse'),
              ),
            ],
    );
  }
}
