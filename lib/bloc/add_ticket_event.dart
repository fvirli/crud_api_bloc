part of 'add_ticket_bloc.dart';

@immutable
sealed class AddTicketEvent extends Equatable {}

final class AddTicketInitialEvent extends AddTicketEvent {
  @override
  List<Object> get props => [];
}

final class ClickTombolAddEvent extends AddTicketEvent {
  final String title;
  final String desc;
  final String date;
  final File image;

  ClickTombolAddEvent(
      {required this.title,
      required this.desc,
      required this.date,
      required this.image});
  @override
  List<Object> get props => [title, desc, date, image];
}
