import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../view_model/logout_view_model.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<LoadLogoutProfile>(_onLoadLogoutProfile);
    on<UpdatePersonalInfo>(_onUpdatePersonalInfo);
    on<ToggleLinkedAccount>(_onToggleLinkedAccount);
    on<UpdateAvatar>(_onUpdateAvatar);
  }

  Future<void> _onLoadLogoutProfile(LoadLogoutProfile event, Emitter<LogoutState> emit) async {
    emit(LogoutLoading());
    
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      final viewModel = LogoutViewModel.initial();
      emit(LogoutLoaded(viewModel));
    } catch (e) {
      emit(LogoutError(e.toString()));
    }
  }

  void _onUpdatePersonalInfo(UpdatePersonalInfo event, Emitter<LogoutState> emit) {
    if (state is LogoutLoaded) {
      final currentState = state as LogoutLoaded;
      final updatedViewModel = currentState.viewModel.copyWith(
        name: event.name,
        phone: event.phone,
        email: event.email,
        gender: event.gender,
      );
      emit(LogoutLoaded(updatedViewModel));
    }
  }

  void _onToggleLinkedAccount(ToggleLinkedAccount event, Emitter<LogoutState> emit) {
    if (state is LogoutLoaded) {
      final currentState = state as LogoutLoaded;
      final updatedAccounts = Map<String, bool>.from(currentState.viewModel.linkedAccounts);
      updatedAccounts[event.platform] = event.isLinked;
      
      final updatedViewModel = currentState.viewModel.copyWith(
        linkedAccounts: updatedAccounts,
      );
      emit(LogoutLoaded(updatedViewModel));
    }
  }

  void _onUpdateAvatar(UpdateAvatar event, Emitter<LogoutState> emit) {
    if (state is LogoutLoaded) {
      final currentState = state as LogoutLoaded;
      final updatedViewModel = currentState.viewModel.copyWith(
        avatarUrl: event.avatarUrl,
      );
      emit(LogoutLoaded(updatedViewModel));
    }
  }
}