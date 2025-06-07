import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../view_model/profile_view_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateTab>(_onUpdateTab);
    on<NavigateToService>(_onNavigateToService);
  }

  Future<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      final viewModel = ProfileViewModel.initial();
      emit(ProfileLoaded(viewModel));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void _onUpdateTab(UpdateTab event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      final updatedViewModel = currentState.viewModel.copyWith(
        selectedTab: event.tabIndex,
      );
      emit(ProfileLoaded(updatedViewModel));
    }
  }

  void _onNavigateToService(NavigateToService event, Emitter<ProfileState> emit) {
    // Handle navigation logic here
  }
}