part of 'add_ticket_bloc.dart';

@immutable
sealed class AddTicketState extends Equatable {}

final class AddTicketInitial extends AddTicketState {
  @override
  List<Object> get props => [];
}

final class AddTicketLoadingState extends AddTicketState {
  @override
  List<Object> get props => [];
}

final class AddTicketSuccessState extends AddTicketState {
  @override
  List<Object> get props => [];
}

final class AddTicketErrorState extends AddTicketState {
  String message;

  AddTicketErrorState({required this.message});
  @override
  List<Object> get props => [];
}
