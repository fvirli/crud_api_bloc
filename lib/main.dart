import 'package:crud_api_bloc/bloc/add_ticket_bloc.dart';
import 'package:crud_api_bloc/bloc/login_bloc.dart';
import 'package:crud_api_bloc/repository/ticket_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repository/login_repository.dart';
import 'layout/mainstate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => LoginRepository()),
          RepositoryProvider(create: (context) => TicketRepository()),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: ((context) => LoginBloc(
                      loginRepository: context.read<LoginRepository>())
                    ..add(LoginInitialEvent()))),
              BlocProvider(
                  create: ((context) => AddTicketBloc(
                      ticketRepository: context.read<TicketRepository>())
                    ..add(AddTicketInitialEvent()))),
            ],
            child: MaterialApp(
              title: "Ticket_App",
              home: MainState(),
            )));
  }
}
