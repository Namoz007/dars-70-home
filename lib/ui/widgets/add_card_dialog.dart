import 'package:dars_70_home/bloc/card_bloc/card_bloc.dart';
import 'package:dars_70_home/bloc/card_bloc/card_event.dart';
import 'package:dars_70_home/data/models/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCardDialog extends StatefulWidget {
  const AddCardDialog({super.key});

  @override
  State<AddCardDialog> createState() => _AddCardDialogState();
}

class _AddCardDialogState extends State<AddCardDialog> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _cardNameController = TextEditingController();
  DateTime? _expiryDate;
  final _cardNumberController = TextEditingController();
  final _cardBalanceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add new Card"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "Please, return enter full name";
                    }
        
                    return null;
                  },
                  controller: _fullNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Full Name",),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "Please, return enter card name";
                    }
        
                    return null;
                  },
                  controller: _cardNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: "Card Name",),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "Please, return input card number";
                    }
        
                    if(value.length != 16){
                      return "Card number length not 16";
                    }
        
                    try{
                      int.parse(value);
                      return null;
                    }catch(e){
                      return "Card number type not number";
                    }
                  },
                  controller: _cardNumberController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Card Number",),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return "Please,return input card balance";
                    }
        
                    try{
                      double.parse(value);
                      return null;
                    }catch(e){
                      return "Card balance type not number";
                    }
                  },
                  controller: _cardBalanceController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: "Card Balance",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    _expiryDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2025),
                      firstDate: DateTime(2025),
                      lastDate: DateTime(2030),
                    );
                    setState(() {
        
                    });
                  },
                  child: Center(
                    child: _expiryDate == null
                        ? Text("Card expiry date")
                        : Text("${_expiryDate!.month}/${_expiryDate!.year}"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        FilledButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("Cancel"),),
        FilledButton(onPressed: () async{
          if(_formKey.currentState!.validate() && _expiryDate != null){
            context.read<CardBloc>().add(AddCardEvent(CardModel(id: UniqueKey().toString(), fullName: _fullNameController.text,cardName: _cardNameController.text, number: int.parse(_cardNumberController.text), expiryDate: _expiryDate!, balance: double.parse(_cardBalanceController.text,),),),);
            _formKey.currentState!.save();
            Navigator.pop(context);
          }
        }, child: const Text("Save"),),
      ],
    );
  }
}
