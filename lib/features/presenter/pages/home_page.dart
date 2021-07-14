import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nasa_clean_arch/features/presenter/pages/picture_page.dart';
import 'package:nasa_clean_arch/features/presenter/widgets/custom_app_bar.dart';
import 'package:nasa_clean_arch/features/presenter/widgets/round_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'APOD'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Welcome to Astronomy Picture of the Day!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  height: 150,
                ),
                RoundButton(
                  label: "Select datetime",
                  onTap: () async {
                    var datePicked = await showDatePicker(
                      helpText: "Select a datetime",
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1995, 06, 16),
                      lastDate: DateTime.now(),
                    );
                    PicturePage.navigate(datePicked);
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
