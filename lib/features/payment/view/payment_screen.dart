import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../di/dependency_injection.dart';
import '../bloc/payment_bloc.dart';
import 'payment_view.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<PaymentBloc>(),
      child: const PaymentView(),
    );
  }
}