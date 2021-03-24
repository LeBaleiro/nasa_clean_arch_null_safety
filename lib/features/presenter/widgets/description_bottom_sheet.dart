import 'package:flutter/material.dart';

void showDescriptionBottomSheet({
  required BuildContext context,
  required String title,
  required String description,
}) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF3E4C5C).withOpacity(0.9),
      builder: (_) {
        return ListView(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
        ]);
      });
}
