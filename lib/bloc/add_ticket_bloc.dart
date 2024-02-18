import 'package:bloc/bloc.dart';
import 'package:crud_api_bloc/bloc/login_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:crud_api_bloc/repository/ticket_repository.dart';
import 'dart:io';

part 'add_ticket_event.dart';
part 'add_ticket_state.dart';

class AddTicketBloc extends Bloc<AddTicketEvent, AddTicketState> {
  TicketRepository ticketRepository;

  AddTicketBloc({required this.ticketRepository}) : super(AddTicketInitial()) {
    on<AddTicketInitialEvent>(_addticketinitial);
    on<ClickTombolAddEvent>(_addticketclick);
  }

  void _addticketinitial(
      AddTicketInitialEvent event, Emitter<AddTicketState> emit) {
    emit(AddTicketLoadingState());
    emit(AddTicketInitial());
  }

  void _addticketclick(
      ClickTombolAddEvent event, Emitter<AddTicketState> emit) async {
    final String judul = event.title;
    final String deskripsi = event.desc;
    final String tanggal = event.date;
    final File gambar = event.image;
    emit(AddTicketLoadingState());
    try {
      final result = await ticketRepository.addTicket(
        title: judul,
        desc: deskripsi,
        date: tanggal,
        image: gambar,
        name: '',
      );
      emit(AddTicketSuccessState());
      await Future.delayed(
          Duration(seconds: 3)); // Merubah second menjadi seconds
      emit(AddTicketInitial());
    } catch (error) {
      emit(AddTicketErrorState(
          message: "Error $error")); // Mengirim AddTicketErrorState
    }
  }
}
