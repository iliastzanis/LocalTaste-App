import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_taste/components/user_details_field.dart';
import 'package:local_taste/utils/theme_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //current user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //all users
  final usersCollection = FirebaseFirestore.instance.collection('users');

  //edit user details
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[50],
        title: Text(
          'Edit ' + field,
          style: TextStyle(color: AppColor().lightColors.shade900),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: AppColor().lightColors.shade900),
          decoration: InputDecoration(
            hintText: 'Enter new $field',
            hintStyle: TextStyle(color: AppColor().lightColors.shade700),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColor().lightColors.shade500),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: Text(
              'Save',
              style: TextStyle(color: AppColor().lightColors.shade500),
            ),
          ),
        ],
      ),
    );
    //update fields on firestore
    if (newValue.trim().length > 0) {
      //only update if there is a value
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  // Sign out user on press
  void signUserOut() async {
    // Clear the favoritedRecipes and favoritedProducts lists from SharedPreferences
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('favoritedRecipes');
    preferences.remove('favoritedProducts');

    // Sign out the user from FirebaseAuth
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Local',
                style: TextStyle(
                  color: AppColor().lightColors.shade500,
                  fontSize: 25,
                ),
              ),
              TextSpan(
                text: 'Taste',
                style: TextStyle(
                  color: AppColor().lightColors.shade900,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: signUserOut,
              icon: Icon(
                Icons.logout,
                color: AppColor().lightColors.shade900,
                size: 25,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          //get user data
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return ListView(
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundColor: AppColor().lightColors.shade500,
                    minRadius: 60.0,
                    child: CircleAvatar(
                      radius: 58.0,
                      backgroundImage:
                          AssetImage('assets/images/DefaultUserLogo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'User Details',
                  style: TextStyle(
                      color: AppColor().lightColors.shade900, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                UserDetailsFields(
                  sectionName: 'Username',
                  text: userData['username'],
                  onPressed: () => editField('username'),
                ),
                UserDetailsFields(
                  sectionName: 'First name',
                  text: userData['first name'],
                  onPressed: () => editField('first name'),
                ),
                UserDetailsFields(
                  sectionName: 'Last name',
                  text: userData['last name'],
                  onPressed: () => editField('last name'),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor().lightColors.shade100,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                  ),
                  padding: EdgeInsets.only(
                    left: 15,
                    bottom: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Email',
                        style:
                            TextStyle(color: AppColor().lightColors.shade500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //text
                      Text(
                        currentUser.email.toString(),
                        style:
                            TextStyle(color: AppColor().lightColors.shade900),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
