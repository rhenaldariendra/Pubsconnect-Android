import 'package:flutter/material.dart';

class LocationListTile extends StatelessWidget {
  final String location;
  final VoidCallback press;

  const LocationListTile({super.key, required this.location, required this.press});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          horizontalTitleGap: 0,
          leading: Icon(Icons.my_location_outlined),
          title: Text(
            location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        const Divider(
          height: 2,
          thickness: 1,
          color: Colors.grey,
        ),
      ],
    );
  }
}
