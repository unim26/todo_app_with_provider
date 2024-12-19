import 'package:flutter/material.dart';

Future showMyDialog({
  BuildContext? context,
  double? sWidth,
  TextEditingController? controller,
  String? buttonname,
  void Function()? onPressed,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context!,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //title
            Text(
              "Add todo",
              style: TextStyle(
                fontSize: sWidth! * .05,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(
              height: sWidth * .05,
            ),

            //textfield
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "task name...",
                labelText: "task name....",
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),

            SizedBox(
              height: sWidth * .05,
            ),

            //buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //cancel button
                ElevatedButton(
                  onPressed: () {
                    //cancel button
                    Navigator.pop(context);
                    controller!.clear();
                  },
                  child: Text(
                    "cancel",
                  ),
                ),

                SizedBox(
                  width: sWidth * .03,
                ),

                //add button
                ElevatedButton(
                  onPressed: onPressed,
                  child: Text(
                    buttonname!,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
