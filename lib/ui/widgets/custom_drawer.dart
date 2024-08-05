import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(),
            InkWell(
              onTap: (){
                FirebaseAuth.instance.signOut();
              },
              child: Row(
                children: [
                  Text("Log Out",style: TextStyle(fontSize: 18,),),
                  SizedBox(width: 20,),
                  Icon(Icons.logout)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
