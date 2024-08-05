import 'package:bloc/bloc.dart';
import 'package:dars_70_home/bloc/card_bloc/card_event.dart';
import 'package:dars_70_home/bloc/card_bloc/card_state.dart';
import 'package:dars_70_home/data/repositorys/card_repositories.dart';

import '../../data/models/card.dart';

class CardBloc extends Bloc<CardEvent,CardState>{
  final CardRepositories _repositories;
  List<CardModel> _cards = [];
  CardBloc({required CardRepositories repo}) : _repositories = repo,super(InitialCardState()){
    on<AddCardEvent>(_addCart);
    on<GetAllCardEvent>(_getAllMyCards);
    on<PaymentToCardEvent>(_paymentToCard);
    on<GetGlobalCardEvent>(_getGlobalCards);
    on<GetAllMyChecks>(_getAllMyChecks);
    on<GetLoading>(_getLoading);
  }

  void _getLoading(GetLoading event,emit){
    emit(LoadingCardState());
  }

  void _getAllMyChecks(GetAllMyChecks event,emit) async{
    emit(LoadingCardState());
    emit(GetAllMyChecksCardState(await _repositories.getAllMyChecks()));
  }

  void _getGlobalCards(GetGlobalCardEvent event,emit) async{
    emit(LoadingCardState());
    emit(LoadedCardState(await _repositories.getAllCards()));
  }

  void _paymentToCard(PaymentToCardEvent event,emit) async{
    emit(LoadingCardState());
    await _repositories.paymentToCard(event.check);
    add(GetAllCardEvent());
  }


  void _getAllMyCards(GetAllCardEvent event,emit) async{
    emit(LoadingCardState());
    emit(LoadedCardState(await _repositories.getAllMyCards()));
  }

  void _addCart(AddCardEvent event,emit) async{
    emit(LoadingCardState());
    await _repositories.addCard(event.model);
    add(GetAllCardEvent());
  }
}