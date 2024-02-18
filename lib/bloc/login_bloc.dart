import 'package:bloc/bloc.dart';
import 'package:crud_api_bloc/repository/login_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepository;
  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<LoginInitialEvent>(_initialevent);
    on<ProsesLogin>(_prosesloginevent);
    on<ProsesLogout>(_proseslogoutevent);
  }

  _initialevent(LoginInitialEvent event, Emitter emit) async {
    emit(LoginInitial());
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String sessionToken = preferences.getString('session') ?? "";
    final String sessionName = preferences.getString('name') ?? "";
    if (sessionToken == "") {
      emit(LoginInitial());
    } else {
      bool result = await loginRepository.checkSession(sessionToken);
      if (result == true) {
        emit(LoginSuccess(session: sessionToken, name: sessionName));
      } else {
        emit(LoginInitial());
      }
    }
  }

  _prosesloginevent(ProsesLogin event, Emitter emit) async {
    String username = event.username;
    String password = event.password;
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String sessionName = preferences.getString('name') ?? "";
    emit(LoadingLogin());
    //conditional
    Map res =
        await loginRepository.login(username: username, password: password);
    if (res['status'] == true) {
      emit(LoginSuccess(
          session: res['data']['session_token'], name: sessionName));
    } else {
      emit(LoginFailed(message: "Gagal login:" + res['data']['message']));
    }
  }

  _proseslogoutevent(ProsesLogout event, Emitter emit) async {
    emit(LoadingLogin());
    await loginRepository.logout();
    emit(LoginInitial());
    //conditional
  }
}
