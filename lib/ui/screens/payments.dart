import 'package:dars_70_home/bloc/card_bloc/card_bloc.dart';
import 'package:dars_70_home/bloc/card_bloc/card_event.dart';
import 'package:dars_70_home/bloc/card_bloc/card_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  late String name;
  @override
  void initState() {
    super.initState();
    context.read<CardBloc>().add(GetAllMyChecks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CardBloc, CardState>(
        builder: (context, state){
          if (state is LoadingCardState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }

          if (state is GetAllMyChecksCardState) {
            return state.checks.length == 0 ? const Center(child: Text("Hozirda o'tkazmalar mavjud emas"),) : ListView.builder(
              itemCount: state.checks.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 180,
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sended card: ${state.checks[index].sendCard}",style: TextStyle(fontSize: 18,color: Colors.white),),
                      Text("Accept card: ${state.checks[index].acceptCard}",style: TextStyle(fontSize: 18,color: Colors.white),),
                      Text("Money:\$ ${state.checks[index].sum}",style: TextStyle(fontSize: 18,color: Colors.white),),
                      Text("Date: ${state.checks[index].date.day}/${state.checks[index].date.month}/${state.checks[index].date.year}",style: TextStyle(fontSize: 18,color: Colors.white),),
                    ],
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
