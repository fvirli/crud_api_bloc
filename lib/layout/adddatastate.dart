import 'package:crud_api_bloc/bloc/add_ticket_bloc.dart';
import 'package:crud_api_bloc/bloc/login_bloc.dart';
import 'package:crud_api_bloc/layout/adddataform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'loading.dart';
import 'error.dart';

class AddState extends StatefulWidget {
  const AddState({super.key});

  @override
  State<AddState> createState() => _AddStateState();
}

class _AddStateState extends State<AddState> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTicketBloc, AddTicketState>(
        builder: (context, state) {
      if (state is AddTicketInitial) {
        return AddDataForm();
      } else if (state is AddTicketLoadingState) {
        return LoadingWidget();
      } else if (state is AddTicketSuccessState) {
        return AddDataForm();
      } else if (state is AddTicketErrorState) {
        return ErrorNotif(message: state.message);
      } else {
        return Container(
          child: Text("Error State"),
        );
      }
    });
  }
}
