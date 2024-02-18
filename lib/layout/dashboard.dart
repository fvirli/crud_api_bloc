import 'package:flutter/material.dart';
import '../bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'adddatastate.dart';

class Dashboard extends StatefulWidget {
  final String name;
  const Dashboard({required this.name});

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ticket App"),
      ),
      body: Column(
        children: <Widget>[
          Text("Selamat datang " + widget.name + " di Ticket App"),
          ElevatedButton(
              onPressed: () {
                context.read<LoginBloc>().add(ProsesLogout());
              },
              child: Text("Logout")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddState()));
              },
              child: Text("Tambah Data")),
        ],
      ),
    );
  }
}
