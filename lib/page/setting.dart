// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, unused_local_variable

import 'package:certif_mobile_stuff/dir/DBHelper.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  DBHelper dbHelper = DBHelper();

  // Dummy data for the profile
  String profileImage = 'assets/images/me.jpeg';
  String name = 'Ilham Sinatrio Gumelar';
  String kelas = 'SIB 4E';
  String nim = '2141764031';
  String creationDate = '29 September 2023';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Password'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Email input field
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),

            // New password input field
            TextFormField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
            ),
            SizedBox(height: 16.0),

            // Button to submit password change
            ElevatedButton(
              onPressed: () {
                // Handle password change here
                String email = emailController.text;
                String newPassword = newPasswordController.text;

                // Add your password change logic here
                var result = dbHelper.updatePassword(email, newPassword);
                if (result != 0) {
                  Navigator.pop(context);
                }
                // Clear the text fields
                emailController.clear();
                newPasswordController.clear();
              },
              child: Text('Change Password'),
            ),

            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back')),
            SizedBox(height: 32.0),
            // Profile section
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage(profileImage),
            ),
            SizedBox(height: 16.0),
            Text('Nama: $name', style: TextStyle(fontSize: 16.0)),
            Text('Kelas: $kelas', style: TextStyle(fontSize: 16.0)),
            Text('NIM: $nim', style: TextStyle(fontSize: 16.0)),
            Text('Tanggal Pembuatan: $creationDate',
                style: TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}
