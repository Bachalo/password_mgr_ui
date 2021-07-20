//

import 'package:chrome_extension/services/models/response_model.dart';
import 'package:chrome_extension/services/services.dart';
import 'package:flutter/material.dart';

class AddNewPopup extends StatelessWidget {
  const AddNewPopup({required this.url, Key? key}) : super(key: key);

  final String url;
  @override
  Widget build(BuildContext context) {
    final TextEditingController newEmailTextController =
        TextEditingController();
    final TextEditingController newPasswordTextController =
        TextEditingController();

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: const Text(
        "Add new password",
        style: TextStyle(color: Colors.cyan),
      ),
      content: SizedBox(
        height: 400,
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 450,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.length <= 1) {
                            return "Please enter a email";
                          }
                          return null;
                        },
                        controller: newEmailTextController,
                        style: const TextStyle(
                          color: Colors.cyan,
                        ),
                        decoration: InputDecoration(
                          focusColor: Colors.cyan,
                          fillColor: Colors.grey.withOpacity(0.1),
                          filled: true,
                          border: const OutlineInputBorder(),
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Colors.cyan),
                          hoverColor: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 450,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.length <= 7) {
                            return "Please enter a password";
                          }
                          return null;
                        },
                        controller: newPasswordTextController,
                        obscureText: true,
                        style: const TextStyle(
                          color: Colors.cyan,
                        ),
                        decoration: InputDecoration(
                          focusColor: Colors.cyan,
                          fillColor: Colors.grey.withOpacity(0.1),
                          filled: true,
                          border: const OutlineInputBorder(),
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.cyan),
                          hoverColor: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close),
                  ),
                  TextButton(
                    onPressed: () async {
                      final ResponseMessage message = await Services.addNew(
                        newPasswordTextController.text,
                        newEmailTextController.text,
                        url,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message.response),
                        ),
                      );
                    },
                    child: const Icon(Icons.add),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
