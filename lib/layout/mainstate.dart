import 'package:crud_api_bloc/bloc/add_ticket_bloc.dart';
import 'package:crud_api_bloc/layout/dashboard.dart';
import 'package:crud_api_bloc/layout/loginform.dart';
import 'package:crud_api_bloc/layout/error.dart';
import 'package:flutter/material.dart';
import 'error.dart';
import 'loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';

class MainState extends StatelessWidget {
  const MainState({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginInitial) {
          return LoginFormWidget();
        } else if (state is LoadingLogin) {
          return LoadingWidget();
        } else if (state is LoginSuccess) {
          return Dashboard(
            name: state.name,
          );
        } else if (state is LoginFailed) {
          return ErrorNotif(message: state.message);
        } else {
          return Container(
            child: Text("Error State"),
          );
        }
      },
    );
  }
}
