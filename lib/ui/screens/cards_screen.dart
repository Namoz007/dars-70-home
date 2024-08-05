import 'package:dars_70_home/bloc/card_bloc/card_bloc.dart';
import 'package:dars_70_home/bloc/card_bloc/card_event.dart';
import 'package:dars_70_home/bloc/card_bloc/card_state.dart';
import 'package:dars_70_home/data/models/card.dart';
import 'package:dars_70_home/ui/widgets/add_card_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {

  @override
  void initState() {
    super.initState();
    context.read<CardBloc>().add(GetAllCardEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Cards"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              showDialog(context: context, builder: (context) => AddCardDialog(),barrierDismissible: false);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<CardBloc,CardState>(
        builder: (context,state){
          if(state is LoadingCardState){
            return const Center(child: CircularProgressIndicator(color: Colors.red,),);
          }

          if(state is LoadedCardState){
            return state.cards.length == 0 ? const Center(child: Text("Hozircha sizda kartalar mavjud emas"),) : ListView.builder(
              itemCount: state.cards.length,
              itemBuilder: (context, index) {
                CardModel card = state.cards[index];
                return Container(
                  width: double.infinity,
                  height: 220,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${card.cardName}",style: TextStyle(fontSize: 25,color: Colors.white),),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${card.fullName}",style: TextStyle(fontSize: 20,color: Colors.white),),
                              Text("\$${card.balance}",style: TextStyle(fontSize: 20,color: Colors.white),),
                              SizedBox()
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${card.number}",style: TextStyle(fontSize: 18,color: Colors.white),),
                              Text("${card.expiryDate.month}/${card.expiryDate.year}",style: TextStyle(fontSize: 18,color: Colors.white),)
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }


          return Container();
        },
      )
    );
  }
}
