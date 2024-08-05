import 'package:dars_70_home/bloc/card_bloc/card_bloc.dart';
import 'package:dars_70_home/bloc/card_bloc/card_event.dart';
import 'package:dars_70_home/bloc/card_bloc/card_state.dart';
import 'package:dars_70_home/data/models/card.dart';
import 'package:dars_70_home/data/models/check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final _formKey = GlobalKey<FormState>();
  final _paymentCardController = TextEditingController();
  final _paymentSumController = TextEditingController();
  late CardModel card;
  String acceptCard = '';
  bool cardIsFind = false;
  int _selectPaymentCard = 0;
  CardModel? _paymentCardModel;
  String? error;
  
  @override
  void initState() {
    context.read<CardBloc>().add(GetGlobalCardEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment to Card"),
        centerTitle: true,

      ),
      body: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) {
          if (state is LoadingCardState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }

          if (state is LoadedCardState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Center(child: error == null ? const SizedBox() : Text("$error",style: TextStyle(fontSize: 18,color: Colors.red),),),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value){
                              if(value == null || value.trim().isEmpty){
                                return "Please,return input card number";
                              }
                              if(value.length != 16){
                                return "Card number length not 16";
                              }
              
                              try{
                                double.parse(value);
                              }catch(e){
                                return "Card number type no true";
                              }
                            },
                            keyboardType: TextInputType.number,
                            controller: _paymentCardController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: "Enter card number",
                            ),
                          ),
                          const SizedBox(height: 20,),
              
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FilledButton(onPressed: (){
                                setState(() {
                                  cardIsFind = false;
                                });
                                if(_formKey.currentState!.validate()){
                                  _formKey.currentState!.save();
                                  for(int i = 0;i < state.cards.length;i++){
                                    if(state.cards[i].number.toString().contains(_paymentCardController.text)){
                                      setState(() {
                                        card = state.cards[i];
                                        cardIsFind = true;
                                      });
                                      context.read<CardBloc>().add(GetAllCardEvent());
                                      break;
                                    }
                                  }
                                }
                              }, child: const Text("Card check"))
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30,),
              
                    cardIsFind ? Container(
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
                              Text("${card.fullName}",style: TextStyle(fontSize: 20,color: Colors.white),),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${card.number}",style: TextStyle(fontSize: 18,color: Colors.white),),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ) : const Center(child: Text("Card not found.",style: TextStyle(fontSize: 18,color: Colors.red),),),
              
                    const SizedBox(height: 50,),
              
                    cardIsFind ? TextFormField(
                      onChanged: (value){
                        if(value == null || value.trim().isEmpty){
                          setState(() {
                            error = "Payment sum empty";
                          });
                        }
              
                        try{
                          double.parse(value);
                          setState(() {
                            error = null;
                          });
                        }catch(e){
                          setState(() {
                            error = 'Payment sum type no true';
                          });
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: _paymentSumController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: "Payment sum",
                      ),
                    ) : const SizedBox(),
              
                    const SizedBox(height: 50,),
              
                    cardIsFind ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for(int i = 0;i < state.cards.length;i++)
                            InkWell(
                              onTap: (){
                                setState(() {
                                  _selectPaymentCard = i;
                                  _paymentCardModel = state.cards[i];
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                margin: const EdgeInsets.only(left: 10),
                                width: 300,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: _selectPaymentCard == i ? Colors.yellow : Colors.green,width: _selectPaymentCard == i ? 5 : 0)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("${state.cards[i].cardName}",style: const TextStyle(fontSize: 18,color: Colors.white),),
                                    Text("${state.cards[i].number}",style: const TextStyle(fontSize: 18,color: Colors.white,),),
                                    Text("\$${state.cards[i].balance}",style: const TextStyle(fontSize: 18,color: Colors.white,),)
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ) : const SizedBox(),


                    const SizedBox(height: 50,),

                    cardIsFind && _paymentSumController.text.isNotEmpty ? InkWell(
                      onTap: (){
                        if(cardIsFind && _formKey.currentState!.validate()){
                          setState(() {
                            context.read<CardBloc>().add(PaymentToCardEvent(Check(sendCard: _paymentCardModel!.number, acceptCard: int.parse(_paymentCardController.text), sum: double.parse(_paymentSumController.text), date: DateTime.now())));
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        child: const Text("Payment",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ) : const SizedBox(),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
