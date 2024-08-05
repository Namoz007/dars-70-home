import 'package:dars_70_home/ui/screens/cards_screen.dart';
import 'package:dars_70_home/ui/screens/payment.dart';
import 'package:dars_70_home/ui/screens/payments.dart';
import 'package:dars_70_home/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _screenIndex = 0;
  List<Widget> _screens = [
    CardsScreen(),
    Payment(),
    Payments()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text("Online Bank"),
        centerTitle: true,
      ),
      body: _screens[_screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.credit_card_sharp,color: _screenIndex == 0 ? Colors.green : Colors.blue,),label: "Cards"),
          
          BottomNavigationBarItem(icon: Icon(Icons.payments_outlined,color: _screenIndex == 1 ? Colors.green : Colors.blue,),label: "Payment"),
          
          BottomNavigationBarItem(icon: Icon(Icons.payments_sharp,color: _screenIndex == 2 ? Colors.green : Colors.blue,),label: "Payments")
        ],
        onTap: (value){
          setState(() {
            _screenIndex = value;
          });
        },
      ),
    );
  }
}
